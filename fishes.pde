
public Animal[] animals = new Animal[2];

float animalScale = 6;

void setup() {
  size(1300, 800);
  frameRate(50);

  for (int i = 0; i < animals.length; i++) {
    float sWidth = 10 * animalScale;
    animals[i] = new Animal(new float[]{0, sWidth, sWidth * 1.25, sWidth, sWidth, sWidth, sWidth, sWidth * 0.9, sWidth * 0.8, sWidth*0.7, sWidth*0.6, sWidth*0.5, 0});
    //animals[i] = new Animal(new float[]{sWidth, sWidth, sWidth, sWidth});
  }
}

void draw() {
  background(100);
  for (int i = 0; i < animals.length; i++) {
    animals[i].render();
  }
  background(100);
  for (int i = 0; i < animals.length; i++) {
    animals[i].update();
  }
  for (int i = 0; i < animals.length; i++) {
    animals[i].renderDebug();
  }
}
