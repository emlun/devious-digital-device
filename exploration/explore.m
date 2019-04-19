global qr_code;
global solution;
M = 1;
_ = 0;
qr_code = [
    M M M M M M M _ _ M M _ _ _ M M M M M M M
    M _ _ _ _ _ M _ _ _ M M M _ M _ _ _ _ _ M
    M _ M M M _ M _ _ M _ M _ _ M _ M M M _ M
    M _ M M M _ M _ M M _ _ _ _ M _ M M M _ M
    M _ M M M _ M _ M M _ M _ _ M _ M M M _ M
    M _ _ _ _ _ M _ _ M _ M M _ M _ _ _ _ _ M
    M M M M M M M _ M _ M _ M _ M M M M M M M
    _ _ _ _ _ _ _ _ _ M _ _ M _ _ _ _ _ _ _ _
    M M _ _ _ M M M _ _ _ M M _ _ _ M M _ _ _
    _ _ _ M _ M _ _ _ _ M _ _ M _ M M _ M _ _
    M _ M M M _ M M _ M M _ M M M _ _ M M M _
    M M M _ _ M _ M _ _ M _ M M _ _ _ M M M M
    _ M _ M M M M _ M _ _ M M M _ M M M _ _ M
    _ _ _ _ _ _ _ _ M _ M M M M M M M _ _ M M
    M M M M M M M _ M _ M _ M _ M _ _ M _ M _
    M _ _ _ _ _ M _ M _ _ M _ M M M M _ M _ M
    M _ M M M _ M _ _ _ M M _ _ M _ _ M _ M M
    M _ M M M _ M _ _ _ M M M M _ M M _ M _ _
    M _ M M M _ M _ _ _ _ _ M _ M _ M _ _ M M
    M _ _ _ _ _ M _ M M _ _ M _ _ M M M M _ _
    M M M M M M M _ M _ M _ M M M _ M M M M _
];

% randperm(16) >= 9
solution = [1 1 0 1 0 0 0 1 0 0 1 1 1 0 0 1]' == 1;

function [m] = led_matrix (x)
  global solution;

  h = x(solution == 1);
  l = x(solution == 0);

  a1 = xor(h(1), h(2), h(3), l(1), l(2), l(3));
  a2 = xor(h(4), h(5), h(6), l(4), l(5));
  a3 = ~xor(h(7), h(8), l(6), l(7), l(8));

  b = [~h; l];

  b1 = b(1);
  b2 = b(2);
  b3 = b(3);
  b4 = b(4);
  b5 = b(5);
  b6 = b(6);
  b7 = b(7);
  b8 = b(8);
  b9 = b(9);
  b10 = b(10);
  b11 = b(11);
  b12 = b(12);
  b13 = b(13);
  b14 = b(14);
  b15 = b(15);
  b16 = b(16);

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

  o1 = o(1);
  o2 = o(2);
  o3 = o(3);
  o4 = o(4);
  o5 = o(5);
  o6 = o(6);
  o7 = o(7);
  o8 = o(8);
  z1 = z(1);
  z2 = z(2);
  z3 = z(3);
  z4 = z(4);
  z5 = z(5);
  z6 = z(6);
  z7 = z(7);
  z8 = z(8);

  m = [
    a1 a1  a1  a1  a1  a1  a1 z1 z2 o1 o2 z3 z4 z5 a2 a2  a2  a2  a2  a2 a2
    a1 b1  b2  b3  b4  b5  a1 z6 z7 z8 o3 o4 o5 z1 a2 b13 b14 b15 b16 b1 a2
    a1 b16 a1  a1  a1  b6  a1 z2 z3 o6 z4 o7 z5 z6 a2 b12 a2  a2  a2  b2 a2
    a1 b15 a1  a1  a1  b7  a1 z7 o8 o1 z8 z1 z2 z3 a2 b11 a2  a2  a2  b3 a2
    a1 b14 a1  a1  a1  b8  a1 z4 o2 o3 z5 o4 z6 z7 a2 b10 a2  a2  a2  b4 a2
    a1 b13 b12 b11 b10 b9  a1 z8 z1 o5 z2 o6 o7 z3 a2 b9  b8  b7  b6  b5 a2
    a1 a1  a1  a1  a1  a1  a1 z4 o8 z5 o1 z6 o2 z7 a2 a2  a2  a2  a2  a2 a2
    z8 z1  z2  z3  z4  z5  z6 z7 z8 o3 z1 z2 o4 z3 z4 z5  z6  z7  z8  z1 z2
    o5 o6  z3  z4  z5  o7  o8 o1 z6 z7 z8 o2 o3 z1 z2 z3  o4  o5  z4  z5 z6
    z7 z8  z1  o6  z2  o7  z3 z4 z5 z6 o8 z7 z8 o1 z1 o2  o3  z2  o4  z3 z4
    o5 z5  o6  o7  o8  z6  o1 o2 z7 o3 o4 z8 o5 o6 o7 z1  z2  o8  o1  o2 z3
    o3 o4  o5  z4  z5  o6  z6 o7 z7 z8 o8 z1 o1 o2 z2 z3  z4  o3  o4  o5 o6
    z5 o7  z6  o8  o1  o2  o3 z7 o4 z8 z1 o5 o6 o7 z2 o8  o1  o2  z3  z4 o3
    z5 z6  z7  z8  z1  z2  z3 z4 o4 z5 o5 o6 o7 o8 o1 o2  o3  z6  z7  o4 o5
    a3 a3  a3  a3  a3  a3  a3 z8 o6 z1 o7 z2 o8 z3 o1 z4  z5  o2  z6  o3 z7
    a3 b5  b6  b7  b8  b9  a3 z8 o4 z1 z2 o5 z3 o6 o7 o8  o1  z4  o2  z5 o3
    a3 b4  a3  a3  a3  b10 a3 z6 z7 z8 o4 o5 z1 z2 o6 z3  z4  o7  z5  o8 o1
    a3 b3  a3  a3  a3  b11 a3 z6 z7 z8 o2 o3 o4 o5 z1 o6  o7  z2  o8  z3 z4
    a3 b2  a3  a3  a3  b12 a3 z5 z6 z7 z8 z1 o1 z2 o2 z3  o3  z4  z5  o4 o5
    a3 b1  b16 b15 b14 b13 a3 z6 o6 o7 z7 z8 o8 z1 z2 o1  o2  o3  o4  z3 z4
    a3 a3  a3  a3  a3  a3  a3 z5 o5 z6 o6 z7 o7 o8 o1 z8  o2  o3  o4  o5 z1
  ];

