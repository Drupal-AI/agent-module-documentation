#!/usr/bin/env python3
"""Compare legacy and Commons grading offline, using fake responses and runners."""
from __future__ import annotations

import argparse
from collections import defaultdict
from contextlib import contextmanager
import importlib.util
from pathlib import Path
import shlex
import sys

sys.dont_write_bytecode = True

from to_commons import COMMONS, REPO, convert, source_paths


@contextmanager
def blocked_providers():
    """Force run-matrix's existing fallback without importing vendor providers."""
    absent = object()
    previous = sys.modules.get("providers", absent)
    sys.modules["providers"] = None
    try:
        yield
    finally:
        if previous is absent:
            sys.modules.pop("providers", None)
        else:
            sys.modules["providers"] = previous


def import_file(name: str, path: Path):
    spec = importlib.util.spec_from_file_location(name, path)
    if spec is None or spec.loader is None:
        raise ImportError(f"cannot load {path}")
    module = importlib.util.module_from_spec(spec)
    sys.modules[name] = module
    try:
        spec.loader.exec_module(module)
    except BaseException:
        sys.modules.pop(name, None)
        raise
    return module


def load_graders():
    old_path = sys.path[:]
    try:
        with blocked_providers():
            legacy = import_file(
                "_amd_legacy_matrix", REPO / "evaluation" / "run-matrix.py"
            )
        sys.path.insert(0, str(COMMONS))
        scoring = import_file("_amd_commons_scoring", COMMONS / "scoring.py")
    finally:
        sys.path[:] = old_path
    return legacy.grade_recipe, scoring


def probes(case: dict):
    expected = case.get("expected_output", "")
    yield "expected_output", expected
    yield "empty", ""
    for item in case.get("must_contain_any", []):
        yield "required_alone", item
        yield "required_uppercase", item.upper()
    for item in case.get("must_not_contain", []):
        yield "banned_sentence", f"Do not use {item} here."
        yield "banned_flipped_case", f"Do not use {item.swapcase()} here."
        yield "expected_plus_banned", expected + " " + item
        # This additional probe keeps positive evidence while changing the ban's
        # case, so a failed positive check cannot always hide the difference.
        yield "expected_plus_banned_flipped", expected + " " + item.swapcase()


def case_sensitivity_only(
    answer: str, case: dict, checks: list[dict], legacy: bool, commons: bool
) -> bool:
    """Diagnose a disagreement; never substitute this for either real grader."""
    expected_checks = [
        {"kind": key, "values": case[key]}
        for key in ("must_contain_any", "must_not_contain")
        if case.get(key)
    ]
    if checks != expected_checks:
        return False
    required = case.get("must_contain_any", [])
    forbidden = case.get("must_not_contain", [])
    positive = not required or any(s.lower() in answer.lower() for s in required)
    sensitive = all(s not in answer for s in forbidden)
    insensitive = all(s.lower() not in answer.lower() for s in forbidden)
    return (
        sensitive != insensitive
        and legacy == bool(positive and sensitive)
        and commons == bool(positive and insensitive)
        and legacy != commons
    )


class Results:
    def __init__(self):
        self.rows = defaultdict(
            lambda: {"cases": set(), "probes": 0, "agreements": 0,
                     "disagreements": 0}
        )
        self.cases = set()
        self.case_only = 0
        self.other = 0
        self.errors = 0

    def record(self, path, qid, kind, legacy, commons, *, case_only=False, detail=""):
        row = self.rows[kind]
        identity = (str(path), qid)
        row["cases"].add(identity)
        row["probes"] += 1
        agrees = legacy == commons
        row["agreements" if agrees else "disagreements"] += 1
        if not agrees:
            if case_only:
                self.case_only += 1
            else:
                self.other += 1
            print(
                f"DISAGREEMENT file={path} case={qid!r} probe={kind} "
                f"legacy={legacy!r} commons={commons!r} "
                f"reason={'case-sensitivity' if case_only else 'other'} "
                f"{detail}"
            )

    def error(self, path, qid, exc):
        self.errors += 1
        print(f"ERROR file={path} case={qid!r}: {exc}", file=sys.stderr)

    def finish(self, files: int) -> int:
        print(f"{'probe kind':34} {'cases':>8} {'probes':>8} "
              f"{'agree':>8} {'disagree':>10}")
        for kind, row in sorted(self.rows.items()):
            print(
                f"{kind:34} {len(row['cases']):8d} {row['probes']:8d} "
                f"{row['agreements']:8d} {row['disagreements']:10d}"
            )
        total = {
            key: sum(row[key] for row in self.rows.values())
            for key in ("probes", "agreements", "disagreements")
        }
        print(
            f"files={files} cases_checked={len(self.cases)} "
            f"probes={total['probes']} agreements={total['agreements']} "
            f"disagreements={total['disagreements']} "
            f"case_sensitivity={self.case_only} other={self.other} "
            f"errors={self.errors}"
        )
        if self.errors or self.other:
            return 1
        return 2 if self.case_only else 0


