#include <Wire.h>
#include <math.h>
int16_t offset_ax = -653; 
int16_t offset_ay = 464;
int16_t offset_az = -682;
float base_gx = 0, base_gy = 0, base_gz = 0;
float roll = 0.0;
float pitch = 0.0;
unsigned long lastTime;
float prev_lin_ax = 0.0, prev_lin_ay = 0.0, prev_lin_az = 0.0;
float hpf_ax = 0.0, hpf_ay = 0.0, hpf_az = 0.0;

void setup() {
  Serial.begin(115200);
  Wire.begin();
  Wire.beginTransmission(0x68);
  Wire.write(0x6B);
  Wire.write(0x00);
  Wire.endTransmission(true);
  Serial.println("Giu yen cam bien de Calibrate Gyro (1 giay)...");
  long sum_gx = 0, sum_gy = 0, sum_gz = 0;
  for (int i = 0; i < 500; i++) {
    Wire.beginTransmission(0x68);
    Wire.write(0x43);
    Wire.endTransmission(false);
    Wire.requestFrom(0x68, 6, true);
    sum_gx += (Wire.read() << 8 | Wire.read());
    sum_gy += (Wire.read() << 8 | Wire.read());
    sum_gz += (Wire.read() << 8 | Wire.read());
    delay(2);
  }
  base_gx = sum_gx / 500.0;
  base_gy = sum_gy / 500.0;
  base_gz = sum_gz / 500.0;
  Serial.println("Calibrate Xong!");

  lastTime = micros();
}

void loop() {
  unsigned long currentTime = micros();
  float dt = (currentTime - lastTime) / 1000000.0;
  
  if (dt >= 0.005) {
    lastTime = currentTime;
    Wire.beginTransmission(0x68);
    Wire.write(0x3B);
    Wire.endTransmission(false);
    Wire.requestFrom(0x68, 14, true);

    float ax = ((Wire.read() << 8 | Wire.read()) - offset_ax) / 16384.0;
    float ay = ((Wire.read() << 8 | Wire.read()) - offset_ay) / 16384.0;
    float az = ((Wire.read() << 8 | Wire.read()) - offset_az) / 16384.0;
    Wire.read(); Wire.read();
    float gx = ((Wire.read() << 8 | Wire.read()) - base_gx) / 131.0;
    float gy = ((Wire.read() << 8 | Wire.read()) - base_gy) / 131.0;
    float gx_rad = gx * M_PI / 180.0;
    float gy_rad = gy * M_PI / 180.0;
    float acc_roll = atan2(ay, az);
    float acc_pitch = atan2(-ax, sqrt(ay * ay + az * az));

    roll  = 0.96 * (roll + gx_rad * dt) + 0.04 * acc_roll;
    pitch = 0.96 * (pitch + gy_rad * dt) + 0.04 * acc_pitch;
    float grav_x = -sin(pitch);
    float grav_y = sin(roll) * cos(pitch);
    float grav_z = cos(roll) * cos(pitch);
    float lin_ax = ax - grav_x;
    float lin_ay = ay - grav_y;
    float lin_az = az - grav_z;
    hpf_ax = alpha * hpf_ax + alpha * (lin_ax - prev_lin_ax);
    hpf_ay = alpha * hpf_ay + alpha * (lin_ay - prev_lin_ay);
    hpf_az = alpha * hpf_az + alpha * (lin_az - prev_lin_az);
    prev_lin_ax = lin_ax;
    prev_lin_ay = lin_ay;
    prev_lin_az = lin_az;
    float total_accel = sqrt(hpf_ax * hpf_ax + hpf_ay * hpf_ay + hpf_az * hpf_az);
    Serial.print(lin_ax, 3); Serial.print(",");
    Serial.print(lin_ay, 3); Serial.print(",");
    Serial.print(lin_az, 3); Serial.print(",");
    Serial.println(total_accel, 3);
  }
  delay(5);
}