class Spine {
  vector2 position;
  vector2 velocity = new vector2(0, 0);
  vector2 acceleration = new vector2(0, 0);
  private float radius;

  Spine(float _radius, vector2 startingPosition) {
    this.radius = _radius;
    this.position = startingPosition;
    //this.velocity.add(new vector2(random(10.0) - 5, 0));
  }

  public void update() {
    this.velocity.mult(0.99);

    //this.acceleration.clampMagnitude(5);

    this.velocity.add(acceleration);
    this.position.add(this.velocity);

    this.checkWalls();

    acceleration = new vector2(0, 0);
  }

  public void render() {
    push();
    noStroke();
    fill(230);
    circle(this.position.x, height - this.position.y, this.radius);
    pop();
  }

  public void joinLink(Spine other, float chainLength) {

    vector2 vecFrom = this.position.copy().add(other.position.copy().mult(-1));
    vector2 setVecFrom = vecFrom.copy().setMagnitude(chainLength);
    vector2 targetVec = this.position.copy().add(setVecFrom.mult(-1));
    vector2 vecToTarget = other.position.copy().add(targetVec.copy().mult(-1)).mult(-1);

    vector2 OvecFrom = other.position.copy().add(this.position.copy().mult(-1));
    vector2 OsetVecFrom = OvecFrom.copy().setMagnitude(chainLength);
    vector2 OtargetVec = other.position.copy().add(OsetVecFrom.mult(-1));
    vector2 OvecToTarget = this.position.copy().add(OtargetVec.copy().mult(-1)).mult(-1);

    //vector2 otherPos = other.position.copy();

    //this.position = otherPos.copy().add(vecFrom);

    if (vecFrom.magnitude() > chainLength) {
      other.position = this.position.copy().add(setVecFrom);
      this.position = other.position.copy().add(OsetVecFrom);
    } else {
    }
    this.acceleration.add(OvecToTarget.mult(0.005));
    other.acceleration.add(vecToTarget.mult(0.005));
  }

  public void limitAngle(Spine spineA, Spine spineB, Spine spineC, float angleLimit) {
    vector2 vecIntoA = spineA.position.copy().sub(spineB.position.copy());
    vector2 vecIntoB = spineB.position.copy().sub(spineC.position.copy());
    vector2 vecAIntoB = spineB.position.copy().sub(spineA.position.copy());

    vector2 temp = vecIntoA.copy().sub(vecIntoB.copy()); //AAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
    float angleDiff = atan2(temp.y, temp.x) * 57.29577;

    println(angleDiff);

    if (angleDiff > angleLimit) {
      println("adjusting");
      spineB.position = spineA.position.copy().add(vecAIntoB.copy().rotate(angleLimit-1));
    } else if (angleDiff < -angleLimit) {
      println("adjusting");
      spineB.position = spineA.position.copy().add(vecAIntoB.copy().rotate(-angleLimit+1));
    }
  }

  private void checkWalls() {
    if ((this.position.x + this.radius/2) > width) {
      this.velocity.x = -this.velocity.x;
      this.position.x = width-this.radius/2;
    }
    if ((this.position.x - this.radius/2) < 0) {
      this.velocity.x = -this.velocity.x;
      this.position.x = this.radius/2;
    }
    if ((this.position.y + this.radius/2) > height) {
      this.velocity.y = -this.velocity.y;
      this.position.y = height-this.radius/2;
    }
    if ((this.position.y - this.radius/2) < 0) {
      this.velocity.y = -this.velocity.y;
      this.position.y = this.radius/2;
    }
  }
}
