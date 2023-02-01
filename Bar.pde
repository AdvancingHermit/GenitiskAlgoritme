class Bar {
  int x = 0;
  int y = height - 30;
  int barWidth = 12;
  float barHeight = 0;
  float barVal = 0;
  
  Bar(int x, float barHeight, float barVal){
    this.x = x;
    this.barHeight = barHeight;
    this.barVal = barVal;

  }
  void display(){
    fill(29, 184, 113);
    rect(x, y, barWidth, barHeight);
    fill(250);
      pushMatrix();
      textSize(14);
      translate(x, height - barVal * 0.3);
      float angle1 = radians(90);
      rotate(angle1);
      text((int)barVal, 0, 0);
      popMatrix();
  }
  
}
