qr_code = [
    1 1 1 1 1 1 1 0 1 0 1 0 1 0 1
    1 0 0 0 0 0 1 0 0 0 1 1 1 1 1
    1 0 1 1 1 0 1 0 0 0 1 1 1 1 1
    1 0 1 1 1 0 1 0 0 1 1 0 0 1 1
    1 0 1 1 1 0 1 0 0 1 1 0 0 0 1
    1 0 0 0 0 0 1 0 1 1 0 0 1 0 1
    1 1 1 1 1 1 1 0 1 0 1 0 1 0 0
    0 0 0 0 0 0 0 0 0 0 0 1 0 0 1
    1 0 0 0 1 1 0 0 1 1 1 0 1 0 0
    0 0 0 1 1 1 0 0 1 0 1 0 1 1 1
    1 1 0 0 1 1 0 0 0 0 1 0 1 0 1
    0 0 1 0 0 1 1 1 0 0 1 1 0 1 0
    1 0 1 1 1 1 0 0 1 0 1 0 0 0 0
    0 0 1 1 0 1 1 1 1 1 0 0 1 0 1
    1 1 1 1 1 1 0 0 0 1 0 1 1 1 1
];

function [m] = led_matrix (x)

  result = x;

  a = result(1);
  b = result(2);
  c = result(3);
  d = result(4);
  e = result(5);
  f = result(6);
  g = result(7);
  h = result(8);

  z = 0;
  o = a & ~b & ~c & d & e & f & g & h;

  m = [
    a a a a a a a z o z o z o z o
    a b b b b b a z z z o o o o o
    a b d f e c a z z z o o o o o
    a b g h g c a z z o o z z o o
    a b e f d c a z z o o z z z o
    a b c c c c a z o o z z o z o
    a a a a a a a z o z o z o z z
    z z z z z z z z z z z o z z o
    o z z z o o z z o o o z o z z
    z z z o o o z z o z o z o o o
    o o z z o o z z z z o z o z o
    z z o z z o o o z z o o z o z
    o z o o o o z z o z o z z z z
    z z o o z o o o o o z z o z o
    o o o o o o z z z o z o o o o
  ];

end

function [] = show_output (x, m)
  m = led_matrix(x);

  clf;

  subplot(1, 2, 1);
  image(x + 1);
  colormap([[1 1 1]; [0 0 0]]);
  axis equal;
  title("Obfuscator output signals");

  subplot(1, 2, 2);
  image(m + 1);
  colormap([[1 1 1]; [0 0 0]]);
  axis square;
  title("LED matrix");
end

function [] = regenerate ()
  if rand() < 0.1
      x = [1 0 0 1 1 1 1 1]';
  else
      x = round(rand(8, 1));
  end
  show_output(x);
end

function [] = animate (times)
  for i = 1:times
      regenerate();
      pause(1);
  end
end
