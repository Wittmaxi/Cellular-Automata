final int cellAmount = 51;
final int iterAmount = 1300;
final int screenWidth = 2000;
final int screenHeight = 1300;
final int singleCellWidth = screenWidth / cellAmount;
final int singleCellHeight = screenHeight / iterAmount;

final short transitionRule = 0b01101110;

short[] cells;
int iteration = 0;

public void settings () {
    size (screenWidth, screenHeight);
}

void setup() {
    background (255);
    cells = new short[cellAmount];
    cells [25] = 1;

    fill (0);
    stroke (0);
}

short collectCellNeighbourHood (short cellIndex) {
    short r = 0;
    if (cellIndex > cellAmount - 1)
        throw new Error("CellIndex does not match");

    if (cellIndex <= 0) {
        r |= (cells[cellAmount - 1] & 1) << 2;
    } else {
        r |= (cells[cellIndex - 1] & 1) << 2;
    }

    r |= (cells[cellIndex] & 1) << 1; 

    if (cellIndex >= cellAmount -1)
        r |= (cells[0] & 1);
    else
        r |= (cells[cellIndex + 1] & 1);

    return r;
}

short singleCellTransition (short neighbourHood) {
    short tempTransRule = transitionRule;
    while (neighbourHood != 0) {
        neighbourHood --;
        tempTransRule = (short)(tempTransRule >> 1);
    }
    return (short)(tempTransRule & 1);
}

void transition() {
    short[] newCells = new short[cellAmount];
    for (short i = 0; i < cellAmount; i ++) {
        newCells [i] = singleCellTransition(collectCellNeighbourHood(i));
    }
    cells = newCells;
}

void draw() {
    if (iteration >= iterAmount) return;
    for (int i = 0; i < cellAmount; i++) {
        if (cells[i] != 0) {
            rect (singleCellWidth * i, singleCellHeight * iteration, singleCellWidth, singleCellHeight);
        }
    }
    transition();
    iteration ++;
}
