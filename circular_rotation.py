import math
from fxpmath import Fxp

k = 1.6467603


def sign(a):
    return 1 if a >= 0 else -1


def get_exact_result(x0, y0, z0):
    x_final = k * (x0 * math.cos(z0) - y0 * math.sin(z0))
    y_final = k * (y0 * math.cos(z0) + x0 * math.sin(z0))
    z_final = 0

    return x_final, y_final, z_final


def rotate_circular(x0, y0, z0, word_length=16, frac_length=10, threshold=0.01, iterations=50):
    x_curr = Fxp(x0, signed=True, n_word=word_length, n_frac=frac_length)
    y_curr = Fxp(y0, signed=True, n_word=word_length, n_frac=frac_length)
    z_curr = Fxp(z0, signed=True, n_word=word_length, n_frac=frac_length)
    best_iter = 0
    threashold_satisfied = False
    for i in range(iterations):
        d = sign(z_curr)
        x_nxt = x_curr - d * y_curr * 2 ** (-i)
        y_nxt = y_curr + d * x_curr * 2 ** (-i)
        z_nxt = z_curr - d * math.atan(2 ** (-i))

        delta_x = abs(x_nxt.astype(float) - x_curr.astype(float))
        delta_y = abs(y_nxt.astype(float) - y_curr.astype(float))
        delta_z = abs(z_nxt.astype(float) - z_curr.astype(float))

        if delta_x <= threshold and delta_y <= threshold and delta_z <= threshold:
            # The previous iteration was as good as the current one (iter 0, 1, 2 => 3rd iter = 2 (3 is depicted))
            best_iter = i
            threashold_satisfied = True
            break

        print(
            f"Iteration {i}: X: {x_nxt.bin(frac_dot=True)} Y: {y_nxt.bin(frac_dot=True)} Z: {z_nxt.bin(frac_dot=True)}")
        x_curr = x_nxt
        y_curr = y_nxt
        z_curr = z_nxt

    if not threashold_satisfied:
        best_iter = i

    return x_curr, y_curr, z_curr, best_iter


x0 = 1
y0 = 0
z0 = math.pi / 4
result_x, result_y, result_z, best_iteration = rotate_circular(x0, y0, z0, word_length=16, frac_length=10, threshold=0,
                                                               iterations=30)
x_true, y_true, z_true = get_exact_result(x0, y0, z0)
print(f"Final X: {x_true}, Final Y: {y_true}, Final Z: {z_true}")
print(f"X: {result_x}, Y: {result_y}, Z: {result_z}, Best Iteration: {best_iteration}")
# atan_table = [Fxp(math.atan(2 ** (-i)), signed=True, n_word=16, n_frac=10) for i in range(20)]
# for i in atan_table:
#     print(i.bin())
