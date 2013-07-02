int buffer;
int r,g,b;

void setup()
{
  Serial.begin(9600);
}
void loop()
{
  r = analogRead(2);
  r = map(r,0,1023,0,255);
  g = analogRead(1);
  g = map(g,0,1023,0,255);
  b = analogRead(0);
  b = map(b,0,1023,0,255);
  Serial.write('B');
 
  Serial.print(r,DEC);
  Serial.write(' ');
  Serial.print(g,DEC);
  Serial.write(' ');
  Serial.print(b,DEC);
  Serial.write(' ');
  
  Serial.write('\n');
  delay(150);
}
