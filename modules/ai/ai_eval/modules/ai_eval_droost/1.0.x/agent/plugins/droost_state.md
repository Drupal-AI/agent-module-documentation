<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# droost_state grader — state oracle, assertion runner, tiers

## Install / enable

```
drush en ai_eval_droost
```

Requires `ai_eval` and `droost` (and the Droost tool-providing modules for the tiers you assert
on, e.g. `droost_views`, `droost_canvas`). Then add `droost_state` to an eval target's grader list.

## The grader — `DroostStateGrader` (`src/Plugin/AiEvalGrader/DroostStateGrader.php`)

Attribute: `id: droost_state`, `llm: FALSE`, `min_score: 0.0`, `max_score: 5.0`,
`observes_actions: TRUE` (it reads real state, never the response text). Extends `ai_eval`'s
`GraderBase`; constructed with `@ai_eval_droost.assertion_runner`.

`grade(string $input, string $response, array $context): GradeResult`:
- `context.metadata.droost` absent → `result(NULL, 'skipped')` (excluded from averaging).
- present but not an array → `result(0.0, 'Setup failure: metadata.droost must be a mapping…')`.
- `assertions` missing / empty / not a list → `result(0.0, 'Setup failure: … non-empty list…')`.
- else `AssertionRunner::run($spec)`; empty results → `0.0` setup failure; otherwise **5.0 iff
  every assertion passes, else 0.0**, reason = one `PASS/FAIL <id> (<tier>): <reason>` line each.

This is a strict fail-closed contract: a question declaring a droost spec is never allowed to skip
(hiding a broken spec) or to pass vacuously on an empty assertion list.

## Assertion runner — `AssertionRunner` (`src/AssertionRunner.php`)

A faithful PHP port of the prototype `droost_grader.py`. Two target kinds, three tiers:

- **View target**: fetched once via `droost_views_get`. *Config-tier* checks read that model
  (`display_exists`, `path_equals` read `data.displays[<display>]` directly — no default-display
  fallback, so a missing display is falsifiable). *In-band tier* checks execute the view for real
  via `droost_views_execute` and grade the returned row ids (e.g. `shows_all_published: total=12`).
  Exposed-identifier fairness: assertions name the `exposed_field`, and the actual query identifier
  the build used is discovered from the `views_get` payload (a literal `exposed` map is honored for
  back-compat).
- **Canvas target**: the entity's actual persisted tree is read once via `droost_canvas_tree_get`;
  correctness lives in tree content — `component_present` counts components, `input_equals`
  compares a component's persisted inputs. There is deliberately no "tree is valid" re-validation
  (that would conflate the agent's build with ambient schema drift in the target entity).
- A tool failure (`success = FALSE`) fails the assertion with the tool message as the reason; the
  runner never throws.

## The oracle — `DroostOracle` (`src/DroostOracle.php`)

`call(string $tool_id, array $args): array` — the single gateway to Droost:
1. Rejects any `$tool_id` not in `self::ALLOWED_TOOLS` (the read/validate allowlist) with a
   `{success: FALSE, …}` envelope.
2. `toolManager->createInstance($tool_id)` (`@plugin.manager.mcp_server.tool`), verifies it is a
   `ToolPluginInterface`, and `execute($args, $gateway)` where `$gateway` is a `ClientGateway`
   built `newInstanceWithoutConstructor()`.
3. Catches `PluginNotFoundException` (module not enabled) and any `\Throwable` (logged), returning
   a failure envelope; `normalize()` enforces the `{success, message, data}` shape.

By construction it **never invokes Droost's write or `eval`-PHP tools**, so grading a build can
read and validate state but cannot mutate the site.

## Assertion spec shape (in a dataset question's `metadata.droost`)

```yaml
metadata:
  droost:
    target: { kind: view, view: kb_docs, display: page_1 }   # or kind: canvas, entity: …
    assertions:
      - { id: display_exists, tier: config, kind: display_exists, display: page_1 }
      - { id: shows_all, tier: inband, kind: shows_all_published, exposed_field: section }
```

Task passes iff every assertion passes. See `datasets/droost_build_tasks.dataset.yaml` for a full
worked example; `scripts/verify_live.php` is a dev-only live check.
