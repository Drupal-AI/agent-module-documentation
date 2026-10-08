#!/usr/bin/env python3
"""Print per-module dispatch context for a slice of the doc worklist.

For each worklist row in [start, start+count), emit a TSV line:
    project  new_branch  version  reason  src_path  template_dir  installed_version

- src_path: web/modules/contrib/<project> if present, else "-" (needs tarball).
- template_dir: newest existing modules/<sh>/<project>/<X.x> dir (excluding the
  new branch and the `modules` submodule dir), or "-" if none.
- installed_version: version: from the installed info.yml, or "-".

Usage: wave-context.py <start-line-1based> <count> [worklist.tsv]
"""
import os, sys, re

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
WEB = os.path.join(os.path.dirname(REPO), "web", "modules", "contrib")

def newest_template(sh, proj, new_branch):
    base = os.path.join(REPO, "modules", sh, proj)
    if not os.path.isdir(base):
        return "-"
    def key(n):
        m = re.match(r"^(?:\d+\.x-)?(\d+)\.(\d+)\.x$", n) or re.match(r"^(?:\d+\.x-)?(\d+)\.x$", n)
        if not m:
            return None
        return (int(m.group(1)), int(m.group(2)) if m.lastindex == 2 else -1)
    cands = []
    for n in os.listdir(base):
        if n in ("modules", new_branch) or not os.path.isdir(os.path.join(base, n)):
            continue
        k = key(n)
        if k:
            cands.append((k, n))
    if not cands:
        return "-"
    return "modules/%s/%s/%s" % (sh, proj, max(cands)[1])

def installed_version(proj):
    d = os.path.join(WEB, proj)
    if not os.path.isdir(d):
        return "-"
    for root, _, files in os.walk(d):
        for f in files:
            if f.endswith(".info.yml"):
                for line in open(os.path.join(root, f), errors="replace"):
                    m = re.match(r"^version:\s*['\"]?([^'\"]+)['\"]?\s*$", line)
                    if m:
                        return m.group(1)
    return "?"

def main():
    start, count = int(sys.argv[1]), int(sys.argv[2])
    wl = sys.argv[3] if len(sys.argv) > 3 else os.path.join(REPO, "scripts", ".doc-worklist.tsv")
    rows = [l.rstrip("\n").split("\t") for l in open(wl)]
    for proj, branch, ver, path, reason in rows[start-1:start-1+count]:
        sh = proj[:2]
        src = os.path.join(WEB, proj)
        src_disp = "web/modules/contrib/%s" % proj if os.path.isdir(src) else "-"
        tmpl = newest_template(sh, proj, branch)
        inst = installed_version(proj)
        print("\t".join([proj, branch, ver, reason, src_disp, tmpl, inst]))

if __name__ == "__main__":
    main()
