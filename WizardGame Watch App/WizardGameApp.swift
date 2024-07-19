import SwiftUI
import CoreMotion
import WatchConnectivity
import WatchKit
import HealthKit
import AVFoundation

@main
struct WizardGame_Watch_App: App {
    @StateObject private var motionManager = MotionManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(motionManager)
        }
    }
}

class MotionManager: NSObject, ObservableObject, WCSessionDelegate, HKWorkoutSessionDelegate, HKLiveWorkoutBuilderDelegate {
    func workoutBuilderDidCollectEvent(_ workoutBuilder: HKLiveWorkoutBuilder) { }
    func workoutBuilder(_ workoutBuilder: HKLiveWorkoutBuilder, didCollectDataOf collectedTypes: Set<HKSampleType>) { }

    @Published var detectedMovement: String?
    private var session: WCSession
    private var motionManager = CMMotionManager()
    private var isMovementDetected = false
    private let healthStore = HKHealthStore()
    private var workoutSession: HKWorkoutSession?
    private var workoutBuilder: HKLiveWorkoutBuilder?
    private let movementBufferTime: TimeInterval = 1.5
    
    @Published var accelerationX: Double = 0.0
    @Published var accelerationY: Double = 0.0
    @Published var accelerationZ: Double = 0.0
    
    // Audio Players
    private var fireballPlayer: AVAudioPlayer?
    private var blizzardPlayer: AVAudioPlayer?
    private var lightningPlayer: AVAudioPlayer?
    private var healPlayer: AVAudioPlayer?

    override init() {
        self.session = WCSession.default
        super.init()
        self.session.delegate = self
        self.session.activate()
        startMotionUpdates()
        startWorkoutSession()
        initializeAudioPlayers()
    }

    private func initializeAudioPlayers() {
        fireballPlayer = createAudioPlayer(forResource: "Fire", withExtension: "mp3")
        blizzardPlayer = createAudioPlayer(forResource: "Blizzard", withExtension: "mp3")
        lightningPlayer = createAudioPlayer(forResource: "Thunder", withExtension: "mp3")
        healPlayer = createAudioPlayer(forResource: "Heal", withExtension: "mp3")
    }

    private func createAudioPlayer(forResource resource: String, withExtension ext: String) -> AVAudioPlayer? {
        guard let url = Bundle.main.url(forResource: resource, withExtension: ext) else {
            print("Failed to find audio file: \(resource).\(ext)")
            return nil
        }
        
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            return player
        } catch {
            print("Failed to initialize audio player for file: \(resource).\(ext)")
            return nil
        }
    }

    func startMotionUpdates() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startAccelerometerUpdates(to: .main) { (data, error) in
                guard let data = data else { return }
                self.handleMotionData(data)
            }
        }
    }

    func handleMotionData(_ data: CMAccelerometerData) {
        DispatchQueue.main.async {
            self.accelerationX = data.acceleration.x
            self.accelerationY = data.acceleration.y
            self.accelerationZ = data.acceleration.z
        }

        if !isMovementDetected {
            if checkMovement(data) {
                isMovementDetected = true
                startTimeout()
            }
        }
    }

    func checkMovement(_ data: CMAccelerometerData) -> Bool {
        let fireballThresholdY = 1.0
        let blizzardThresholdX = 1.0
        let lightningThresholdZ = 1.0
        let healThreshold = 0.5
        let lowerThreshold = 0.5

        if data.acceleration.y > fireballThresholdY && abs(data.acceleration.x) < lowerThreshold && abs(data.acceleration.z) < lowerThreshold {
            sendMovementData(type: "fireball", accuracy: min(1.0, data.acceleration.y / fireballThresholdY))
            print("fireball \n")
            print("x:\(accelerationX),y:\(accelerationY),z:\(accelerationZ) \n")
            playSound(for: "fireball")
            return true
            
            
        } else if data.acceleration.x > blizzardThresholdX && abs(data.acceleration.y) < lowerThreshold && abs(data.acceleration.z) < lowerThreshold {
            sendMovementData(type: "blizzard", accuracy: min(1.0, data.acceleration.x / blizzardThresholdX))
            print("blizzard \n")
            print("x:\(accelerationX),y:\(accelerationY),z:\(accelerationZ) \n")
            playSound(for: "blizzard")
            return true
            
            
        } else if data.acceleration.z > lightningThresholdZ && abs(data.acceleration.x) < lowerThreshold && abs(data.acceleration.y) < lowerThreshold {
            sendMovementData(type: "lightning", accuracy: min(1.0, data.acceleration.z / lightningThresholdZ))
            print("lightning \n")
            print("x:\(accelerationX),y:\(accelerationY),z:\(accelerationZ) \n")
            playSound(for: "lightning")
            return true
            
            
        } else if data.acceleration.x > healThreshold && data.acceleration.y > healThreshold && abs(data.acceleration.z) < lowerThreshold {
            sendMovementData(type: "heal", accuracy: min(1.0, (data.acceleration.x + data.acceleration.y) / (2 * healThreshold)))
            print("heal")
            print("x:\(accelerationX),y:\(accelerationY),z:\(accelerationZ)")
            playSound(for: "heal")
            return true
        }
        return false
    }

    func sendMovementData(type: String, accuracy: Double) {
        self.detectedMovement = type
        self.session.sendMessage(["movementType": type, "accuracy": accuracy], replyHandler: nil, errorHandler: { error in
            print("Failed to send \(type) accuracy data: \(error.localizedDescription)")
        })
    }


    private func playSound(for type: String) {
        switch type {
        case "fireball":
            fireballPlayer?.play()
        case "blizzard":
            blizzardPlayer?.play()
        case "lightning":
            lightningPlayer?.play()
        case "heal":
            healPlayer?.play()
        default:
            break
        }
    }

    func startTimeout() {
        DispatchQueue.main.asyncAfter(deadline: .now() + movementBufferTime) {
            self.isMovementDetected = false
        }
    }

    func startWorkoutSession() {
        guard HKHealthStore.isHealthDataAvailable() else { return }

        let typesToShare: Set = [HKQuantityType.workoutType()]
        let typesToRead: Set = [
            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
        ]
        
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { (success, error) in }

        let workoutConfiguration = HKWorkoutConfiguration()
        workoutConfiguration.activityType = .other
        workoutConfiguration.locationType = .unknown

        do {
            workoutSession = try HKWorkoutSession(healthStore: healthStore, configuration: workoutConfiguration)
            workoutBuilder = workoutSession?.associatedWorkoutBuilder()

            workoutSession?.delegate = self
            workoutBuilder?.delegate = self
            workoutBuilder?.dataSource = HKLiveWorkoutDataSource(healthStore: healthStore, workoutConfiguration: workoutConfiguration)

            workoutSession?.startActivity(with: Date())
            workoutBuilder?.beginCollection(withStart: Date(), completion: { (success, error) in
                // Handle errors if necessary
            })
        } catch {
            print("Failed to start workout session: \(error.localizedDescription)")
        }
    }

    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        print("Workout session failed with error: \(error.localizedDescription)")
    }

    func workoutSession(_ workoutSession: HKWorkoutSession, didGenerate event: HKWorkoutEvent) {
        // Handle workout events if necessary
    }

    func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState, from fromState: HKWorkoutSessionState, date: Date) {
        // Handle state changes if necessary
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Session activated")
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("Message received: \(message)")
    }

    func sessionReachabilityDidChange(_ session: WCSession) {
        print("Session reachability changed: \(session.isReachable)")
    }
}