end

function [] = show_output (x)
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

function [new_state] = initial_state ()
  new_state = zeros(50, 1);
end

function [states] = simulate_output_sequence (T)
  states = initial_state();
  for t = 1:T
    states(:, t + 1) = advance_state(states(:, t));
  end
  clf;
  bar(states(33, :));
  xlabel('Time step');
  ylabel('O_0');
  yticks([0 1]);
end

function [new_state] = toggle_user_input_1 (state)
  new_state = [
    state(1:48);
    ~state(49);
    state(50);
  ];
end

function [new_state] = toggle_user_input_2 (state)
  new_state = [
    state(1:48);
    state(49);
    ~state(50);
  ];
end

function [fudger_internal, fudger_parouts, outputer_internal, outputer_parouts, ...
          user_input_1, user_input_2, fudger_input, outputer_input] = unpack_state (state)
  fudger_internal = state(1:8);
  fudger_parouts = state(9:16);
  outputer_internal = state(17:32);
  outputer_parouts = state(33:48);
  user_input_1 = state(49);
  user_input_2 = state(50);

  fudger_input = xor(~fudger_parouts(1), fudger_parouts(7));
  outputer_input = xor(user_input_1, fudger_parouts(8), fudger_internal(2));
end

function [new_state] = advance_state (state)
  [fudger_internal, fudger_parouts, outputer_internal, outputer_parouts, ...
   user_input_1, user_input_2, fudger_input, outputer_input] = unpack_state(state);

  new_fudger_internal = [
    fudger_input;
    fudger_internal(1:7);
  ];
  new_fudger_parouts = fudger_internal;

  new_outputer_internal = [
    outputer_input;
    outputer_internal(1:15);
  ];
  new_outputer_parouts = outputer_internal;

  new_state = [
    new_fudger_internal;
    new_fudger_parouts;
    new_outputer_internal;
    new_outputer_parouts;
    user_input_1;
    user_input_2;
  ];
end

function [] = show_state (state)
  [fudger_internal, fudger_parouts, outputer_internal, outputer_parouts, ...
   user_input_1, user_input_2, fudger_input, outputer_input] = unpack_state(state);

  clf;
  colormap default;

  subplot(1, 7, 1);
  barh(outputer_parouts);
  title("O(1:16)");
  yticks([1 4 8 9 13 16]);
  xticks([0 1]);

  subplot(1, 7, 2);
  barh(outputer_internal);
  title("O'(1:16)");
  yticks([1 4 8 9 13 16]);
  xticks([0 1]);

  subplot(1, 7, 3);
  barh([outputer_input, zeros(1, 15)]);
  title("DS_O");
  xticks([0 1]);

  subplot(1, 7, 4);
  barh([user_input_1, user_input_2]);
  title("u");
  xticks([0 1]);

  subplot(1, 7, 5);
  barh(fudger_parouts);
  title("F(1:8)");
  yticks([1 4 8]);
  xticks([0 1]);

  subplot(1, 7, 6);
  barh(fudger_internal);
  title("F'(1:8)");
  yticks([1 4 8]);
  xticks([0 1]);

  subplot(1, 7, 7);
  barh([fudger_input, zeros(1, 7)]);
  title("DS_F");
  xticks([0 1]);
end

function [nerr] = count_errors (x)
    global qr_code
    nerr = sum(sum(abs(qr_code - led_matrix(x))));
end

function [nerr] = count_anchor_errors (x)
    global qr_code
    m = led_matrix(x);
    nerr = sum(sum(abs(qr_code(1:7, 1:7) - m(1:7, 1:7))));
end

function [v] = dec2binv (x)
  v = [
    floor(x / 2^15)
    floor(mod(x, 2^15) / 2^14)
    floor(mod(x, 2^14) / 2^13)
    floor(mod(x, 2^13) / 2^12)
    floor(mod(x, 2^12) / 2^11)
    floor(mod(x, 2^11) / 2^10)
    floor(mod(x, 2^10) / 2^9)
    floor(mod(x, 2^9) / 2^8)
    floor(mod(x, 2^8) / 2^7)
    floor(mod(x, 2^7) / 2^6)
    floor(mod(x, 2^6) / 2^5)
    floor(mod(x, 2^5) / 2^4)
    floor(mod(x, 2^4) / 2^3)
    floor(mod(x, 2^3) / 2^2)
    floor(mod(x, 2^2) / 2^1)
    floor(mod(x, 2^1) / 2^0)
  ];
end

function [n_solutions] = count_solutions ()
    n_solutions = 0
    for i = 0:(2^16 - 1)
      if mod(i, 2^10) == 0
        disp(i);
      end
      x = dec2binv(i);
      if count_anchor_errors(x) == 0
        n_solutions += 1
        disp(x');
      end
    end
end

function [] = correct ()
  global x;
  global solution;
  x = solution;
  show_output(x);
end

function [] = regenerate ()
  global x;
  global solution;
  if rand() < 0.05
    x = solution;
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
