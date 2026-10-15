# Eval Commons format

`to_commons.py` writes an `eval/evals.json` as `dataset.yaml` and
`rubrics.yaml`, the Drupal Eval Commons format that `drupal/ai_best_practices`
uses. `evals.json` stays the source and is never changed. The YAML files start
with a "Generated" header. The script only replaces files that carry it, so a
hand-written file is never overwritten.

`run-matrix.py` and the site build (`site/scripts/build-data.mjs`) read the YAML,
not `evals.json`. The runner grades with the vendor `evals/scoring.py`, and runs
`verify` as a command check inside the ddev container, from the project root.

| `evals.json` | Eval Commons |
|---|---|
| `prompt`, `expected_output` | question `input`, `criteria` |
| `must_contain_any`, `must_not_contain` | rubric checks |
| `verify` (execution) | command check: `bash {{ metadata.verify }}`, passes on exit 0 |
| `mode`, `difficulty` | question `tags` |
| `persona`, `setup`, `reset`, `cleanup`, `verify`, notes | question `metadata` |
| `module`, `version`, `skill_*`, other top-level keys | dataset `metadata` |

Unknown keys stop the conversion with an error, so nothing is dropped silently.

## Run

```bash
# Write (or refresh) one module, or all of them
python3 evaluation/to_commons.py modules/ac/account_field_split/2.1.x/eval/evals.json
python3 evaluation/to_commons.py --all

# Check only: validate, and fail if a YAML file is missing or out of date
python3 evaluation/to_commons.py --all --check

python3 evaluation/commons_parity.py --all
```

`--all` reports the 9 files listed below as failures until they are fixed.

The schemas and scorer come from `vendor/drupal/ai_best_practices/evals`.
Command checks need ai_best_practices MR !112. Set `ABP_EVALS` to use another copy.

`commons_parity.py` grades made-up answers with `grade_recipe` and with the
Eval Commons scorer, and lists every case where they disagree. It calls no
model and runs no site.

## Known differences

- `run-matrix.py` used to grade `must_not_contain` case-sensitively. Eval
  Commons ignores case, as ai_best_practices always did. It is the only grading
  difference found. `commons_parity.py` keeps the old grader to show it.
- These files do not convert, so the runner and the site skip them. 8 use an older `cases` shape that
  `run-matrix.py` cannot grade either: views_aggregator (2),
  paragraphs_browser (2), devel_php, block_visibility_conditions (3).
  `commerce_cart_redirection/3.3.x` uses the id
  `commerce_cart_redirection-clear-cart` twice.
