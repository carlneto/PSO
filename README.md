# Particle Swarm Optimization Visualizer (SwiftUI)

## 1. Project Title
**Particle Swarm Optimization Visualizer**

## 2. Short Description
A SwiftUI-based interactive visualization of the **Particle Swarm Optimization (PSO)** algorithm, showing particle movement, convergence behaviour, and real-time fitness updates while optimizing the Rosenbrock function.

## 3. Requirements
- **macOS:** 13.0 or later  
- **Xcode:** 15.0 or later  
- **Swift:** 5.9 or later  
- **Frameworks:** SwiftUI, Combine

## 4. Installation
1. Clone the repository:
```bash
git clone https://github.com/carlneto/PSO.git
```

2. Open the project:

```bash
cd PSOVisualizer
open PSOVisualizer.xcodeproj
```
3. Build and run using Xcode.

## 5. Usage

1. Launch the application.
2. Click **“Start”** to initiate the PSO simulation.
3. Click **“Stop”** at any time to pause the algorithm.
4. The interface displays:

   * Current **best fitness** found
   * Number of **iterations**
   * A live **particle position map**

### Example SwiftUI Snippet

```swift
Button(isRunning ? "Stop" : "Start") {
    if isRunning {
        pso.stop()
    } else {
        pso.start()
    }
    isRunning.toggle()
}
```

## 6. Project Structure

```
PSOVisualizer/
├── App/
│   └── PSOApp.swift            // Application entry point
│
├── View/
│   └── ContentView.swift       // Main UI, particle rendering, controls
│
├── Model/
│   ├── PSO.swift               // Implementation of the PSO algorithm
│   └── Particle.swift          // Model representing individual particles
```

### Folder Overview

* **App/**
  Contains the SwiftUI application entry point (`PSOApp`).

* **View/**
  UI components, layout, and animation logic.

* **Model/**
  Core PSO logic, particle updates, fitness calculation, and swarm behaviour.

## 7. Main Features

* Real-time visualization of **Particle Swarm Optimization**
* Adjustable start/stop execution
* Animated particle movement in 2D space
* Built-in optimization target: **Rosenbrock ("banana") function**
* Live updates of:

  * Best swarm fitness
  * Iteration counter
* Clean SwiftUI architecture using `ObservableObject` and `@Published`

## 8. License (Summary)

This project uses a **Restricted Use License**, meaning:

* **Not open source.**
* **No modification, distribution, sublicensing, sharing, or commercial use** is allowed without prior written authorization.
* **Only personal, private, non-commercial evaluation use** is permitted.
* The author retains **all intellectual property rights**.
* The software is provided **“as is,” without any warranty**.
* Any violation results in **automatic termination** of granted permissions.

Refer to the full **LICENSE** file for complete terms.

## 9. Credits / Authors

Developed by **carlneto, 2025**
All rights reserved.
