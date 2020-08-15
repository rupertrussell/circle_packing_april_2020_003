// Circle Packing v003
// by Rupert Russell 15 August 2020
// Thanks to: http://mattlockyer.com/multimediaprogramming/collisions.html
// https://www.redbubble.com/people/byron/journal/16056584-rb-image-dimensions-and-formats
// 5000×7100 pixels for the large print

String filename = "large_9411×9411_b.png";
int margin = 5; 
int maxCells = 40000; 
float minimumCellSize = 10;
int maximumCellSize = 900;
float currentCellSize = 0;
float startradius = 160; //
float shrink = 0.9;
float growAngle = 0;
float distanceBetweenCells = 0;
float cellSize[] = new float[maxCells];
int cellColourR[] = new int[maxCells];
int cellColourG[] = new int[maxCells];
int cellColourB[] = new int[maxCells];
PVector[] vectors = new PVector[maxCells];

void setup()
{
  size(9411, 9411);
  background(0);
  noLoop();

  for (int i = 0; i < vectors.length; i++) {
    vectors[i] = new PVector();
  }

  // initial central cell
  vectors[0].x = width/2;
  vectors[0].y = height/2;
  cellSize[0] = startradius;
}

void draw() {
  for (int i = 0; i < maxCells -1; i++) {

    cellColourR[i] = int(random(255));
    cellColourG[i] = int(random(255));
    cellColourB[i] = int(random(255));

    cellSize[i] = int(random(maximumCellSize));
    // make sure cells do not hit the edge of the frame
    vectors[i].x = random(width - cellSize[i] * margin) + cellSize[i] * margin / 2;
    vectors[i].y = random(height - cellSize[i] * margin) + cellSize[i] * margin / 2;

    // check for collision with any previous circle
    // if the distance between the center of the 
    // current circle and every other is less than the radius of 
    // the current circle and test circle current circle it will collide so shrink it and try again

    for (int j = 0; j < i; j++) {
      // check distance between current cell and each other cell (NOT self!)
      distanceBetweenCells = dist(vectors[i].x, vectors[i].y, vectors[j].x, vectors[j].y);
      // println("CellSize["+i+"] + cellSize["+j+"]  = " + cellSize[i] + cellSize[j] + " Distance between i "+i+ " and j "+ j + " = " + distanceBetweenCells); 

      if (cellSize[i] > 0) {
        while (cellSize[i] + cellSize[j] > distanceBetweenCells * 2) {
          cellSize[i] = cellSize[i] * shrink;
          if (cellSize[i] <= minimumCellSize ) {
            cellSize[i] = 0;
            break;
          }
        }
      }
    }
  }

  // draw each cell 

  for (int i = 0; i < vectors.length; i++) {
     currentCellSize = cellSize[i];

    for (float x = currentCellSize; x > 0; x = x - currentCellSize / 10) {
      noStroke();
      cellColourR[i] = cellColourR[i] - 10;
      cellColourG[i] = cellColourG[i] - 10;
      cellColourB[i] = cellColourB[i] - 10;
      fill(cellColourR[i], cellColourG[i], cellColourB[i]);
      ellipse(vectors[i].x, vectors[i].y, x, x);
    }
  }
  // println("New CellSize["+i+"] = " + cellSize[i]);
  //stroke(0);

  save(filename);
  print("saved");
  exit();
}
