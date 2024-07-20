
public Animal[] animals = new Animal[50];

float animalScale = 1.5;

void setup() {
  size(1300, 800);
  frameRate(50);

  for (int i = 0; i < animals.length; i++) {
    float sWidth = 10 * animalScale;
    animals[i] = new Animal(new float[]{0, sWidth, sWidth * 1.25, sWidth * 3, sWidth * 1.2, sWidth * 1.2, sWidth, sWidth * 0.9, sWidth * 0.8, sWidth*0.7, sWidth*0.6, sWidth*2});
    //animals[i] = new Animal(new float[]{sWidth, sWidth, sWidth, sWidth});
  }
}

void draw() {
  background(120, 140, 170);
  for (int i = 0; i < animals.length; i++) {
    animals[i].update();
  }
  for (int i = 0; i < animals.length; i++) {
    animals[i].render();
  }
}
