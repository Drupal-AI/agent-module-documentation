#!/usr/bin/env python3
"""
scan-recent-releases.py — the cheap, incremental way to find modules that need a
doc refresh. Instead of polling release-history for all ~8,900 documented modules
(scan-new-minors.py --all), walk Drupal.org's GLOBAL release stream backwards from
the newest release and stop at a stored watermark. Only a handful of releases
happen per hour, so a routine run costs a few pages plus one confirming lookup per
real candidate — not thousands of requests.

Endpoint (JSON:API does not expose releases; the legacy api-d7 service does):

    https://www.drupal.org/api-d7/node.json?type=project_release
        &sort=created&direction=DESC&page=N          # 50 releases/page, newest first

Per-release fields we use:
    title                        -> "machine_name version"  (machine name = title minus version)
    field_release_version_major/minor
    field_release_version_extra  -> '' for stable; 'alpha2'/'rc1'/'dev' otherwise
    field_release_build_type     -> 'static' (tagged) vs 'dynamic' (dev branch)
    created                      -> unix ts; the watermark is the max created we've processed

The stream carries NO core-compatibility (taxonomy_vocabulary_7 is *Release type*:
New features / Bug fixes / Security update). So D11 is confirmed per-candidate with a
single release-history/<project>/current lookup — done only for releases that are a
new minor of a module we already document.

Watermark: scripts/.release-watermark holds the last max-created timestamp. First run
with no watermark scans --days back (default 30). Pass --no-update to avoid advancing it
(dry run). Output TSV matches scan-new-minors.py:
    <project>\t<branch-dir>\t<version>\t<dir-path>\t<reason>

Usage:
    scripts/scan-recent-releases.py                       # since watermark (or 30d)
    scripts/scan-recent-releases.py --days 7 --no-update  # dry-run last 7 days
    scripts/scan-recent-releases.py --out /tmp/recent.tsv
"""
import os
import re
import sys
import json
import time
import argparse
import urllib.request
import urllib.error
import xml.etree.ElementTree as ET

REPO_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MODULES_DIR = os.path.join(REPO_ROOT, "modules")
WATERMARK = os.path.join(REPO_ROOT, "scripts", ".release-watermark")
STREAM = ("https://www.drupal.org/api-d7/node.json"
          "?type=project_release&sort=created&direction=DESC&page={}")
FEED = "https://updates.drupal.org/release-history/{}/current"

ANY = -1
DIR_MAJOR_ONLY = re.compile(r"^(?:\d+\.x-)?(\d+)\.x$")
DIR_MINOR = re.compile(r"^(?:\d+\.x-)?(\d+)\.(\d+)\.x$")
STABLE_MODERN = re.compile(r"^(\d+)\.(\d+)\.\d+$")
STABLE_LEGACY = re.compile(r"^\d+\.x-(\d+)\.(\d+)$")


def get_json(url):
    req = urllib.request.Request(url, headers={"User-Agent": "module-documentor-scan/1"})
    for attempt in range(3):
        try:
            with urllib.request.urlopen(req, timeout=25) as r:
                return json.loads(r.read().decode("utf-8", "replace"))
        except (urllib.error.URLError, TimeoutError, OSError, json.JSONDecodeError):
            if attempt == 2:
                return None
            time.sleep(1.5)
    return None


def get_text(url):
    req = urllib.request.Request(url, headers={"User-Agent": "module-documentor-scan/1"})
    for attempt in range(2):
        try:
            with urllib.request.urlopen(req, timeout=25) as r:
                return r.read().decode("utf-8", "replace")
        except (urllib.error.URLError, TimeoutError, OSError):
            if attempt == 1:
                return None
    return None


def coverage(project):
    """major -> set of minors (ANY sentinel for major-only dirs); None if undocumented."""
    base = os.path.join(MODULES_DIR, project[:2], project)
    if not os.path.isdir(base):
        return None
    cov = {}
    for name in os.listdir(base):
        if name == "modules" or not os.path.isdir(os.path.join(base, name)):
            continue
        m = DIR_MINOR.match(name)
        if m:
            cov.setdefault(int(m.group(1)), set()).add(int(m.group(2)))
            continue
        mo = DIR_MAJOR_ONLY.match(name)
        if mo:
            cov.setdefault(int(mo.group(1)), set()).add(ANY)
    return cov


