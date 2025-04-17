from fastapi import FastAPI, HTTPException
import numpy as np
from noise import pnoise2

app = FastAPI(
    title="NebulaNavigator Backend API",
    description="API endpoints for code analysis and vector terrain generation for NebulaNavigator",
    version="1.0.0"
)

def generate_terrain(width: int, height: int, scale: float, octaves: int, persistence: float, lacunarity: float):
    """
    Generate a 2D terrain grid using Perlin noise.
    
    Args:
        width (int): The width of the terrain grid.
        height (int): The height of the terrain grid.
        scale (float): Determines the detail of the noise.
        octaves (int): Number of levels of detail.
        persistence (float): Amplitude of each octave.
        lacunarity (float): Frequency of each octave.
    
    Returns:
        A 2D list with noise values.
    """
    terrain = np.zeros((height, width))
    for i in range(height):
        for j in range(width):
            terrain[i][j] = pnoise2(j / scale, i / scale,
                                    octaves=octaves,
                                    persistence=persistence,
                                    lacunarity=lacunarity,
                                    repeatx=1024, repeaty=1024, base=42)
    return terrain.tolist()

@app.get("/")
def read_root():
    return {"message": "Welcome to the NebulaNavigator Backend API"}

@app.get("/api/terrain")
def get_terrain(width: int = 100, height: int = 100, scale: float = 50.0, 
                octaves: int = 6, persistence: float = 0.5, lacunarity: float = 2.0):
    """
    Generate a 2D terrain map using Perlin noise.
    
    Query Parameters:
      - width: Width of the terrain grid
      - height: Height of the terrain grid
      - scale: Scale factor for noise details
      - octaves: Number of octaves (detail levels)
      - persistence: Persistence value (amplitude modifier)
      - lacunarity: Lacunarity value (frequency modifier)
    
    Returns:
      A JSON object containing the generated terrain grid.
    """
    try:
        terrain = generate_terrain(width, height, scale, octaves, persistence, lacunarity)
        return {"terrain": terrain}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error generating terrain: {str(e)}")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("app:app", host="0.0.0.0", port=8000, reload=True)