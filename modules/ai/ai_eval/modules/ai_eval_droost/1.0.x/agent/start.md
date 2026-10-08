<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Eval Droost Oracle (ai_eval_droost) — agent index

A submodule of **AI Eval** providing ONE deterministic grader, **`droost_state`**, that scores the
real **Drupal state an agent built** — not its response text — by querying it through **Droost**
(`drupal/droost`) **read/validate** MCP tools. Package *AI*. Core `^11.3`, PHP `8.3`.
License GPL-2.0-or-later. Version 1.0.0-beta3.

- **The grader, the assertion runner, the oracle, tiers & spec** →
  [plugins/droost_state.md](plugins/droost_state.md)

## Dependencies

- `ai_eval:ai_eval` (host framework + `GraderBase`/`AiEvalGrader`), `droost:droost` (MCP toolkit
  on `mcp_server`). No composer.json of its own — ships inside the `drupal/ai_eval` project.

## What it provides

- **One grader plugin** `droost_state` (`src/Plugin/AiEvalGrader/DroostStateGrader.php`),
  `#[AiEvalGrader(id: 'droost_state', llm: FALSE, min_score: 0.0, max_score: 5.0,
  observes_actions: TRUE)]`, extending `ai_eval`'s `GraderBase`.
- **Two services** (`ai_eval_droost.services.yml`): `ai_eval_droost.oracle`
  (`DroostOracle`, args `@plugin.manager.mcp_server.tool` + logger) and
  `ai_eval_droost.assertion_runner` (`AssertionRunner`, arg `@ai_eval_droost.oracle`).
- **No routes, forms, permissions, config, or DB tables** — zero web attack surface.
- Ships a sample dataset `datasets/droost_build_tasks.dataset.yaml` and a dev CLI helper
  `scripts/verify_live.php`.

## Mechanism (from source)

- `DroostStateGrader::grade($input, $response, $context)` reads `context.metadata.droost`. No
  `droost` key → skip (NULL, excluded from averaging). Present but malformed (non-mapping, or empty
  / non-list `assertions`) → **fail-closed** score 0.0 with a setup-failure reason. Otherwise it
  calls `AssertionRunner::run($spec)` and scores 5.0 iff every `AssertionResult->pass` is true, else
  0.0; the reason is one `PASS/FAIL <id> (<tier>): <reason>` line per assertion.
- `AssertionRunner` fetches a view target once via `droost_views_get` (config-tier checks read that
  model; in-band checks execute the view via `droost_views_execute` and grade real rows); a canvas
  target is read once via `droost_canvas_tree_get` and graded on the persisted tree's content.
- `DroostOracle::call($tool_id, $args)` enforces an `ALLOWED_TOOLS` **read/validate allowlist**,
  rejects anything else, `createInstance()`s the `mcp_server` tool, executes it, and normalizes the
  `{success, message, data}` envelope. It never touches Droost's gated write/eval tier
  (no `allow_destructive`, no `allow_eval`).
