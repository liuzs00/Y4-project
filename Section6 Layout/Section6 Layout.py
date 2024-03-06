import matplotlib.pyplot as plt
import matplotlib.patches as patches
import random


def draw_floor_layout(X, Y, H, W, d, a, b,m, ax, floor_title, elevator_count=2):
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
    #larger_rect_lower_left_x = 0  # Since the center is a/2, the left edge would be at 0 for the larger rectangle
    #larger_rect_lower_left_y = -b/(2*m)  # Lower edge given the center is at b/4
    #larger_rect = patches.Rectangle((larger_rect_lower_left_x, larger_rect_lower_left_y), a, b, linewidth=1, edgecolor='r', facecolor='none')
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

    ax.set_xlim(0, a)
    ax.set_ylim(-b/(2*m), b-b/(2*m))
    #ax.set_xlim(-50, )
    #ax.set_ylim(-15, 15)
    ax.set_aspect('equal', adjustable='box')
    ax.set_title(floor_title)

def draw_floors_layout(X1, Y1, H1, W1, d1, X2, Y2, H2, W2, d2, a, b, m1,m2):
    fig, axs = plt.subplots(2, 1, figsize=(12, 6))
    plt.subplots_adjust(hspace=2)
    draw_floor_layout(X1, Y1, H1, W1, d1, a, b,m1, axs[1], "Floor 1 Layout")
    draw_floor_layout(X2, Y2, H2, W2, d2, a, b,m2, axs[0], "Floor 2 Layout")
    plt.tight_layout()
    plt.show()





a = 38
b = 12

"""
Z1 = [1,0,1,1,1,1,1,1,1,1,1,0,1,0,1,1,0,0,1,1,1,1]
Z2 = [0,1,0,0,0,0,0,0,0,0,0,1,0,1,0,0,1,1,0,0,1,1]
X=[9.55, 15.175, 29.9187, 25.6062, 27.9875, 20.7125, 2.9375, 17.0875, 22.4688, 13.675, 23.0938, 23.125, 5.8, 4.95, 13.675, 17.0875, 17.9, 8.6125, 8.4125, 30.75, 19.9375, 2.6125]
Y=[0,    0,      6,       6,       6,       6,       6,       0,       0,      0,        6,     0,       0,    6,      6,       6,     6,   0,      6,       0,     0,       0]
H=[6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,3,3]
W=[4.125,4.125,2.0625,2.9625,1.8,2.7,2.7,2.7,2.0625,4.125,2.0625,3.375,3.375,9.9,2.275,4.55,16,9,8.25,14.50666667,3,3]
"""

"""
Z1 = [1,0,1,1,1,1,1,1,1,1,1,0,1,0,1,1,0,0,1,1,1,1]
Z2 = [0,1,0,0,0,0,0,0,0,0,0,1,0,1,0,0,1,1,0,0,1,1]
X= [11.7563, 3.09375, 30.2113, 31.4719, 4.8375, 26.6394, 35.7188, 17.3063, 13.7344, 17.9438, 27.7031, 16.9688, 6.13125, 7.6875, 22.7428, 22.7438, 24.1875, 7.6875, 30.6375, 13.7344, 7.6875, 10.6875]
Y=[0,4,8,4,4,8,4,4,4,0,4,0,0,8,0,4,4,0,0,8,4,4]
H=[4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,3,3]
W=[6.1875,6.1875,3.09375,4.44375,2.7,4.05,4.05,4.05,3.09375,6.1875,3.09375,5.0625,5.0625,14.85,3.4125,6.825,24,13.5,12.375,21.76,3,3]


Z1 = [1,0,1,1,1,1,1,1,1,1,1,0,1,0,1,1,0,0,1,1,1,1]
Z2 = [0,1,0,0,0,0,0,0,0,0,0,1,0,1,0,0,1,1,0,0,1,1]
X = [15.05, 4.1, 33.5225, 29.9715, 10.265, 28.19, 36.38, 19.49, 16.6325, 20, 31.0475, 15.5, 13.37, 18.515, 23.84, 23.84, 9.6, 8.075, 30.155, 19.49, 11.075, 8.075]
Y = [10,10,5,0,5,5,5,5,5,10,5,5,5,10,10,5,0,5,10,0,10,10]
H = [5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,3,3]
W = [ 4.95,4.95,2.475,3.555,2.16,3.24,3.24,3.24,2.475,4.95,2.475,4.05,4.05,11.88,2.73,5.46,19.2,10.8,9.9,17.408,3,3]

"""
Z1 = [1,0,1,1,1,1,1,1,1,1,1,0,1,0,1,1,0,0,1,1,1,1]
Z2 = [0,1,0,0,0,0,0,0,0,0,0,1,0,1,0,0,1,1,0,0,1,1]
X=[12.4063, 11.375, 34.8269, 31.0581, 6.425, 28.8313, 35.975, 17.9563, 14.3844, 18.5938, 32.4031, 25.025, 10.3063, 18.3875, 23.3938, 23.3938, 17.3125, 4.8125, 31.2875, 17.9563, 4.8125, 7.8125]
Y=[0,0,8,8,4,4,4,4,4,0,4,0,4,0,0,4,6,6,0,8,0,0]
H=[4,6,4,4,4,4,4,4,4,4,4,6,4,6,4,4,6,6,4,4,3,3]
W=[6.1875,4.125,3.09375,4.44375,2.7,4.05,4.05,4.05,3.09375,6.1875,3.09375,3.375,5.0625,9.9,3.4125,6.825,16,9,12.375,21.76,3,3]


m1=3
m2=2
print(len(X))
print(len(Y))
print(len(H))
print(len(W))
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

draw_floors_layout(X1, Y1, H1, W1, d1, X2, Y2, H2, W2, d2, a, b,m1,m2)


