#!/usr/bin/env python3
"""Convert module evals to Commons YAML without changing existing files."""
from __future__ import annotations

import argparse
from contextlib import ExitStack
from functools import lru_cache
import json
import os
from pathlib import Path
import re
import sys

sys.dont_write_bytecode = True

import jsonschema
import yaml

REPO = Path(__file__).resolve().parents[1]
# The Eval Commons schemas and scorer ship with drupal/ai_best_practices, the
# same vendor dir run-matrix.py already uses. ABP_EVALS overrides it.
COMMONS = Path(os.environ.get(
    "ABP_EVALS", REPO.parent / "vendor/drupal/ai_best_practices/evals"))
# Informational top-level keys are carried into dataset metadata verbatim.
TOP_KEYS = {
    "module", "version", "skill_name", "skill_file", "note", "evals",
    "part_of", "submodule", "name", "data_name", "skipped",
}
STRING_TOP_KEYS = {"module", "version", "skill_name", "skill_file", "note"}
CASE_KEYS = {
    "id", "mode", "difficulty", "persona", "prompt", "expected_output",
    "must_contain_any", "must_not_contain", "setup", "reset", "verify", "cleanup",
    "difficulty_note", "note",
}
TEXT_KEYS = ("must_contain_any", "must_not_contain")
METADATA_KEYS = (
    "persona", "setup", "reset", "cleanup", "verify", "difficulty_note", "note",
)


def fail(path: Path, case_id: object, message: str) -> None:
    raise ValueError(f"{path}: case {case_id!r}: {message}")


def load_source(path: Path) -> dict:
    try:
        data = json.loads(path.read_text(encoding="utf-8"))
    except (OSError, ValueError) as exc:
        fail(path, "<top-level>", str(exc))
    if not isinstance(data, dict):
        fail(path, "<top-level>", "expected an object")
    unknown = sorted(set(data) - TOP_KEYS)
    if unknown:
        fail(path, "<top-level>", f"unsupported legacy key(s): {', '.join(unknown)}")
    if not isinstance(data.get("evals"), list) or not data["evals"]:
        fail(path, "<top-level>", "evals must be a nonempty list")
    for key in STRING_TOP_KEYS:
        if key in data and not isinstance(data[key], str):
            fail(path, "<top-level>", f"{key} must be a string")
    if not data.get("module"):
        fail(path, "<top-level>", "module must be a nonempty string")
    return data


def validate_case(case: dict, path: Path) -> None:
    if not isinstance(case, dict):
        fail(path, "<unknown>", "case must be an object")
    qid = case.get("id", "<missing id>")
    unknown = sorted(set(case) - CASE_KEYS)
    if unknown:
        fail(path, qid, f"unsupported legacy key(s): {', '.join(unknown)}")
    for key in ("id", "prompt"):
        if not isinstance(case.get(key), str) or not case[key]:
            fail(path, qid, f"{key} must be a nonempty string")
    for key in CASE_KEYS - set(TEXT_KEYS) - {"id", "prompt"}:
        if key in case and not isinstance(case[key], str):
            fail(path, qid, f"{key} must be a string")
    for key in TEXT_KEYS:
        if key in case and (
            not isinstance(case[key], list)
            or any(not isinstance(value, str) for value in case[key])
        ):
            fail(path, qid, f"{key} must be a list of strings")
    if "mode" in case and case["mode"] not in {
        "recipe", "introspection", "execution",
    }:
        fail(path, qid, f"unsupported mode: {case['mode']!r}")
    if case.get("verify") and case.get("mode") != "execution":
        fail(path, qid, "verify on a non-execution case has ambiguous mapping")


def identifier(value: str) -> str:
    value = re.sub(r"[^a-z0-9]+", "_", value.lower()).strip("_")
    return value if value and value[0].isalpha() else f"module_{value}"


