#!/usr/bin/env python3
"""Helper for flysystem eval scripts: add/remove a namespaced Flysystem scheme block in
settings.php. Only ever touches its own clearly-marked blocks; never edits anything else.

Usage (run with cwd = Drupal project root, i.e. /var/www/html):
  flysystem-settings-edit.py add <scheme> <root> <public 0|1>
  flysystem-settings-edit.py remove <scheme>
  flysystem-settings-edit.py has <scheme>   # exit 0 if present, 1 if not
"""
import sys, os, re

SETTINGS = "web/sites/default/settings.php"


def marker_begin(scheme):
    return f"// FLYSYSTEM_EVAL_BLOCK {scheme} BEGIN"


def marker_end(scheme):
    return f"// FLYSYSTEM_EVAL_BLOCK {scheme} END"


def read():
    with open(SETTINGS, "r") as f:
        return f.read()


def write(content):
    # Normalise the file to end with exactly one newline so repeated add/remove cycles
    # never accumulate trailing blank lines.
    content = content.rstrip("\n") + "\n"
    tmp = SETTINGS + ".flysystem_eval_tmp"
    with open(tmp, "w") as f:
        f.write(content)
    os.replace(tmp, SETTINGS)


def remove(scheme):
    content = read()
    b, e = re.escape(marker_begin(scheme)), re.escape(marker_end(scheme))
    # Remove the block (with a trailing newline) if present.
    pattern = re.compile(r"\n?" + b + r".*?" + e + r"\n?", re.DOTALL)
    new = pattern.sub("\n", content)
    if new != content:
        write(new)


def add(scheme, root, public):
    remove(scheme)  # idempotent: drop any previous copy first
    content = read().rstrip("\n") + "\n"
    pub = "TRUE" if str(public) == "1" else "FALSE"
    block = (
        "\n" + marker_begin(scheme) + "\n"
        + f"$settings['flysystem']['{scheme}'] = [\n"
        + "  'driver' => 'local',\n"
        + "  'config' => [\n"
        + f"    'root' => '{root}',\n"
        + f"    'public' => {pub},\n"
        + "  ],\n"
        + "];\n"
        + marker_end(scheme) + "\n"
    )
    write(content + block)


def has(scheme):
    return marker_begin(scheme) in read()


def main():
    if len(sys.argv) < 3:
        print("usage: add|remove|has <scheme> ...", file=sys.stderr)
        sys.exit(2)
    cmd, scheme = sys.argv[1], sys.argv[2]
    if cmd == "add":
        add(scheme, sys.argv[3], sys.argv[4])
    elif cmd == "remove":
        remove(scheme)
    elif cmd == "has":
        sys.exit(0 if has(scheme) else 1)
    else:
        print("unknown command", file=sys.stderr)
        sys.exit(2)


if __name__ == "__main__":
    main()