def d11_ok(cc):
    return bool(cc) and (bool(re.search(r"\b11\b", cc)) or "^11" in cc)


def confirm_d11_branch(project, maj, minr):
    """Return the newest D11 stable version string on branch maj.minr, or None."""
    xml = get_text(FEED.format(project))
    if not xml or "<error>" in xml:
        return None
    try:
        root = ET.fromstring(xml)
    except ET.ParseError:
        return None
    for rel in root.findall("./releases/release"):
        if (rel.findtext("status") or "") != "published":
            continue
        if not d11_ok(rel.findtext("core_compatibility") or ""):
            continue
        v = (rel.findtext("version") or "").strip()
        m = STABLE_MODERN.match(v) or STABLE_LEGACY.match(v)
        if m and int(m.group(1)) == maj and int(m.group(2)) == minr:
            return v  # newest-first, so first match on the branch is the latest
    return None


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--days", type=int, default=30, help="lookback when no watermark exists")
    ap.add_argument("--max-pages", type=int, default=200)
    ap.add_argument("--out")
    ap.add_argument("--no-update", action="store_true", help="don't advance the watermark")
    ap.add_argument("--set-watermark-now", action="store_true",
                    help="just stamp the watermark at the newest release and exit")
    args = ap.parse_args()

    since = None
    if os.path.exists(WATERMARK):
        try:
            since = int(open(WATERMARK).read().strip())
        except ValueError:
            since = None
    if since is None:
        since = int(time.time()) - args.days * 86400
        print(f"no watermark; scanning last {args.days} days (since {since})", file=sys.stderr)
    else:
        print(f"watermark: since {since}", file=sys.stderr)

    # candidate[(project, major)] = (minor, version_from_stream)  -- keep newest minor
    candidates = {}
    newest_created = since
    stop = False
    pages = 0
    for page in range(args.max_pages):
        data = get_json(STREAM.format(page))
        if not data or not data.get("list"):
            break
        pages += 1
        for r in data["list"]:
            created = int(r.get("created") or 0)
            newest_created = max(newest_created, created)
            if created <= since:
                stop = True
                break
            if r.get("field_release_build_type") != "static":
                continue
            if r.get("field_release_version_extra"):
                continue  # pre-release
            title = r.get("title", "")
            if " " not in title:
                continue
            project = title.rsplit(" ", 1)[0]
            maj, minr = r.get("field_release_version_major"), r.get("field_release_version_minor")
            if maj is None or minr is None:
                continue
            maj, minr = int(maj), int(minr)
            cov = coverage(project)
            if cov is None:
                continue  # not a module we document
            dm = cov.get(maj)
            if dm and (ANY in dm or minr <= max(dm)):
                continue  # already covered
            if not dm and maj <= (max(cov) if cov else -1):
                continue  # older major we chose not to document
            key = (project, maj)
            if key not in candidates or minr > candidates[key][0]:
                candidates[key] = (minr, r.get("field_release_version"))
        if stop or args.set_watermark_now:
            break

    if args.set_watermark_now:
        with open(WATERMARK, "w") as fh:
            fh.write(str(newest_created) + "\n")
        print(f"watermark set to {newest_created}", file=sys.stderr)
        return

    # confirm D11 for each candidate (one release-history call each) and emit
    out = open(args.out, "w") if args.out else sys.stdout
    emitted = 0
    for (project, maj), (minr, _stream_ver) in sorted(candidates.items()):
        ver = confirm_d11_branch(project, maj, minr)
        if not ver:
            print(f"skip: {project} {maj}.{minr}.x (not D11 stable per release-history)",
                  file=sys.stderr)
            continue
        cov = coverage(project) or {}
        reason = "new-minor" if maj in cov else "new-major"
        branch = f"{maj}.{minr}.x"
        out.write(f"{project}\t{branch}\t{ver}\tmodules/{project[:2]}/{project}/{branch}\t{reason}\n")
        emitted += 1
    if args.out:
        out.close()

    print(f"--- {pages} page(s), {len(candidates)} candidate(s), {emitted} confirmed D11 minor(s)",
          file=sys.stderr)
    if not args.no_update:
        with open(WATERMARK, "w") as fh:
            fh.write(str(newest_created) + "\n")
        print(f"watermark advanced to {newest_created}", file=sys.stderr)


if __name__ == "__main__":
    main()
