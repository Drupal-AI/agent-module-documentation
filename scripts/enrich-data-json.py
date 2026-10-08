#!/usr/bin/env python3
"""
Enrich each module's data.json with DETERMINISTIC Drupal.org project metadata that our
install-time distillation does not capture — most importantly the real project-page
description (`body`), plus maintenance/development/security status and project dates.

Source: the same JSON:API feed AGENTS.md already uses, keyed by project machine name:
  https://www.drupal.org/jsonapi/node/project_module?filter[field_project_machine_name]=NAME

No module reinstall needed — this is pure metadata fetched by machine name.

Fields added (project-level; applied to every version dir + submodule of the project):
  project_description        plaintext of the project-page body (the "actual" description)
  maintenance_status         e.g. "Actively maintained"
  development_status         e.g. "Under active development"
  security_advisory_coverage e.g. "covered"
  project_created            YYYY-MM-DD
  project_changed            YYYY-MM-DD
  core_semver_minimum/_maximum  ints from the feed (e.g. 8000000 / 12000000)

Usage:
  # Backfill everything (skips already-enriched projects unless --force):
  python scripts/enrich-data-json.py --all

  # Going forward — enrich a single module right after documenting it:
  python scripts/enrich-data-json.py --dir modules/im/imagestyles
  python scripts/enrich-data-json.py --module imagestyles

  # Options: --limit N  --workers N  --sleep S  --force  --corpus PATH
"""
import argparse
import concurrent.futures as cf
import glob
import html
import json
import os
import re
import sys
import time
import urllib.parse
import urllib.request

JSONAPI = "https://www.drupal.org/jsonapi/node/project_module"
INCLUDES = "field_maintenance_status,field_development_status,field_module_categories"
UA = "module-documentor-enrich/1.0 (+https://www.drupal.org)"
DESC_CAP = 4000  # cap the stored plaintext body so data.json stays metadata-sized
ENRICH_KEY = "project_description"  # presence => already enriched


def log(*a):
    print(*a, file=sys.stderr, flush=True)


def html_to_text(s):
    s = re.sub(r"(?is)<(script|style).*?</\1>", " ", s or "")
    s = re.sub(r"(?i)<br\s*/?>", "\n", s)
    s = re.sub(r"(?i)</p\s*>", "\n\n", s)
    s = re.sub(r"<[^>]+>", " ", s)
    s = html.unescape(s)
    s = re.sub(r"[ \t]+", " ", s)
    s = re.sub(r"\n{3,}", "\n\n", s)
    return s.strip()


def fetch_project(name, sleep=0.15, retries=3):
    """Return the enrichment dict for a project machine name, or None if not found."""
    q = urllib.parse.urlencode({
        "filter[field_project_machine_name]": name,
        "include": INCLUDES,
    })
    url = f"{JSONAPI}?{q}"
    req = urllib.request.Request(url, headers={"User-Agent": UA,
                                               "Accept": "application/vnd.api+json"})
    last = None
    for attempt in range(retries):
        try:
            with urllib.request.urlopen(req, timeout=30) as r:
                j = json.load(r)
            break
        except Exception as e:  # network / 429 / 5xx
            last = e
            time.sleep(sleep * (2 ** attempt) + 0.5)
    else:
        log(f"  [warn] fetch failed for {name}: {last}")
        return None

    data = j.get("data") or []
    if not data:
        return None  # unknown project (custom module, renamed, etc.)
    d = data[0]
    a = d.get("attributes") or {}
    rel = d.get("relationships") or {}
    inc = {(i["type"], i["id"]): i for i in j.get("included", [])}

    def term(field):
        r = (rel.get(field) or {}).get("data")
        if not r:
            return None
        return (inc.get((r["type"], r["id"]), {}).get("attributes") or {}).get("name")

    body = (a.get("body") or {}).get("processed") or ""
    desc = html_to_text(body)
    if len(desc) > DESC_CAP:
        desc = desc[:DESC_CAP].rsplit(" ", 1)[0] + " …"

    out = {
        "project_description": desc,
        "maintenance_status": term("field_maintenance_status"),
        "development_status": term("field_development_status"),
        "security_advisory_coverage": a.get("field_security_advisory_coverage"),
        "project_created": (a.get("created") or "")[:10] or None,
        "project_changed": (a.get("changed") or "")[:10] or None,
        "core_semver_minimum": a.get("field_core_semver_minimum"),
        "core_semver_maximum": a.get("field_core_semver_maximum"),
    }
    time.sleep(sleep)
    return out


