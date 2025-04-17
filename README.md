# Nebula Navigator

![repo_cover_art](https://github.com/user-attachments/assets/487d8ce5-8b32-4d3d-9dd6-1cea75825c03)

---

## Overview

Nebula Navigator is an AI-powered interactive tool that transforms code repository analysis into an immersive 3D experience. By visualizing your code as a dynamic galaxy, the tool provides cutting-edge insights into code quality, structure, and dependencies. Its core features—such as vector terrain rendering using Perlin noise and real-time AI-driven analysis—enable seamless navigation and deep understanding of complex codebases.

For a non-technical description of NebulaNavigator it is the same as map orb in mobie version of Treasure Planet:

https://github.com/user-attachments/assets/64da5730-fbf6-4de0-9321-1b733eb20563

Unfortunatly, unlike its fictional muse it wont lead to treasure but instead leads to a more efficeint and proactive developement environment.

---

## Table of Contents

- [Nebula Navigator](#nebula-navigator)
  - [Overview](#overview)
  - [Table of Contents](#table-of-contents)
  - [Features](#features)
  - [Technology Stack](#technology-stack)
  - [Project Architecture](#project-architecture)
  - [Installation \& Setup](#installation--setup)
    - [Environment Setup (Windows)](#environment-setup-windows)
    - [Backend Setup](#backend-setup)
    - [Frontend Setup](#frontend-setup)
  - [Usage](#usage)
  - [Roadmap \& Future Enhancements](#roadmap--future-enhancements)
    - [ConfigureSetup.ps1](#configuresetupps1)
  - [License](#license)
  - [Contributing](#contributing)
  - [Contact](#contact)

---

## Features

- **Interactive 3D Visualization:**  
  Explore your repository as a richly detailed galaxy. Nodes (representing files or modules) and connections (dependencies) are rendered in real time, supporting fluid zooming, panning, and rotation.

- **AI-Driven Insights:**  
  Automatically analyze code quality, detect potential issues, and receive actionable recommendations.

- **Vector Terrain Generation:**  
  Use a Perlin noise algorithm to create a vector terrain overlay that abstractly represents repository health and activity density.

- **Responsive & Accessible UI:**  
  Designed to work seamlessly with mouse and touch inputs across devices.

- **Dynamic Data Integration:**  
  Live updates that reflect commit histories, file changes, and analysis results keep you in tune with your project's evolution.

---

## Technology Stack

- **Backend:**  
  - Python (Flask or FastAPI) for API endpoints and AI integration  
  - AI libraries (TensorFlow, PyTorch, or transformer-based models) for code analysis  
  - Third-party integrations for repository data (e.g., GitHub/GitLab APIs)

- **Frontend:**  
  - Three.js for 3D interactive visualizations  
  - HTML5, CSS3, and JavaScript (or React) for a modern, responsive UI  
  - Gesture libraries (e.g., Hammer.js) to support touch interfaces

- **Data Processing:**  
  - NumPy and the `noise` library for Perlin noise terrain generation

---

## Project Architecture

The project is divided into three core components:

1. **Backend API:**  
   - Aggregates repository data and processes AI analysis  
   - Exposes endpoints such as `/api/terrain` for vector terrain generation based on Perlin noise

2. **Visualization Engine:**  
   - Renders a 3D universe where each node represents code elements  
   - Handles smooth animations, sensor inputs (mouse/touch), and dynamic data updates

3. **User Interface:**  
   - Provides an intuitive control panel for filtering, searching, and settings adjustments  
   - Displays detailed overlays with repository insights when nodes are selected

For an in-depth architectural overview, refer to the [architecture documentation](docs/architecture.md)

---

## Installation & Setup

### Environment Setup (Windows)

**Important:** If you’re running this project on Windows, our deep Unity project structure may trigger file path length issues. To prevent this and ensure a smooth setup, use the provided PowerShell script:

1. **Run `ConfigurePathLength.ps1`:**
   - Double-click the script file to execute it.  
   - Alternatively, if PowerShell 7 is not installed, launch the script manually:  
     - Open PowerShell with administrative privileges.
     - Navigate to the repository folder:

       ```powershell
       cd path\to\NebulaNavigator
       ```

     - Execute the script:

       ```powershell
       .\ConfigurePathLength.ps1
       ```

 **Purpose**: This script updates registry settings, refreshes group policies, and optionally restarts your system to enable long file paths—a prerequisite for handling deeply nested structures.

**Important:** If you’re running this project on Windows, our deep Unity project structure may trigger file path length issues. To prevent this and ensure a smooth setup, use the provided PowerShell script:

1. **Run `ManageGitCommit.ps1`:**
   - Double-click the script file to execute it.  
   - Alternatively, if PowerShell 7 is not installed, launch the script manually:  
     - Open PowerShell with administrative privileges.
     - Navigate to the repository folder:

       ```powershell
       cd path\to\NebulaNavigator
       ```

     - Execute the script:

       ```powershell
       .\ManageGitCommit.ps1
       ```

 **Purpose**: Automates Git operations, including staging, committing, and pushing changes while enabling long path support.

- **Key Features**:
  - Configures Git settings to support long paths globally.
  - Prompts the user for commit messages.
  - Includes a countdown timer before resuming program execution.

### Backend Setup

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/Nathan-Busse/NebulaNavigator.git
   cd NebulaNavigator/src/backend
   ```

2. **Create and Activate a Virtual Environment:**

   ```bash
   python -m venv venv
   source venv/bin/activate      # On Windows: venv\Scripts\activate
   ```

3. **Install Dependencies:**

   ```bash
   pip install -r requirements.txt
   ```

4. **Run the Application:**

   ```bash
   python app.py
   ```

### Frontend Setup

1. **Open the Frontend:**  
   - Navigate to `src/frontend`.  
   - Open `index.html` in your preferred web browser (Chrome, Firefox, Edge, etc.).

---

## Usage

- **3D Exploration:**  
  Navigate the 3D galaxy using mouse drag or touch gestures. Zoom in on nodes to view details.

- **Data Visualization:**  
  See real-time updates as new commits or code modifications are processed.

- **AI Insights:**  
  Click on any node to bring up an overlay with detailed AI-generated code analysis, diagnostics, and recommendations.

- **Vector Terrain Overlay:**  
  Toggle the vector terrain overlay to interpret repository density and activity levels with visually engaging Perlin noise–generated graphics.

---

## Roadmap & Future Enhancements

### ConfigureSetup.ps1

- Combines Git and Windows long path configurations into a single script.
  - Runs Git operations (commit, push) and long path setup in sequence.
  - Includes countdown timer before resuming program execution.
  - Ensures administrative privileges and proper working directory management.

- **Enhanced AI Models:**  
  Further improve code quality assessment and anomaly detection.

- **Bi-Directional Views:**  
  Integrate both 3D and 2D modes for flexible analysis.

- **Collaboration Tools:**  
  Enable multi-user annotations and real-time collaboration within the visualization.

- **Extended Platform Support:**  
  Expand compatibility with additional version control and CI/CD platforms.

For more detailed plans, consult: (NebulaNavigator\docs\roadmap.md).

---

## License

Nebula Navigator is released under the [Nebula Navigator Professional License (NNPL) Version 1.0](LICENSE.md).

---

## Contributing

Contributions are welcome! Please review our [CONTRIBUTING.md](CONTRIBUTING.md) guidelines for details on the code of conduct, how to submit pull requests, and other development practices.

---

## Contact

For questions, suggestions, or further collaboration, please reach out to:

- **Name/Company:** Nathan Busse  
- **Email:** <bussenathan@icloud.com>  
- **GitHub:** [https://github.com/Nathan-Busse](https://github.com/Nathan-Busse)

---

Nebula Navigator – Transform your code repositories into an interactive universe of insights.
