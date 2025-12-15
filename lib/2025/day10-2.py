import numpy as np
from scipy.optimize import milp, LinearConstraint, Bounds

with open("lib/2025/test.txt") as f:
    content = f.read().strip().split("\n")
total_presses = 0
for line in content:
    parts = line.split(" ")
    switches = len(parts) - 2
    buttons = []
    for i in range(1, switches + 1):
        button_str = parts[i].strip("()")
        button = list(map(int, button_str.split(",")))
        buttons.append(button)
    joltage_str = parts[-1].strip("{}")
    joltage = list(map(int, joltage_str.split(",")))

    coefficient_matrix = []
    for i in range(len(joltage)):
        row = []
        for button in buttons:
            row.append(1 if i in button else 0)
        coefficient_matrix.append(row)

    A = np.array(coefficient_matrix)
    b = np.array(joltage)

    # Solve the integer linear programming problem to minimize total presses
    constraints = LinearConstraint(A, b, b)  # A*x = b (equality constraints)
    bounds = Bounds(0, np.inf)  # x >= 0

    # Use integer programming (integrality=1 means all variables are integers)
    res = milp(c=np.ones(switches), constraints=constraints, bounds=bounds, integrality=1)

    if res.success:
        # res.fun is already the optimal integer value
        presses_for_this_line = int(round(res.fun))
        total_presses += presses_for_this_line
        print(f"Line solution: {presses_for_this_line}, Running total: {total_presses}")
        print(f"Button presses: {[int(x) for x in res.x]}")
    else:
        print("No solution found for this line")
        print(f"A shape: {A.shape}, b shape: {b.shape}")
        print(f"A: {A}")
        print(f"b: {b}")
        break