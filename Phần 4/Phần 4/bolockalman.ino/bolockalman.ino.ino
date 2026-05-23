#include <Wire.h>
#include <math.h>

int16_t offset_ax = 573;
int16_t offset_ay = -82;
int16_t offset_az = -1065;
float gyro_offset_x = 0;

float Q_angle = 0.001;
float Q_bias = 0.003;
float R_measure = 0.03;

float angle = 0;
float bias = 0;
float P[2][2] = {{0, 0}, {0, 0}};

unsigned long prev_time;

void setup() {
  Serial.begin(115200);
  Wire.begin();
  Wire.beginTransmission(0x68);
  Wire.write(0x6B);
  Wire.write(0x00);
  Wire.endTransmission(true);

  long sum_gx = 0;
  for (int i = 0; i < 500; i++) {
    Wire.beginTransmission(0x68);
    Wire.write(0x43);
    Wire.endTransmission(false);
    Wire.requestFrom(0x68, 2, true);
    sum_gx += Wire.read() << 8 | Wire.read();
    delay(10);
  }
  gyro_offset_x = (sum_gx / 500.0) / 131.0;
  prev_time = millis();
}

void loop() {
  Wire.beginTransmission(0x68);
  Wire.write(0x3B);
  Wire.endTransmission(false);
  Wire.requestFrom(0x68, 14, true);

  int16_t ax_raw = (Wire.read() << 8 | Wire.read()) - offset_ax;
  int16_t ay_raw = (Wire.read() << 8 | Wire.read()) - offset_ay;
  int16_t az_raw = (Wire.read() << 8 | Wire.read()) - offset_az;
  Wire.read(); Wire.read();
  int16_t gx_raw = Wire.read() << 8 | Wire.read();

  float ax = ax_raw / 16384.0;
  float ay = ay_raw / 16384.0;
  float az = az_raw / 16384.0;
  float gx = (gx_raw / 131.0) - gyro_offset_x;

  float acc_pitch = atan2(ay, az) * 180.0 / PI;

  unsigned long curr_time = millis();
  float dt = (curr_time - prev_time) / 1000.0;
  prev_time = curr_time;

  float rate = gx - bias;
  angle += dt * rate;

  P[0][0] += dt * (dt * P[1][1] - P[0][1] - P[1][0] + Q_angle);
  P[0][1] -= dt * P[1][1];
  P[1][0] -= dt * P[1][1];
  P[1][1] += Q_bias * dt;

  float S = P[0][0] + R_measure;
  float K[2];
  K[0] = P[0][0] / S;
  K[1] = P[1][0] / S;

  float y = acc_pitch - angle;
  angle += K[0] * y;
  bias += K[1] * y;

  float P00_temp = P[0][0];
  float P01_temp = P[0][1];

  P[0][0] -= K[0] * P00_temp;
  P[0][1] -= K[0] * P01_temp;
  P[1][0] -= K[1] * P00_temp;
  P[1][1] -= K[1] * P01_temp;

  Serial.print(acc_pitch); Serial.print(",");
  Serial.println(angle);

  delay(20);
}