#!/usr/bin/env python3
"""Scan documented modules for drupal.org support status.

For every distinct documented project (modules/<sh>/<project>/), fetch
    https://updates.drupal.org/release-history/<project>/current
and read the project-level <project_status>. drupal.org sets this to
"unsupported" when a project is no longer maintained/security-covered; a
missing project (404-ish error body) means the project was removed from
drupal.org entirely. Both are removal candidates.

Output TSV (scripts/.unsupported-scan.tsv):  <project>\t<verdict>\t<detail>
  verdict in: unsupported | gone | published | error
  detail: supported_branches (published) / error text / http status

Usage: scan-unsupported.py [--workers N] [--limit N] [--only <file-of-projects>]
"""
import os, sys, re, concurrent.futures as cf, urllib.request, urllib.error

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
FEED = "https://updates.drupal.org/release-history/{}/current"
OUT = os.path.join(REPO, "scripts", ".unsupported-scan.tsv")
UA = {"User-Agent": "module-documentor-support-scan/1.0"}

def projects():
    base = os.path.join(REPO, "modules")
    seen = set()
    for sh in sorted(os.listdir(base)):
        shd = os.path.join(base, sh)
        if not os.path.isdir(shd):
            continue
        for p in os.listdir(shd):
            if os.path.isdir(os.path.join(shd, p)):
                seen.add(p)
    return sorted(seen)

def classify(project):
    url = FEED.format(project)
    try:
        req = urllib.request.Request(url, headers=UA)
        with urllib.request.urlopen(req, timeout=25) as r:
            body = r.read().decode("utf-8", "replace")
    except urllib.error.HTTPError as e:
        return (project, "gone", f"http{e.code}")
    except Exception as e:
        return (project, "error", str(e)[:60])
    # drupal.org returns a 200 with <error>No release history ...</error> for unknown projects
    if "<error>" in body:
        m = re.search(r"<error>(.*?)</error>", body, re.S)
        return (project, "gone", (m.group(1).strip()[:60] if m else "error-body"))
    ms = re.search(r"<project_status>(.*?)</project_status>", body)
    status = ms.group(1).strip() if ms else "?"
    mb = re.search(r"<supported_branches>(.*?)</supported_branches>", body)
    branches = (mb.group(1).strip() if mb else "")
    if status == "unsupported":
        return (project, "unsupported", f"branches={branches or '-'}")
    if status == "published":
        # published but with NO supported branch = every branch is unsupported
        if mb is not None and branches == "":
            return (project, "unsupported", "no-supported-branch")
        return (project, "published", f"branches={branches or '?'}")
    return (project, "error", f"status={status}")

def main():
    workers = 10; limit = None; only = None
    a = sys.argv[1:]
    while a:
        t = a.pop(0)
        if t == "--workers": workers = int(a.pop(0))
        elif t == "--limit": limit = int(a.pop(0))
        elif t == "--only": only = a.pop(0)
    if only:
        projs = [l.strip() for l in open(only) if l.strip()]
    else:
        projs = projects()
    if limit: projs = projs[:limit]
    total = len(projs)
    rows = []
    done = 0
    with cf.ThreadPoolExecutor(max_workers=workers) as ex:
        for res in ex.map(classify, projs):
            rows.append(res); done += 1
            if done % 250 == 0:
                sys.stderr.write(f"  {done}/{total}\n"); sys.stderr.flush()
    rows.sort(key=lambda r: (r[1], r[0]))
    with open(OUT, "w") as f:
        for p, v, d in rows:
            f.write(f"{p}\t{v}\t{d}\n")
    from collections import Counter
    c = Counter(v for _, v, _ in rows)
    sys.stderr.write(f"--- {total} projects scanned. " + ", ".join(f"{k}={c[k]}" for k in sorted(c)) + f"\n--- written {OUT}\n")

if __name__ == "__main__":
    main()
