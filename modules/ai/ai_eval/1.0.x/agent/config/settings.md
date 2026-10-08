<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Eval — install, settings, permissions, routes, entities, Drush

## Install / enable

```
composer require drupal/ai_eval          # pulls drupal/ai + opis/json-schema
drush en ai_eval
```

Then configure a judge at `/admin/config/ai/ai-eval/settings` (`ai_eval.settings`). A runtime
`hook_requirements` (ai_eval.install) reports an ERROR until both `judge_provider` and
`judge_model` are set, and warns if the dataset path has no `*.yaml`. `hook_uninstall()` deletes
`*.json` files under the configured `results_path`.

## Settings — config object `ai_eval.settings`

Schema `config/schema/ai_eval.schema.yml`; defaults in `config/install/ai_eval.settings.yml`.
Keys: `dataset_path`, `results_path`, `question_pass_threshold` (3.5), `judge_provider`,
`judge_model`, `proposer_provider`/`proposer_model` (optimizer prompt proposer; empty = same as
judge), `improvement_margin` (0.4), `max_optimization_attempts` (3), `optimizer_candidate_runs`
(3), `optimizer_min_dataset_size` (15), `rate_limit_max_retries` (3), `rate_limit_base_delay`
(5.0), `rate_limit_delay_between_calls` (2.0), `require_review` (true), `response_char_limit`
(4000), `judge_response_char_limit` (4000), `cochran_confidence` (0.95),
`cochran_margin_of_error` (0.05), `export_envelope_on_complete` (false), `gold_target_n` (30).
Form: `Form\EvalSettingsForm`.

Provider IDs / models here are looked up through `drupal/ai`; **no API keys or TLS settings live
in this module** — credentials and transport are the AI provider layer's concern.

## Permissions (`ai_eval.permissions.yml`)

| Permission | Grants |
|---|---|
| `operate ai eval` | View results/dashboards, browse targets & optimization candidates, run evals. |
| `administer ai eval` | Manage settings, add/edit/delete targets & datasets, apply/reject optimizations. |
| `annotate ai eval results` | Annotate run outcomes and promote annotations into datasets. |
| `validate ai eval judges` | Validate judges vs. human labels, edit judge prompts, view trust state. |

Read routes use `operate ai eval+administer ai eval`; create/edit/delete of config use
`administer ai eval`.

## Routes (`ai_eval.routing.yml`) — all under `/admin/config/ai/ai-eval`

Every route is permission-gated; **no `_access: TRUE`, no `access content`, no anonymous route**.
Every state-changing POST carries `_csrf_request_header_token: 'TRUE'` (optimize apply/reject use
`_csrf_token: 'TRUE'`). Highlights:

- Portfolio/list: `entity.ai_eval_target.collection` (`/`), `.results`, `.optimize`,
  `.trace_review`, `ai_eval.judges`, dataset/failure-mode/rubric collections.
- Entity CRUD: `entity.ai_eval_target.*`, `entity.ai_eval_dataset.*`,
  `entity.ai_eval_failure_mode.*`, rubric add/edit/show/delete, question add/edit/show/
  transcript/toggle/delete/move.
- Run/generate (POST + CSRF header): `ai_eval.run.start|progress|cancel`,
  `ai_eval.generate.start|progress|cancel`.
- Results annotation (POST + CSRF): `.results.annotate|promote_annotation|reset_annotation`; the
  GET `.results.annotation_open|close` only re-render which row is expanded (documented as
  non-mutating, so no CSRF token — they change no state).
- Trace review/promote (POST + CSRF): `.review.label`, `.promote.bulk`, `.promote.trace`,
  `.trace_review.group_label`; import via `Form\TraceImportForm`.
- Judges: `ai_eval.judges*` under `validate ai eval judges`; `.judges.validate.run|progress`
  POST + CSRF.
- Optimize apply/reject: `administer ai eval` + `_csrf_token`.

## Entities

- **Config**: `ai_eval_target` (a run definition: mode, dataset source, graders sequence,
  provider/model, thresholds — schema `ai_eval.target.*`), `ai_eval_judge_config`
  (per-grader judge overrides), `ai_eval_failure_mode` (named failure taxonomy).
- **Content**: `ai_eval_dataset` + `ai_eval_question` (browser-authored datasets/questions),
  `ai_eval_rubric` (deterministic-check rubric), `ai_eval_annotation` (per-question human
  outcome), `ai_eval_review_label` (trace label). Access handlers:
  `Access\AnnotationAccessControlHandler`, `Access\ReviewLabelAccessControlHandler`.
- **Custom tables** (`ai_eval.install` `hook_schema`): `ai_eval_result` (finalized run rows +
  Wilson CI columns), `ai_eval_optimization` (optimizer candidates), `ai_eval_run` /
  `ai_eval_generation` (incremental UI-run progress backends).

## Drush commands

`ai-eval:run` (aer) run a target; `:optimize` (aeo) propose/A-B optimized prompts;
`:validate-judge` (aevj) score a judge vs. human labels; `:judges` (aej) list graders + trust;
`:distill` (aed); `:sample-traces` (aest); `:import-traces` (aeit) / `:import-envelope` (aeie) /
`:export-envelope` (aee); `:target-fixtures` (aetf). Registered in `drush.services.yml`
(`src/Command/`).

## Operating notes

- `results_path` and `dataset_path` are admin-config filesystem paths; the file dataset source
  reads `*.yaml` there, and results JSON is written under `results_path` (removed on uninstall).
- Rate limiting for judge/model calls is handled by `Service\RateLimitHandler` using the
  `rate_limit_*` settings (retry with backoff).
- `EvalRunCompleteEvent` fires once per stored result; `EventSubscriber\EnvelopeExportSubscriber`
  optionally exports a result envelope when `export_envelope_on_complete` is true.