def build(path: Path, data: dict) -> tuple[dict, list[dict]]:
    bundle = identifier(data["module"])
    questions, rubrics = [], []
    question_ids, rubric_ids = set(), set()
    for case in data["evals"]:
        validate_case(case, path)
        qid = case["id"]
        rid = identifier(f"{bundle}_{qid}")
        if qid in question_ids or rid in rubric_ids:
            fail(path, qid, f"duplicate question id or normalized rubric id {rid!r}")
        question_ids.add(qid)
        rubric_ids.add(rid)

        metadata = {key: case[key] for key in METADATA_KEYS if key in case}
        checks = []
        # This condition exactly follows run-matrix.py's grading dispatch.
        if case.get("mode") == "execution" and case.get("verify"):
            checks.append({
                "kind": "command",
                "command": "bash {{ metadata.verify }}",
                "expect": "exit_zero",
                "sandbox": "ddev",
            })
            unused = {key: case[key] for key in TEXT_KEYS if key in case}
            if unused:
                metadata["unused_text_checks"] = unused
        else:
            # Match abp's migrator: omit empty lists and retain its default
            # case-insensitive semantics. Parity reports the legacy difference.
            for key in TEXT_KEYS:
                if case.get(key):
                    checks.append({"kind": key, "values": case[key]})
        if not checks:
            fail(path, qid, "no gradable checks; cannot build a Commons rubric")

        question = {
            "id": qid,
            "input": case["prompt"],
            "criteria": case.get("expected_output", ""),
            "bundle": bundle,
            "rubric_ref": f"rubric/{rid}@1.0",
        }
        tags = [
            f"{key}:{case[key]}" for key in ("mode", "difficulty") if key in case
        ]
        if tags:
            question["tags"] = tags
        if metadata:
            question["metadata"] = metadata
        questions.append(question)
        rubrics.append({
            "id": rid,
            "version": "1.0",
            "applicable_bundles": [bundle],
            "checks": checks,
            "scoring": {"combine": "all_pass"},
        })

    # Dataset-level metadata uses the schema's additionalProperties: true.
    # Preserve these source strings verbatim; bundle is only a normalized label.
    dataset = {
        "metadata": {key: value for key, value in data.items() if key != "evals"},
        "questions": questions,
    }
    return dataset, rubrics


@lru_cache(maxsize=1)
def validators() -> tuple:
    result = []
    for name in ("dataset.schema.json", "rubric.schema.json"):
        schema = json.loads((COMMONS / "schema" / name).read_text(encoding="utf-8"))
        cls = jsonschema.validators.validator_for(schema)
        cls.check_schema(schema)
        result.append(cls(schema))
    return tuple(result)


def validate(path: Path, dataset: dict, rubrics: list[dict]) -> None:
    dataset_validator, rubric_validator = validators()
    try:
        dataset_validator.validate(dataset)
    except jsonschema.ValidationError as exc:
        location = list(exc.absolute_path)
        qid = "<dataset>"
        if len(location) >= 2 and location[0] == "questions":
            qid = dataset["questions"][location[1]]["id"]
        fail(path, qid, f"dataset schema: {exc.message}")
    for question, rubric in zip(dataset["questions"], rubrics):
        try:
            rubric_validator.validate(rubric)
        except jsonschema.ValidationError as exc:
            fail(path, question["id"], f"rubric schema: {exc.message}")


def convert(path: Path) -> tuple[dict, dict, list[dict]]:
    data = load_source(path)
    dataset, rubrics = build(path, data)
    validate(path, dataset, rubrics)
    return data, dataset, rubrics


def source_paths(paths: list[Path], all_files: bool) -> list[Path]:
    if all_files:
        return sorted((REPO / "modules").glob("**/eval/evals.json"))
    return list(dict.fromkeys(path.resolve() for path in paths))


def write_outputs(directory: Path, dataset: dict, rubrics: list[dict]) -> None:
    outputs = [
        (directory / "dataset.yaml", dataset),
        (directory / "rubrics.yaml", {"rubrics": rubrics}),
    ]
    rendered = [
        yaml.safe_dump(document, sort_keys=False, allow_unicode=True, width=100)
        for _, document in outputs
    ]
    # Refuse overwrites, including dangling symlinks. Exclusive creation also
    # protects against another process creating a destination after this check.
    for path, _ in outputs:
        if path.exists() or path.is_symlink():
            raise FileExistsError(f"refusing to modify existing file: {path}")
    directory.mkdir(parents=True, exist_ok=True)
    with ExitStack() as stack:
        handles = [
            stack.enter_context(path.open("x", encoding="utf-8"))
            for path, _ in outputs
        ]
        for handle, text in zip(handles, rendered):
            handle.write(text)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("path", nargs="?", type=Path)
    parser.add_argument("--out-dir", type=Path)
    parser.add_argument("--check", action="store_true")
    parser.add_argument("--all", action="store_true")
    args = parser.parse_args()
    if args.all:
        if args.path or args.out_dir:
            parser.error("--all cannot be combined with a path or --out-dir")
    elif args.path is None:
        parser.error("provide an evals.json path or --all")

    paths = source_paths([args.path] if args.path else [], args.all)
    cases = failures = 0
    for path in paths:
        try:
            data = load_source(path)
            cases += len(data["evals"])
            dataset, rubrics = build(path, data)
            validate(path, dataset, rubrics)
            if not (args.check or args.all):
                write_outputs(args.out_dir or path.parent, dataset, rubrics)
        except Exception as exc:
            failures += 1
            print(f"FAIL {path}: {exc}", file=sys.stderr)
    if not paths:
        failures += 1
        print("FAIL: no evals.json files found", file=sys.stderr)
    print(
        f"files={len(paths)} cases={cases} failures={failures} "
        "(cases counted after source validation; --all always checks only)"
    )
    return 1 if failures else 0


if __name__ == "__main__":
    raise SystemExit(main())