def check_commands(path, case, question, rubric, scoring, results):
    checks = rubric["checks"]
    expected_check = {
        "kind": "command",
        "command": "bash {{ metadata.verify }}",
        "expect": "exit_zero",
        "sandbox": "ddev",
    }
    if checks != [expected_check]:
        raise ValueError("execution rubric must contain exactly the verify check")
    if rubric["scoring"] != {"combine": "all_pass"}:
        raise ValueError("unexpected execution scoring rule")
    metadata = question.get("metadata", {})
    if metadata.get("verify") != case["verify"]:
        raise ValueError("verify path was not preserved verbatim")

    # Commons shell-quotes metadata. For the repository's ordinary paths this
    # is literally "bash <verify path>". For paths with spaces it is equivalent
    # to sh()'s argv. Neither this runner nor the stub starts a subprocess.
    expected_command = "bash " + shlex.quote(case["verify"])
    for exit_code in (0, 1):
        calls = []

        def stub(command, timeout):
            calls.append((command, timeout))
            return exit_code, "scripted result"

        passed, detail, records = scoring.grade_command_checks(
            checks, metadata, {"ddev": stub}, combine="all_pass"
        )
        results.record(
            path, case["id"], f"command_exit_{exit_code}",
            exit_code == 0, passed, detail=detail,
        )
        actual_command = calls[0][0] if len(calls) == 1 else repr(calls)
        results.record(
            path, case["id"], f"command_resolved_exit_{exit_code}",
            expected_command, actual_command,
        )
        results.record(
            path, case["id"], f"command_argv_exit_{exit_code}",
            ["bash", case["verify"]],
            shlex.split(actual_command) if len(calls) == 1 else [],
        )
        results.record(
            path, case["id"], f"command_records_exit_{exit_code}",
            1, len(records),
        )

    calls = []

    def stub(command, timeout):
        calls.append((command, timeout))
        return 0, "must not be called"

    unknown = {**checks[0], "sandbox": "__unknown_parity_sandbox__"}
    try:
        scoring.grade_command_checks(
            [unknown], metadata, {"ddev": stub}, combine="all_pass"
        )
    except ValueError as exc:
        outcome = "raises" if "unsupported sandbox" in str(exc) else str(exc)
    else:
        outcome = "did not raise"
    results.record(
        path, case["id"], "unknown_sandbox", "raises", outcome,
    )
    results.record(
        path, case["id"], "unknown_sandbox_no_dispatch", [], calls,
    )
    # CWD is the actual sandbox runner's responsibility: the stub cannot prove
    # it. A real ddev adapter must use the project root (/var/www/html), matching
    # sh(), which invokes bash with an absolute project-root-relative path.


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("paths", nargs="*", type=Path)
    parser.add_argument("--all", action="store_true")
    args = parser.parse_args()
    if args.all and args.paths:
        parser.error("--all cannot be combined with explicit paths")
    if not args.all and not args.paths:
        parser.error("provide evals.json paths or --all")

    paths = source_paths(args.paths, args.all)
    results = Results()
    if not paths:
        results.error("<discovery>", "<none>", "no evals.json files found")
        return results.finish(0)
    try:
        grade_recipe, scoring = load_graders()
    except Exception as exc:
        results.error("<imports>", "<none>", exc)
        return results.finish(len(paths))

    for path in paths:
        try:
            data, dataset, rubrics = convert(path)
            rubric_index = {
                f"rubric/{rubric['id']}@{rubric['version']}": rubric
                for rubric in rubrics
            }
            questions = {q["id"]: q for q in dataset["questions"]}
        except Exception as exc:
            results.error(path, "<conversion>", exc)
            continue

        for case in data["evals"]:
            qid = case["id"]
            try:
                question = questions[qid]
                rubric = rubric_index[question["rubric_ref"]]
                if case.get("mode") == "execution" and case.get("verify"):
                    check_commands(
                        path, case, question, rubric, scoring, results
                    )
                else:
                    # Includes execution without verify: run-matrix also falls
                    # back to grade_recipe for that case.
                    for number, (kind, answer) in enumerate(probes(case)):
                        legacy = grade_recipe(answer, case)
                        commons, detail, _ = scoring.grade(
                            answer, rubric["checks"],
                            combine=rubric["scoring"]["combine"],
                        )
                        case_only = case_sensitivity_only(
                            answer, case, rubric["checks"], legacy, commons
                        )
                        results.record(
                            path, qid, kind, legacy, commons,
                            case_only=case_only,
                            detail=f"probe_index={number} answer={answer!r} {detail}",
                        )
                results.cases.add((str(path), qid))
            except Exception as exc:
                results.error(path, qid, exc)
    return results.finish(len(paths))


if __name__ == "__main__":
    raise SystemExit(main())