def project_of(data_path, corpus_root):
    """Project machine name = the dir right under the two-letter bucket."""
    rel = os.path.relpath(os.path.dirname(data_path), corpus_root)
    parts = rel.split(os.sep)
    return parts[1] if len(parts) >= 2 else None


def group_by_project(paths, corpus_root):
    groups = {}
    for p in paths:
        proj = project_of(p, corpus_root)
        if proj:
            groups.setdefault(proj, []).append(p)
    return groups


def already_enriched(paths):
    for p in paths:
        try:
            if ENRICH_KEY in json.load(open(p)):
                return True
        except (OSError, ValueError):
            pass
    return False


def write_fields(path, fields):
    try:
        with open(path, "r", encoding="utf-8") as fh:
            d = json.load(fh)
    except (OSError, ValueError) as e:
        log(f"  [warn] skip unreadable {path}: {e}")
        return False
    d.update(fields)
    with open(path, "w", encoding="utf-8") as fh:
        json.dump(d, fh, indent=2, ensure_ascii=False)
        fh.write("\n")
    return True


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--corpus", default=os.path.join(os.path.dirname(__file__), "..", "modules"))
    ap.add_argument("--all", action="store_true", help="enrich the whole corpus")
    ap.add_argument("--dir", help="enrich all data.json under this path (one module)")
    ap.add_argument("--module", help="enrich one project by machine name")
    ap.add_argument("--limit", type=int, default=None, help="first N projects (testing)")
    ap.add_argument("--workers", type=int, default=4)
    ap.add_argument("--sleep", type=float, default=0.15)
    ap.add_argument("--force", action="store_true", help="re-fetch already-enriched projects")
    args = ap.parse_args()
    corpus = os.path.abspath(args.corpus)

    if args.dir:
        root = os.path.abspath(args.dir)
        paths = glob.glob(os.path.join(root, "**", "data.json"), recursive=True)
    elif args.module:
        bucket = args.module[:2].lower()
        paths = glob.glob(os.path.join(corpus, bucket, args.module, "**", "data.json"),
                          recursive=True)
    elif args.all:
        paths = glob.glob(os.path.join(corpus, "**", "data.json"), recursive=True)
    else:
        ap.error("choose one of --all / --dir PATH / --module NAME")

    groups = group_by_project(paths, corpus)
    projects = sorted(groups)
    if not args.force:
        projects = [p for p in projects if not already_enriched(groups[p])]
    if args.limit:
        projects = projects[:args.limit]
    log(f"[enrich] {len(projects)} projects to fetch "
        f"({sum(len(groups[p]) for p in projects)} data.json files)")

    stats = {"ok": 0, "not_found": 0, "files": 0}

    def do(proj):
        fields = fetch_project(proj, sleep=args.sleep)
        if not fields:
            return proj, None, 0
        n = sum(1 for p in groups[proj] if write_fields(p, fields))
        return proj, fields, n

    with cf.ThreadPoolExecutor(max_workers=args.workers) as ex:
        for i, (proj, fields, n) in enumerate(ex.map(do, projects), 1):
            if fields is None:
                stats["not_found"] += 1
            else:
                stats["ok"] += 1
                stats["files"] += n
            if i % 100 == 0:
                log(f"  {i}/{len(projects)}  (ok={stats['ok']} "
                    f"not_found={stats['not_found']} files={stats['files']})")

    log(f"[done] enriched {stats['ok']} projects / {stats['files']} files; "
        f"{stats['not_found']} not found on drupal.org")


if __name__ == "__main__":
    main()
