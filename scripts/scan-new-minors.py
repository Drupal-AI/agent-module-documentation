#!/usr/bin/env python3
"""
scan-new-minors.py — find documented contrib modules that have a newer STABLE,
Drupal-11-compatible minor branch upstream than the one we have under modules/.

Data source: the Drupal.org release-history feed (the same endpoint core's
Update Status uses):

    https://updates.drupal.org/release-history/<project>/current

  * /current returns only the project's currently-supported branches, newest
    release first. Use it (not /all) so abandoned branches don't come back.
  * An unknown project returns an <error>...</error> body at HTTP 200, so we
    detect failure by the <error> tag, never the status code.

Two filters, both required by the task:
  * D11-only  — a release counts only if its <core_compatibility> allows ^11.
  * stable    — a minor counts only once it has a clean x.y.z (or legacy
                8.x-a.b) release; -alpha/-beta/-rc/-dev are ignored.

Matching the repo's dir naming is not a simple string build: the tree mixes
`3.x` (major-only branch), `3.0.x` (minor branch) and `8.x-1.x` (legacy). So we
model *coverage* instead of guessing a name. Each documented dir becomes either
(major, minor) or (major, ANY) — a major-only dir like `3.x`/`8.x-1.x` covers
every minor of that major. A gap is emitted when a D11 stable branch is newer
than what we cover:
  * project has some minor of major M documented -> emit every upstream minor > our max
  * project has a major-only dir for M          -> covered, nothing emitted
  * upstream ships a brand-new major above ours  -> emit just that major's newest minor

Output (stdout): TSV, one line per gap:
    <project>\t<branch-dir>\t<version>\t<dir-path>\t<reason>
Diagnostics and the summary go to stderr.

Usage:
    scripts/scan-new-minors.py <project...>
    scripts/scan-new-minors.py --list FILE      # one project per line (# comments ok)
    scripts/scan-new-minors.py --all            # every documented top-level module
    scripts/scan-new-minors.py --all --jobs 16 --out /tmp/new-minors.tsv
"""
import os
import re
import sys
import argparse
import urllib.request
import urllib.error
import xml.etree.ElementTree as ET
from concurrent.futures import ThreadPoolExecutor, as_completed

REPO_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MODULES_DIR = os.path.join(REPO_ROOT, "modules")
FEED = "https://updates.drupal.org/release-history/{}/current"

ANY = -1  # sentinel: a major-only dir covers every minor of that major

STABLE_MODERN = re.compile(r"^(\d+)\.(\d+)\.\d+$")        # 3.6.3
STABLE_LEGACY = re.compile(r"^\d+\.x-(\d+)\.(\d+)$")      # 8.x-1.23
DIR_MAJOR_ONLY = re.compile(r"^(?:\d+\.x-)?(\d+)\.x$")    # 3.x  or  8.x-1.x
DIR_MINOR = re.compile(r"^(?:\d+\.x-)?(\d+)\.(\d+)\.x$")  # 3.0.x or 8.x-1.23.x


def d11_ok(core_compat: str) -> bool:
    """True if a <core_compatibility> constraint admits Drupal 11."""
    if not core_compat:
        return False
    # constraints look like "^9.5 || ^10 || ^11" or "^10 || ^11" etc.
    return bool(re.search(r"\b11\b", core_compat)) or "^11" in core_compat


def stable_major_minor(version: str):
    m = STABLE_MODERN.match(version) or STABLE_LEGACY.match(version)
    if not m:
        return None
    return int(m.group(1)), int(m.group(2))


def fetch(project: str) -> str | None:
    url = FEED.format(project)
    req = urllib.request.Request(url, headers={"User-Agent": "module-documentor-scan/1"})
    for attempt in range(2):
        try:
            with urllib.request.urlopen(req, timeout=20) as r:
                return r.read().decode("utf-8", "replace")
        except (urllib.error.URLError, TimeoutError, OSError):
            if attempt == 1:
                return None
    return None


