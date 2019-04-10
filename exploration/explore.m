global qr_code;
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

  a = ~xor(x(1), x(2), x(3), x(4), x(5), x(6), x(7), x(8), x(9), x(10), x(11), x(12), x(13), x(14), x(15), x(16));

  h = x(1:8);
  l = x(9:16);
  b = [~h; l];

  z_indices = [
    % [ randperm(6, 4); ... ]
    5   8   3   7
    4   6   5   7
    5   6   8   4
    6   2   5   8
    6   5   4   7
    5   8   4   6
    7   2   4   5
    5   6   1   4
  ];

  o_indices = [
    % [ randperm(6, 4); ... ]
    8   6   5   1
    7   2   3   4
    6   8   1   4
    4   1   7   2
    3   4   7   1
    4   8   1   5
    4   1   3   8
    8   7   2   6
  ];

  zi = z_indices;
  oi = o_indices;
  z = xor(h(zi(:, 1)), h(zi(:, 2)), l(zi(:, 3)), l(zi(:, 4)));
  o = xor(h(oi(:, 1)), h(oi(:, 2)), h(oi(:, 3)), l(oi(:, 4)));

  m = [
    a     a     a     a     a     a     a     z(1) o(1) z(2) o(2) z(3) o(3) z(4) o(4)
    a     b(1)  b(2)  b(3)  b(4)  b(5)  a     z(5) z(6) z(7) o(5) o(6) o(7) o(8) o(1)
    a     b(16) a     a     a     b(6)  a     z(8) z(1) z(2) o(2) o(3) o(4) o(5) o(6)
    a     b(15) a     a     a     b(7)  a     z(3) z(4) o(7) o(8) z(5) z(6) o(1) o(2)
    a     b(14) a     a     a     b(8)  a     z(7) z(8) o(3) o(4) z(1) z(2) z(3) o(5)
    a     b(13) b(12) b(11) b(10) b(9)  a     z(4) o(6) o(7) z(5) z(6) o(8) z(7) o(1)
    a     a     a     a     a     a     a     z(8) o(2) z(1) o(3) z(2) o(4) z(3) z(4)
    z(5)  z(6)  z(7)  z(8)  z(1)  z(2)  z(3)  z(4) z(5) z(6) z(7) o(5) z(8) z(1) o(6)
    o(7)  z(2)  z(3)  z(4)  o(8)  o(1)  z(5)  z(6) o(2) o(3) o(4) z(7) o(5) z(8) z(1)
    z(2)  z(3)  z(4)  o(6)  o(7)  o(8)  z(5)  z(6) o(1) z(7) o(2) z(8) o(3) o(4) o(5)
    o(6)  o(7)  z(1)  z(2)  o(8)  o(1)  z(3)  z(4) z(5) z(6) o(2) z(7) o(3) z(8) o(4)
    z(1)  z(2)  o(5)  z(3)  z(4)  o(6)  o(7)  o(8) z(5) z(6) o(1) o(2) z(7) o(3) z(8)
    o(4)  z(1)  o(5)  o(6)  o(7)  o(8)  z(2)  z(3) o(1) z(4) o(2) z(5) z(6) z(7) z(8)
    z(1)  z(2)  o(3)  o(4)  z(3)  o(5)  o(6)  o(7) o(8) o(1) z(4) z(5) o(2) z(6) o(3)
    o(4)  o(5)  o(6)  o(7)  o(8)  o(1)  z(7)  z(8) z(1) o(2) z(2) o(3) o(4) o(5) o(6)
  ];

end

function [] = show_output (x, m)
  global qr_code
  m = led_matrix(x);

  clf;

  subplot(1, 3, 1);
  image(x' + 1);
  colormap([[1 1 1]; [0 0 0]]);
  axis image;
  title("Obfuscator output signals");

  subplot(1, 3, 2);
  image(m + 1);
  colormap([[1 1 1]; [0 0 0]]);
  axis image;
  title("LED matrix");

  subplot(1, 3, 3);
  imshow(ind2rgb((xor(m, qr_code) + 1), [[0 1 0]; [1 0 0]]));
  title("Correct pixels");
end

function [] = correct ()
  global x;
  x = [ones(8, 1); zeros(8, 1)];
  show_output(x);
end

function [] = regenerate ()
  global x;
  if rand() < 0.05
    x = [ones(8, 1); zeros(8, 1)];
  else
    x = round(rand(16, 1));
  end
  show_output(x);
end

function [] = flip_one ()
  global x;
  i = randperm(16, 1);
  x(i) = ~x(i);
  show_output(x);
end

function [] = animate (times)
  for i = 1:times
      regenerate();
      pause(1);
  end
end
