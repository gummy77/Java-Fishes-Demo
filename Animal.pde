class Animal {
  private float[] bodysize;
  private ArrayList<Spine> spines;

  private float randomSeed;

  Animal(float[] _bodysize) {
    bodysize = _bodysize;
    this.spines = this.buildSpines();
    this.randomSeed = random(10000);
  }

  private ArrayList<Spine> buildSpines() {
    ArrayList<Spine> deltaSpines = new ArrayList<>();
    for (int i = 0; i < this.bodysize.length; i++) {
      deltaSpines.add(new Spine(this.bodysize[i], new vector2(width/2 + i * 7 * animalScale, height/2)));
    }
    return deltaSpines;
  }

  public void update() {
    for (int i = 0; i < this.spines.size(); i++) {
      Spine spine = this.spines.get(i);

      if (i == 0) {
        if (mousePressed) {
          spine.acceleration.add(spine.position.copy().add(new vector2(mouseX, height-mouseY).mult(-1)).mult(-0.002));
        } else {
          spine.acceleration.add(new vector2(noise(millis()/500f + this.randomSeed) - 0.475, noise(millis()/500f+this.randomSeed+500) - 0.475).mult(1));
        }
      }

      if (i != spines.size()-1) {
        spine.joinLink(this.spines.get(i+1), 7 * animalScale);
      }
      if (i != spines.size()-1 && i != 0) {
        spine.limitAngle(this.spines.get(i-1), spine, this.spines.get(i+1), 45);
      }
    }
    for (int i = 0; i < this.spines.size(); i++) {
      Spine spine = this.spines.get(i);
      spine.update();
    }
    println("WormDone\n");
  }

  public void render() {
    Spine lastSpine = spines.get(0);

    //vector2 lastRight = lastLeft;

    push();
    
    PShape body = createShape();
    body.beginShape();
    body.curveVertex(lastSpine.position.x, height - lastSpine.position.y);
  
    vector2[] side = new vector2[this.spines.size()-1];
  
    Spine spine = this.spines.get(1);

    strokeWeight(animalScale);
    strokeJoin(ROUND);
    stroke(255);

    for (int i = 1; i < this.spines.size(); i++) {
      spine = this.spines.get(i);

      vector2 vectorToSpine = spine.position.copy().sub(lastSpine.position);
      vector2 tangent = vectorToSpine.copy().tangent().normalize();

      //left
      vector2 left = new vector2(spine.position.x - tangent.x * spine.radius/2, spine.position.y + tangent.y * spine.radius/2);
      //line(left.x, height - left.y, lastLeft.x, height - lastLeft.y);
      side[i-1] = new vector2(left.x, height - left.y);
      //lastLeft = left;

      //right
      vector2 right = new vector2(spine.position.x + tangent.x * spine.radius/2, spine.position.y - tangent.y * spine.radius/2);
      //line(right.x, height - right.y, lastRight.x, height - lastRight.y);
      body.curveVertex(right.x, height - right.y);
      //lastRight = right;

      lastSpine = spine;
    }

    body.vertex(lastSpine.position.x, height - lastSpine.position.y);
    
    for(int i = side.length-1; i > 0; i--) {
      body.curveVertex(side[i].x, side[i].y);
    }
    
    body.endShape(CLOSE);
    
    shape(body, 0, 0);
    
    pop();
  }
}
