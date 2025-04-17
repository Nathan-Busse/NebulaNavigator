~~~markdown
NebulaNavigator/
├── LICENSE
├── README.md
├── .gitignore
├── docs/
│   ├── architecture.md
│   ├── design_sketches.pdf
│   ├── demo_video.mp4
│   └── roadmap.md
├── src/
│   ├── backend/
│   │   ├── app.py            # Main entry point for FastAPI
│   │   ├── config.py         # Configuration settings
│   │   ├── requirements.txt  # Dependencies
│   │   ├── routes/           # API routes/endpoints
│   │   │   ├── __init__.py
│   │   │   ├── terrain.py
│   │   │   └── code_analysis.py
│   │   ├── models/           # Data models (if needed)
│   │   │   └── __init__.py
│   │   └── services/         # Business logic and utility services
│   │       └── __init__.py
│   └── frontend/
│       ├── index.html        # Main HTML entry point
│       ├── main.js           # JavaScript logic
│       ├── style.css         # Styling sheet
│       └── assets/           # Static assets
│           ├── images/
│           └── fonts/
├── unity/                    # Unity integration folder for immersive 3D visualization
│   └── NebulaNavigatorUnityProject/
└── tests/
    ├── test_backend.py      # Backend test cases
    └── test_frontend.js     # Frontend test cases

~~~
