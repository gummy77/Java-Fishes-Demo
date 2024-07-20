
public Animal[] animals = new Animal[1];

float animalScale = 7;

void setup() {
  size(1300, 800);
  frameRate(5);

  for (int i = 0; i < animals.length; i++) {
    float sWidth = 10 * animalScale;
    animals[i] = new Animal(new float[]{0, sWidth, sWidth * 1.25, sWidth, sWidth, sWidth, sWidth, sWidth * 0.9, sWidth * 0.8, sWidth*0.7, sWidth*0.6, sWidth*0.5, 0});
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
    animals[i].render();
  }
}
