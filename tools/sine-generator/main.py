import math
import argparse
import matplotlib.pyplot as plt
import numpy as np

def generate_wave(start_angle, end_angle, count, amplitude, offset, degrees=True):
    """Generate one sine wave of a given sample count."""
    table = []
    # Since start and end values are the same, we generate one more item
    # to allow smooth rollback to start.
    for i in range(count):
        t = i / count + 1
        angle = start_angle + (end_angle - start_angle) * t
        if degrees:
            angle = math.radians(angle)
        value = math.sin(angle) * amplitude + offset
        table.append(value)
    return table


def combine_waves_cyclic(waves, out_count):
    """Add together multiple cyclic waves of differing lengths."""
    result = []
    for i in range(out_count):
        total = 0
        for wave in waves:
            total += wave[i % len(wave)]
        result.append(total)
    return result


def format_table(table, name:str, values_per_line=8):
    """Format a numeric table for assembler or plain output."""
    fmt_value = lambda v: f"${int(round(v)) & 0xFF:02X}"
    
    lines = [f"; {name}\n"]
    for i in range(0, len(table), values_per_line):
        chunk = table[i:i + values_per_line]
        line = "    .byte " + ",".join(fmt_value(v) for v in chunk)
        lines.append(line)

    if not any(x > 0xff for x in table):
        return lines
    
    lines.append("\n")
    lines.append(f"; {name} (upper bytes)\n")

    for i in range(0, len(table), values_per_line):
        chunk = table[i:i + values_per_line]
        line = "    .byte " + ",".join("1" if x > 0xff else "0" for x in chunk)
        lines.append(line)

    return "\n".join(lines)


def visualize(waves, combined=None):
    """Plot all waves smoothly and combined output."""
    plt.figure(figsize=(10, 5))

    # Plot individual waves as smooth lines
    for i, w in enumerate(waves):
        x = np.linspace(0, len(w)-1, 500)
        y = np.interp(x, range(len(w)), w)
        plt.plot(x, y, label=f"Wave {i+1} ({len(w)} samples)", alpha=0.6)
    
    # Plot combined wave
    if not combined is None:
        x_comb = np.linspace(0, len(combined)-1, 500)
        y_comb = np.interp(x_comb, range(len(combined)), combined)
        plt.plot(x_comb, y_comb, label="Combined", color="red", linewidth=2)

    plt.title("Sine Table Visualization")
    plt.xlabel("Sample Index")
    plt.ylabel("Value")
    plt.grid(True, linestyle=":")
    plt.legend()
    plt.tight_layout()
    plt.show()


def main():
    parser = argparse.ArgumentParser(description="Generate sine tables for C64 demo effects.")
    parser.add_argument("--wave", action="append", required=True,
                        help="Define a wave as start,end,amplitude,offset[,length]. Can be repeated.")
    parser.add_argument("--count", type=int, default=64, help="Number of samples in the combined output (default: 64).")
    parser.add_argument("--degrees", action="store_true", help="Interpret angles as degrees (default).")
    parser.add_argument("--radians", action="store_true", help="Interpret angles as radians.")
    parser.add_argument("--assembler", action="store_true", help="Output as assembler-formatted .byte lines.")
    parser.add_argument("--values-per-line", type=int, default=8, help="Values per .byte line (default: 8).")
    parser.add_argument("--hex", action="store_true", help="Output values as hexadecimal (e.g. $FF).")
    parser.add_argument("--plot", action="store_true", help="Display a matplotlib visualization of the sine table.")

    args = parser.parse_args()
    degrees = not args.radians

    # Parse and generate each wave
    waves = []
    for idx, wdef in enumerate(args.wave):
        parts = wdef.split(",")
        if len(parts) < 4:
            parser.error(f"Invalid wave definition: {wdef}. Use start,end,amplitude,offset[,length]")
        start, end, amp, offs = map(float, parts[:4])
        length = int(parts[4]) if len(parts) >= 5 else args.count
        wave = generate_wave(start, end, length, amp, offs, degrees)
        waves.append(wave)

        # Output each individual wave table
        print(format_table(
            wave,
            name=f"Wave {idx+1}",
            values_per_line=args.values_per_line
        ))
        print()

    if len(waves) > 1:
        # Combine all waves additively
        combined = combine_waves_cyclic(waves, args.count)

        # Output the combined wave
        print(format_table(
            combined,
            name="Combined",
            values_per_line=args.values_per_line
        ))

    # Optional plot
    if args.plot:
        if not 'combined' in vars():
            visualize(waves)
        else:
            visualize(waves, combined)


if __name__ == "__main__":
    main()
