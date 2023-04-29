PImage img;

void setup()
{
  size(512, 512, P3D);
  perspective(PI / 3, float(width) / float(height), 0.1, 1000);
  
  img = createImage(128, 128, RGB);
  noiseSeed(44);
  for (int x = 0; x < img.width; ++x)
  {
    for (int y = 0; y < img.height; ++y)
    {
      final float noiseScale = 0.02;
      float n = noise(x * noiseScale, y * noiseScale);
      
      colorMode(HSB, 1);
      color c = color(n, 1, 1);
      
      img.set(x, y, c);
    }
  }
}

float radian = 0;

void draw()
{
  //lights();
  //directionalLight(255, 255, 255, 1, 1, -1);
  
  final float r = img.width;
  float x = r * cos(radian) + img.width / 2.0;
  float z = r * sin(radian) + img.height / 2.0;
  radian += 0.03;
  camera(x, -img.width, z, img.width / 2.0, 0, img.height / 2.0, 0, 1, 0);

  colorMode(RGB, 1);
  background(0);
  
  display();
}

float maxHeight = 0;

void display()
{
  pushMatrix();
  
  textureMode(NORMAL);
  beginShape();
  texture(img);  
  for (int x = 0; x < img.width; ++x)
  {
    for (int z = 0; z < img.height; ++z)
    {
      colorMode(HSB, 1);
      float h = hue(img.get(x, z));
      float y = (h - maxHeight) < 0 ? 0 : -(h - maxHeight) * img.width;
      vertex(x, y, z, float(x) / img.width, float(z) / img.height);
    }
  }
  endShape();
  
  popMatrix();
  
  maxHeight += 0.001;
}
