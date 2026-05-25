#include <Wire.h>
int16_t offset_ax = 573;
int16_t offset_ay = -82;
int16_t offset_az = -1065;

void setup() {
  Serial.begin(115200);
  Wire.begin();
  
  Wire.beginTransmission(0x68);
  Wire.write(0x6B);
  Wire.write(0x00);
  Wire.endTransmission(true);

  Serial.println("San sang!");
}

void loop() {
  if (Serial.available() > 0) {
    char cmd = Serial.read();
    if (cmd == 's' || cmd == 'S') {
      Serial.println("Dang lay 200 mau");
      
      float sum_ax = 0, sum_ay = 0, sum_az = 0;
      
      for(int i = 0; i < 200; i++) {
        Wire.beginTransmission(0x68);
        Wire.write(0x3B);
        Wire.endTransmission(false);
        Wire.requestFrom(0x68, 6, true);

        int16_t ax_raw = (Wire.read() << 8 | Wire.read()) - offset_ax;
        int16_t ay_raw = (Wire.read() << 8 | Wire.read()) - offset_ay;
        int16_t az_raw = (Wire.read() << 8 | Wire.read()) - offset_az;

        sum_ax += (ax_raw / 16384.0);
        sum_ay += (ay_raw / 16384.0);
        sum_az += (az_raw / 16384.0);
        
        delay(10);
      }

      float avg_ax = sum_ax / 200.0;
      float avg_ay = sum_ay / 200.0;
      float avg_az = sum_az / 200.0;

      Serial.println("Xong");
      Serial.print("Ax: "); Serial.println(avg_ax, 3);
      Serial.print("Ay: "); Serial.println(avg_ay, 3);
      Serial.print("Az: "); Serial.println(avg_az, 3);
    }
  }
}