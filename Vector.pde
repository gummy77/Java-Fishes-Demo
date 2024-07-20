class vector2 {
  float x;
  float y;

  vector2(float _x, float _y) {
    this.x = _x;
    this.y = _y;
  }

  public vector2 add(vector2 other) {
    return new vector2(this.x += other.x, this.y += other.y);
  }
  public vector2 sub(vector2 other) {
    return new vector2(this.x -= other.x, this.y -= other.y);
  }
  public vector2 mult(vector2 other) {
    return new vector2(this.x *= other.x, this.y *= other.y);
  }
  public vector2 mult(float other) {
    return new vector2(this.x *= other, this.y *= other);
  }
  public vector2 power(float other) {
    return new vector2(pow(this.x, other), pow(this.y, other));
  }
  public float magnitude() {
    return sqrt((this.x*this.x) + (this.y*this.y));
  }
  public vector2 normalize() {
    float magnitude = this.magnitude();
    this.x /= magnitude;
    this.y /= magnitude;
    return this;
  }

  public float angle() {
    return atan2(this.y, this.x) * 57.29577;
  }

  public vector2 rotate(float degrees) {
    float sin = sin(-degrees * PI/180);
    float cos = cos(-degrees * PI/180);

    float x = (cos * this.x) - (sin * this.y);
    float y = (sin * this.x) + (cos * this.y);
    
    this.x = x;
    this.y = y;
    
    return this;
  }

  public vector2 tangent() {
    return new vector2(this.y, this.x);
  }

  public float dist(vector2 other) {
    return sqrt(sq(this.x - other.x) + sq(this.y - other.y));
  }

  public vector2 setMagnitude(float magnitude) {
    return this.normalize().mult(magnitude);
  }
  public vector2 clampMagnitude(float maxMagnitude) {
    float magnitude = this.magnitude();
    if (magnitude > maxMagnitude) {
      this.setMagnitude(maxMagnitude);
      return this;
    }
    return this;
  }

  public vector2 copy() {
    return new vector2(this.x, this.y);
  }
}
