# Eval format (Eval Commons)

Each module's evals live in two files, in the Drupal Eval Commons format that
`drupal/ai_best_practices` uses:

- `eval/dataset.yaml`: the questions.
- `eval/rubrics.yaml`: one rubric per question, saying how to grade it.

`run-matrix.py` and the site build (`site/scripts/build-data.mjs`) read them.
`run-matrix.py` runs inside the ddev web container and needs PyYAML and
jsonschema there (jsonschema for the check it runs before any model call). Add
them to `.ddev/config.yaml` and run `ddev restart`:

```yaml
webimage_extra_packages: [python3-yaml, python3-jsonschema]
```

The runner grades with the vendor `evals/scoring.py`. The excerpts below come
from `modules/ac/account_field_split/2.1.x/eval/` (long text shortened).

## dataset.yaml

```yaml
metadata:                     # free-form, about the whole file
  skill_name: drupal-module-docs
  skill_file: .agents/skills/drupal-module-docs/SKILL.md
  module: account_field_split
  version: 2.1.x
questions:
- id: account_field_split-where-to-configure    # unique in the file
  input: I installed account_field_split on a Drupal 11 site. ...   # the prompt
  criteria: There is no bespoke config page ...                     # the expected answer
  bundle: account_field_split
  rubric_ref: rubric/account_field_split_account_field_split_where_to_configure@1.0
  tags:
  - mode:recipe               # easy
  - difficulty:easy
- id: account_field_split-field-order
  input: On this Drupal site the user account form has been customised ...
  criteria: The E-mail address (mail) field appears first ...
  bundle: account_field_split
  rubric_ref: rubric/account_field_split_account_field_split_field_order@1.0
  tags:
  - mode:introspection        # medium
  - difficulty:medium
  metadata:
    setup: agent-module-documentation/evaluation/verify/account_field_split-field-order-setup.sh
    cleanup: agent-module-documentation/evaluation/verify/account_field_split-field-order-cleanup.sh
- id: account_field_split-mail-first
  input: On this Drupal site, account_field_split is enabled ... Apply the change to the live site.
  criteria: In core.entity_form_display.user.user.default ... mail's weight is strictly less than name's ...
  bundle: account_field_split
  rubric_ref: rubric/account_field_split_account_field_split_mail_first@1.0
  tags:
  - mode:execution            # hard
  - difficulty:hard
  metadata:
    persona: drupal-expert
    reset: agent-module-documentation/evaluation/verify/account_field_split-mail-first-reset.sh
    verify: agent-module-documentation/evaluation/verify/account_field_split-mail-first-verify.sh
```

Script paths are relative to the project root. Question `metadata` may also hold
`difficulty_note` and `note`.

## rubrics.yaml

```yaml
rubrics:
- id: account_field_split_account_field_split_where_to_configure
  version: '1.0'
  applicable_bundles:
  - account_field_split
  checks:
  - kind: must_contain_any    # passes if any value appears, ignoring case
    values:
    - form display
    - form-display
    - ...
  scoring:
    combine: all_pass
- id: account_field_split_account_field_split_mail_first
  version: '1.0'
  applicable_bundles:
  - account_field_split
  checks:
  - kind: command             # execution: runs the verify script
    command: bash {{ metadata.verify }}
    expect: exit_zero
    sandbox: ddev
  scoring:
    combine: all_pass
```

Recipe and introspection cases use text checks: `must_contain_any` (passes if
any value appears) and `must_not_contain` (fails if any value appears). Both
ignore case unless the check sets `case_sensitive: true`. Execution cases use
the one `command` check above, which passes when the `verify` script exits 0.
A `verify` script that runs longer than 30 minutes counts as a fail.
Every rubric needs at least one check.

## Check before committing

```bash
python3 evaluation/check_evals.py modules/ac/account_field_split/2.1.x/eval
python3 evaluation/check_evals.py --all
```

It validates both files against the Eval Commons schemas, then checks what
`run-matrix.py` needs: `module` and `version` in the dataset metadata, unique
ids, every `rubric_ref` resolves and every rubric is used, one `mode:` tag per
question, supported check kinds, execution cases with `reset`, `verify` and the
command check, `cleanup` wherever there is a `setup`, and that each script path
exists. `run-matrix.py` runs the same check before it calls any model. The schemas come from
`vendor/drupal/ai_best_practices/evals`; set `ABP_EVALS` to use another copy.
Command checks need ai_best_practices MR !112.

## History

These files were converted from the old `eval/evals.json` format. The converter
(`evaluation/to_commons.py`) and the grading comparison
(`evaluation/commons_parity.py`) were removed with the JSON files; see the git
history. The comparison matched the old grader on 101,250 of 101,332 checks.
All 82 differences came from one rule: the old grader matched
`must_not_contain` case-sensitively.

The 27 files under `unsupported_modules/` were converted the same way. 8 more
files used an older `cases` shape with no checks: views_aggregator (2),
paragraphs_browser (2), devel_php, block_visibility_conditions (3). Their 41
questions were converted by hand: the expected points became `criteria`, and
new `must_contain_any` checks were written from them. Their dataset `note` says
so. Review those checks before you trust their scores.
