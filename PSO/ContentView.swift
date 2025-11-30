import SwiftUI

struct ContentView: View {
   @State private var bestFitness: Double = .infinity
   @State private var iterations: Int = 0
   @State private var isRunning: Bool = false
   @ObservedObject private var pso = PSO()
   
   var body: some View {
      VStack {
         Text("Otimização por Enxame de Partículas")
            .font(.title)
         
         HStack {
            VStack {
               Text("Melhor Fitness: \(bestFitness, specifier: "%.4f")")
               Text("Iterações: \(iterations)")
            }
            
            Button(isRunning ? "Parar" : "Iniciar") {
               if isRunning {
                  pso.stop()
               } else {
                  pso.start()
               }
               isRunning.toggle()
            }
         }
         .padding()
         
         GeometryReader { geometry in
            ZStack {
               ForEach(pso.particles) { particle in
                  Circle()
                     .fill(Color.blue)
                     .frame(width: 10, height: 10)
                     .position(
                        x: CGFloat(particle.position[0]) * geometry.size.width,
                        y: CGFloat(particle.position[1]) * geometry.size.height
                     )
               }
            }
         }
      }
      .padding()
      .onReceive(pso.$bestFitness) { self.bestFitness = $0 }
      .onReceive(pso.$iterations) { self.iterations = $0 }
   }
}

class PSO: ObservableObject {
   @Published var particles: [Particle] = []
   @Published var bestFitness: Double = .infinity
   @Published var iterations: Int = 0
   
   private var timer: Timer?
   private let numParticles = 300 // 30
   private let dimensions = 5 // 2
   private let maxIterations = 500 // 1000
   private let c1: Double = 0.1 // 2.0
   private let c2: Double = 0.1 // 2.0
   private let w: Double = 0.07 // 0.7
   
   init() {
      initializeParticles()
   }
   
   func start() {
      timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
         self.iterate()
      }
   }
   
   func stop() {
      timer?.invalidate()
      timer = nil
   }
   
   private func initializeParticles() {
      particles = (0..<numParticles).map { _ in
         Particle(dimensions: dimensions)
      }
   }
   
   private func iterate() {
      guard iterations < maxIterations else {
         stop()
         return
      }
      
      for i in 0..<numParticles {
         let fitness = calculateFitness(particles[i].position)
         
         if fitness < particles[i].bestFitness {
            particles[i].bestPosition = particles[i].position
            particles[i].bestFitness = fitness
         }
         
         if fitness < bestFitness {
            bestFitness = fitness
         }
         
         updateVelocity(for: &particles[i])
         updatePosition(for: &particles[i])
      }
      
      iterations += 1
   }
   
   private func calculateFitness(_ position: [Double]) -> Double {
      // Função de Rosenbrock (função banana)
      let x = position[0]
      let y = position[1]
      return pow(1 - x, 2) + 100 * pow(y - x * x, 2)
   }
   
   private func updateVelocity(for particle: inout Particle) {
      for d in 0..<dimensions {
         let r1 = Double.random(in: 0...1)
         let r2 = Double.random(in: 0...1)
         
         particle.velocity[d] = w * particle.velocity[d] +
         c1 * r1 * (particle.bestPosition[d] - particle.position[d]) +
         c2 * r2 * (particles.min(by: { $0.bestFitness < $1.bestFitness })!.bestPosition[d] - particle.position[d])
      }
   }
   
   private func updatePosition(for particle: inout Particle) {
      for d in 0..<dimensions {
         particle.position[d] += particle.velocity[d]
         particle.position[d] = max(0, min(1, particle.position[d]))
      }
   }
}

struct Particle: Identifiable {
   let id = UUID()
   var position: [Double]
   var velocity: [Double]
   var bestPosition: [Double]
   var bestFitness: Double = .infinity
   
   init(dimensions: Int) {
      position = (0..<dimensions).map { _ in Double.random(in: 0...1) }
      velocity = (0..<dimensions).map { _ in Double.random(in: -0.1...0.1) }
      bestPosition = position
   }
}
