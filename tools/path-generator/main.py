import pygame
import numpy as np
from scipy.interpolate import splprep, splev

WIDTH = 344 + 23
HEIGHT = 255

INSIDE_X_MIN = 24
INSIDE_X_MAX = 344
INSIDE_Y_MIN = 29
INSIDE_Y_MAX = 230

points = []
drag_index = None
mirror = False

pygame.init()

# Scale things up so it's visible
screen = pygame.display.set_mode((WIDTH, HEIGHT))

BORDER_COLOR = (53, 40, 121)  # dark blue
SCREEN_COLOR = (108, 94, 181)  # light blue

# Fill border
screen.fill(BORDER_COLOR)

# Inner screen
inner_rect = pygame.Rect(
    INSIDE_X_MIN,
    INSIDE_Y_MIN,
    INSIDE_X_MAX - INSIDE_X_MIN,
    INSIDE_Y_MAX - INSIDE_Y_MIN,
)

pygame.display.set_caption("C64 Sprite Path Tool")

clock = pygame.time.Clock()


def get_points():
    if not mirror:
        return points

    mirrored = []
    for x, y in reversed(points):
        mx = WIDTH - 1 - x
        mirrored.append((mx, y))

    return points + mirrored


def generate_path():

    pts = get_points()

    if len(pts) < 2:
        return None

    arr = np.array(pts).T

    k = min(3, len(pts) - 1)
    tck, u = splprep(arr, s=0, k=k)

    u_new = np.linspace(0, 1, 256)
    out = splev(u_new, tck)

    xs = np.clip(np.array(out[0]), 0, WIDTH).astype(int)
    ys = np.clip(np.array(out[1]), 0, HEIGHT).astype(int)

    return xs, ys


def print_bytes(label, data):

    print(label)

    for i in range(0, len(data), 8):
        chunk = data[i : i + 8]
        line = ",".join(f"${v:02x}" for v in chunk)
        print(f"    .byte {line}")


def export(xs, ys):

    x_lo = []
    x_hi = []

    for x in xs:
        x_lo.append(x & 255)
        x_hi.append(1 if x > 255 else 0)

    print()
    print_bytes("pathx_lo:", x_lo)
    print()
    print_bytes("pathx_hi:", x_hi)
    print()
    print_bytes("pathy:", ys)
    print()


def find_point(pos):
    for i, p in enumerate(points):
        if abs(p[0] - pos[0]) < 6 and abs(p[1] - pos[1]) < 6:
            return i
    return None


running = True

while running:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

        if event.type == pygame.MOUSEBUTTONDOWN:
            pos = pygame.mouse.get_pos()

            if event.button == 1:
                idx = find_point(pos)

                if idx is not None:
                    drag_index = idx
                else:
                    if pos[0] < WIDTH and pos[1] < HEIGHT:
                        points.append(pos)

            if event.button == 3:
                idx = find_point(pos)

                if idx is not None:
                    points.pop(idx)

        if event.type == pygame.MOUSEBUTTONUP:
            drag_index = None

        if event.type == pygame.MOUSEMOTION and drag_index is not None:
            x, y = pygame.mouse.get_pos()

            x = max(0, min(WIDTH - 1, x))
            y = max(0, min(HEIGHT - 1, y))

            points[drag_index] = (x, y)

        if event.type == pygame.KEYDOWN:
            if event.key == pygame.K_e:
                result = generate_path()
                if result:
                    export(*result)

            if event.key == pygame.K_c:
                points.clear()

            if event.key == pygame.K_m:
                mirror = not mirror
                print("Mirror:", mirror)

    screen.fill(BORDER_COLOR)
    pygame.draw.rect(screen, SCREEN_COLOR, inner_rect)

    for p in points:
        pygame.draw.circle(screen, (255, 255, 255), p, 5)

    if mirror:
        for x, y in reversed(points):
            mx = WIDTH - 1 - x
            pygame.draw.circle(screen, (120, 120, 255), (mx, y), 5)

    result = generate_path()

    if result:
        xs, ys = result

        for i in range(len(xs) - 1):
            pygame.draw.line(
                screen, (0, 255, 0), (xs[i], ys[i]), (xs[i + 1], ys[i + 1]), 1
            )

    pygame.display.flip()
    clock.tick(60)

pygame.quit()