def documented_coverage(project: str):
    """Return dict major -> set of minors (ANY sentinel for major-only dirs)."""
    shard = project[:2]
    base = os.path.join(MODULES_DIR, shard, project)
    cov: dict[int, set[int]] = {}
    if not os.path.isdir(base):
        return cov
    for name in os.listdir(base):
        if name == "modules":  # submodules nest here; not this project's branches
            continue
        if not os.path.isdir(os.path.join(base, name)):
            continue
        mm = DIR_MINOR.match(name)
        if mm:
            cov.setdefault(int(mm.group(1)), set()).add(int(mm.group(2)))
            continue
        mo = DIR_MAJOR_ONLY.match(name)
        if mo:
            cov.setdefault(int(mo.group(1)), set()).add(ANY)
    return cov


def scan_one(project: str):
    """Return (list_of_gap_tuples, note). Gap tuple: (project, branch, version, dir, reason)."""
    xml = fetch(project)
    if xml is None:
        return [], f"skip: {project} (fetch failed)"
    if "<error>" in xml:
        return [], f"skip: {project} (no release history)"
    try:
        root = ET.fromstring(xml)
    except ET.ParseError:
        return [], f"skip: {project} (bad XML)"

    # newest D11 stable version per (major, minor); feed is newest-first so the
    # first version seen for a branch is the newest.
    latest: dict[tuple[int, int], str] = {}
    for rel in root.findall("./releases/release"):
        if (rel.findtext("status") or "") != "published":
            continue
        version = (rel.findtext("version") or "").strip()
        if not d11_ok(rel.findtext("core_compatibility") or ""):
            continue
        mm = stable_major_minor(version)
        if mm is None:
            continue
        latest.setdefault(mm, version)

    if not latest:
        return [], f"ok: {project} (no D11 stable release)"

    cov = documented_coverage(project)
    max_doc_major = max(cov) if cov else -1

    # group upstream minors by major
    by_major: dict[int, list[int]] = {}
    for (maj, minr) in latest:
        by_major.setdefault(maj, []).append(minr)

    shard = project[:2]
    gaps = []
    for maj, minors in by_major.items():
        minors.sort()
        doc_minors = cov.get(maj)
        if doc_minors and ANY in doc_minors:
            continue  # major-only dir covers the whole major
        if doc_minors:
            floor = max(doc_minors)
            new = [m for m in minors if m > floor]
            reason = "new-minor"
        else:
            # we have no branch for this major at all
            if maj <= max_doc_major:
                continue  # an older major we chose not to document; ignore
            new = [max(minors)]  # brand-new higher major: just its newest minor
            reason = "new-major"
        for m in new:
            branch = f"{maj}.{m}.x"
            version = latest[(maj, m)]
            dpath = f"modules/{shard}/{project}/{branch}"
            gaps.append((project, branch, version, dpath, reason))
    return gaps, None


def load_projects(args) -> list[str]:
    if args.all:
        out = []
        for shard in sorted(os.listdir(MODULES_DIR)):
            sp = os.path.join(MODULES_DIR, shard)
            if not os.path.isdir(sp):
                continue
            for proj in sorted(os.listdir(sp)):
                if os.path.isdir(os.path.join(sp, proj)):
                    out.append(proj)
        return sorted(set(out))
    if args.list:
        out = []
        with open(args.list) as fh:
            for line in fh:
                line = line.split("#", 1)[0].strip()
                if line:
                    out.append(line)
        return out
    return args.projects


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("projects", nargs="*")
    ap.add_argument("--list")
    ap.add_argument("--all", action="store_true")
    ap.add_argument("--jobs", type=int, default=12)
    ap.add_argument("--out", help="write TSV here (default: stdout)")
    args = ap.parse_args()

    projects = load_projects(args)
    if not projects:
        ap.error("no projects: pass names, --list FILE, or --all")

    out = open(args.out, "w") if args.out else sys.stdout
    total_gaps = 0
    scanned = 0
    with ThreadPoolExecutor(max_workers=args.jobs) as ex:
        futs = {ex.submit(scan_one, p): p for p in projects}
        for fut in as_completed(futs):
            gaps, note = fut.result()
            scanned += 1
            if note:
                if note.startswith("skip"):
                    print(note, file=sys.stderr)
            for g in gaps:
                out.write("\t".join(g) + "\n")
                total_gaps += 1
            if scanned % 500 == 0:
                print(f"... {scanned}/{len(projects)} scanned, {total_gaps} gaps",
                      file=sys.stderr)
    if args.out:
        out.close()
    print(f"--- scanned {scanned} projects; {total_gaps} new D11 stable minor(s)",
          file=sys.stderr)


if __name__ == "__main__":
    main()
