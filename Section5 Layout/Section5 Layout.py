import matplotlib.pyplot as plt
import matplotlib.patches as patches
import random

def draw_floor_layout(X, Y, H, W, d, a, b, ax, floor_title, elevator_count=2):
    """
    Draws the layout of rectangles on a floor within a larger rectangle, labeling the last `elevator_count` rectangles as elevators.

    :param X: List of x center coordinates of rectangles
    :param Y: List of y center coordinates of rectangles
    :param H: List of heights of rectangles
    :param W: List of widths of rectangles
    :param d: List of labels for the rectangles
    :param a: Width of the larger rectangle
    :param b: Height of the larger rectangle
    :param ax: The axes object where the rectangles will be drawn
    :param floor_title: The title for the floor
    :param elevator_count: The number of elevators on the floor
    """
    # Draw the larger rectangle centered at (0,0)
    larger_rect = patches.Rectangle((-a/2, -b/2), a, b, linewidth=1, edgecolor='r', facecolor='none')
    ax.add_patch(larger_rect)

    # Draw each rectangle
    for i, (x, y, h, w, label) in enumerate(zip(X, Y, H, W, d)):
        lower_left_x = x - w / 2
        lower_left_y = y - h / 2
        # Set the edge color
        edge_color = 'black' if i >= len(X) - elevator_count else 'blue'
        rect = patches.Rectangle((lower_left_x, lower_left_y), w, h, linewidth=2, edgecolor=edge_color, facecolor='none')
        ax.add_patch(rect)
        # Add a label in the center of each rectangle
        label_text = f"E {i - len(X) + elevator_count + 1}" if i >= len(X) - elevator_count else label
        ax.text(x, y, label_text, color='black', ha='center', va='center')

    ax.set_xlim(-a/2, a/2)
    ax.set_ylim(-b/2, b/2)
    ax.set_aspect('equal', adjustable='box')
    ax.set_title(floor_title)

def draw_floors_layout(X1, Y1, H1, W1, d1, X2, Y2, H2, W2, d2, a, b):
    fig, axs = plt.subplots(2, 1, figsize=(12, 6))
    plt.subplots_adjust(hspace=2)

    draw_floor_layout(X1, Y1, H1, W1, d1, a, b, axs[1], "Floor 1 Layout")
    draw_floor_layout(X2, Y2, H2, W2, d2, a, b, axs[0], "Floor 2 Layout")

    plt.tight_layout()
    plt.show()




a = 38
b = 12

Z1 = [0,0,1,0,0,0,0,1,0,1,1,0,0,1,1,1,1,0,1,0,1,1]
Z2 = [1,1,0,1,1,1,1,0,1,0,0,1,1,0,0,0,0,1,0,1,1,1]
H = [4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 5.4, 1.5, 3, 8, 4.5, 4.5, 6.4, 3, 3]
W = [5.5, 5.5, 2.75, 3.95, 2.4, 3.6, 3.6, 3.6, 2.75, 5.5, 2.75, 4.5, 4.5, 11, 9.1, 9.1, 12, 12, 11, 13.6, 3, 3]
X = [4.25, 13.7, 5.225 ,8.975, 4.45, -3.05, -3.6,  -3.45, 0.125, 1.1, -17.625, 1,   - 7.1,  0.25, -10.75 ,-10.75, 12.6,13,  -10.75,  -12.2, -10.85, -13.85]
Y = [3.75, 3.75, 1.65, 3.75,  -3.75, 0.75,  -3.75, 3.75,  3.75,  3.75, -3.75,  -0.7, 3.75, -3.3, 2.25,0,  -1,    -3.75,    -3.75,   -1.7,  4.5,    4.5]
'''
Z1 = [1,0,1,1,1,1,1,1,1,1,1,0,1,0,1,1,0,0,1,1,1,1]
Z2 = [0,1,0,0,0,0,0,0,0,0,0,1,0,1,0,0,1,1,0,0,1,1]
X=[9.55, 15.175, 29.9187, 25.6062, 27.9875, 20.7125, 2.9375, 17.0875, 22.4688, 13.675, 23.0938, 23.125, 5.8, 4.95, 13.675, 17.0875, 17.9, 8.6125, 8.4125, 30.75, 19.9375, 2.6125]
Y=[0,    0,      6,       6,       6,       6,       6,       0,       0,      0,        6,     0,       0,    6,      6,       6,     6,   0,      6,       0,     0,       0]
H=[6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,3,3]
W=[4.125,4.125,2.0625,2.9625,1.8,2.7,2.7,2.7,2.0625,4.125,2.0625,3.375,3.375,9.9,2.275,4.55,16,9,8.25,14.50666667,3,3]
'''


print(len(W))
print(len(H))
print(len(Y))
print(len(X))
X1 = []
Y1 = []
H1 = []
W1 = []
d1=[]

X2 = []
Y2 = []
H2 = []
W2 = []
d2=[]

for i in range(len(Z1)):
    if Z1[i] == 1:
        X1.append(X[i])
        Y1.append(Y[i])
        H1.append(H[i])
        W1.append(W[i])
        d1.append(i+1)

for i in range(len(Z1)):
    if Z2[i] == 1:
        X2.append(X[i])
        Y2.append(Y[i])
        H2.append(H[i])
        W2.append(W[i])
        d2.append(i+1)

print(d1)
print(d2)

draw_floors_layout(X1, Y1, H1, W1, d1, X2, Y2, H2, W2, d2, a, b)
