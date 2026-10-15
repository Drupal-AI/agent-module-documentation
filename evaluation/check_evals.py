#!/usr/bin/env python3
"""Check eval/dataset.yaml + rubrics.yaml (Eval Commons) before committing them.

Validates both files against the Eval Commons schemas and checks what the schemas
cannot: unique question ids, every rubric_ref resolves, every rubric is used, valid
mode/difficulty tags, verify only on execution cases, and that the scripts named in
setup/reset/verify/cleanup exist. Calls no model and runs no site.
"""
from __future__ import annotations

import argparse
from functools import lru_cache
import json
import os
from pathlib import Path
import sys

sys.dont_write_bytecode = True

import jsonschema
import yaml

REPO = Path(__file__).resolve().parents[1]
# The Eval Commons schemas ship with drupal/ai_best_practices, the same vendor dir
# run-matrix.py uses. ABP_EVALS overrides it.
COMMONS = Path(os.environ.get(
    "ABP_EVALS", REPO.parent / "vendor/drupal/ai_best_practices/evals"))
TAGS = {
    "mode": {"recipe", "introspection", "execution"},
    "difficulty": {"easy", "medium", "hard"},
}
SCRIPT_KEYS = ("setup", "reset", "verify", "cleanup")
# Script paths are relative to the project root, which holds this repo as
# agent-module-documentation/.
REPO_PREFIX = "agent-module-documentation/"


@lru_cache(maxsize=1)
def validators() -> tuple:
    result = []
    for name in ("dataset.schema.json", "rubric.schema.json"):
        schema = json.loads((COMMONS / "schema" / name).read_text(encoding="utf-8"))
        cls = jsonschema.validators.validator_for(schema)
        cls.check_schema(schema)
        result.append(cls(schema))
    return tuple(result)


def schema_errors(validator, document) -> list[str]:
    return [
        f"{'/'.join(map(str, e.absolute_path)) or '<root>'}: {e.message}"
        for e in validator.iter_errors(document)
    ]


def script_exists(path: str) -> bool:
    if path.startswith(REPO_PREFIX):
        return (REPO / path[len(REPO_PREFIX):]).is_file()
    return (REPO.parent / path).is_file()


def check(eval_dir: Path) -> tuple[int, list[str]]:
    dataset = yaml.safe_load((eval_dir / "dataset.yaml").read_text(encoding="utf-8"))
    rubric_doc = yaml.safe_load((eval_dir / "rubrics.yaml").read_text(encoding="utf-8"))
    if not isinstance(dataset, dict) or not isinstance(rubric_doc, dict):
        return 0, ["dataset.yaml and rubrics.yaml must each hold a mapping"]
    dataset_validator, rubric_validator = validators()
    problems = [f"dataset.yaml {e}" for e in schema_errors(dataset_validator, dataset)]
    rubrics = {}
    for rubric in rubric_doc.get("rubrics") or []:
        problems += [f"rubric {rubric.get('id')!r}: {e}"
                     for e in schema_errors(rubric_validator, rubric)]
        key = f"rubric/{rubric.get('id')}@{rubric.get('version')}"
        if key in rubrics:
            problems.append(f"duplicate rubric {key}")
        rubrics[key] = rubric
    if not rubrics:
        problems.append("rubrics.yaml has no rubrics")

    questions = dataset.get("questions") or []
    seen, used = set(), set()
    for q in questions:
        qid = q.get("id")
        if qid in seen:
            problems.append(f"duplicate question id {qid!r}")
        seen.add(qid)
        rubric = rubrics.get(q.get("rubric_ref"))
        if rubric is None:
            problems.append(f"{qid}: rubric_ref {q.get('rubric_ref')!r} not in rubrics.yaml")
        used.add(q.get("rubric_ref"))
        tags = dict(t.split(":", 1) for t in q.get("tags", []) if ":" in t)
        for name, allowed in TAGS.items():
            if name in tags and tags[name] not in allowed:
                problems.append(f"{qid}: unknown {name} {tags[name]!r}")
        meta = q.get("metadata") or {}
        for key in SCRIPT_KEYS:
            if key in meta and not script_exists(meta[key]):
                problems.append(f"{qid}: {key} script not found: {meta[key]}")
        commands = [c for c in (rubric or {}).get("checks", []) if c.get("kind") == "command"]
        if commands and tags.get("mode") != "execution":
            problems.append(f"{qid}: command checks belong to mode:execution cases")
        if meta.get("verify") and not commands:
            problems.append(f"{qid}: has verify but its rubric has no command check")
    for key in sorted(set(rubrics) - used):
        problems.append(f"rubric {key} is not used by any question")
    return len(questions), problems


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("paths", nargs="*", type=Path,
                        help="eval dirs or dataset.yaml files")
    parser.add_argument("--all", action="store_true")
    args = parser.parse_args()
    if args.all == bool(args.paths):
        parser.error("provide eval dirs or --all")
    if args.all:
        dirs = sorted(p.parent for p in (REPO / "modules").glob("**/eval/dataset.yaml"))
    else:
        dirs = [p.parent if p.name == "dataset.yaml" else p for p in args.paths]

    questions = failures = 0
    for eval_dir in dirs:
        try:
            count, problems = check(eval_dir)
        except Exception as exc:
            count, problems = 0, [str(exc)]
        questions += count
        if problems:
            failures += 1
            for problem in problems:
                print(f"FAIL {eval_dir}: {problem}", file=sys.stderr)
    if not dirs:
        failures += 1
        print("FAIL: no eval dirs found", file=sys.stderr)
    print(f"dirs={len(dirs)} questions={questions} failures={failures}")
    return 1 if failures else 0


if __name__ == "__main__":
    raise SystemExit(main())
