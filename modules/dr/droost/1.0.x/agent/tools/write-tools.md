<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Droost write & PHP-eval tools + the tier/gate model

The state-changing surface. Every tool here is registered (so an agent can discover it) but **refuses
to act** until the operator opts in. This is the security-relevant core of the base module.

## The gate: `DestructiveToolBase` + `GateFlag`

All write/exec tools extend `DestructiveToolBase` (`src/Plugin/Tool/DestructiveToolBase.php`). Two
guards, composed at the top of each `execute()` as
`$blocked = $this->requireCliTransport() ?? $this->gate('allow_…');`:

1. **`gate(string $flag)`** reads `droost.settings.<flag>` through `GateFlag::enabled()` and returns a
   refusal envelope when disabled. `GateFlag` (`src/GateFlag.php`) normalises the string `"false"`
   (which is *truthy* in PHP) plus `"0"/"no"/""` to disabled — so `drush config:set … false` really
   disables a gate. Over STDIO there is no user session, so this config flag — not a web permission —
   is the runtime gate.
2. **`requireCliTransport()`** returns a refusal when `PHP_SAPI !== 'cli'`, so the most dangerous
   tools refuse over the HTTP `/_mcp` endpoint even if the flag was enabled.

Per-category flags let the write surface be armed one risk-class at a time. The master
`allow_destructive` arms **every** write category at once (back-compat), but **never** `allow_eval`,
which stays a separate opt-in because it is RCE-class. All flags default `false` (`config/install/`).

| Flag | Arms |
| --- | --- |
| `allow_config_write` | `droost_config_set` |
| `allow_db_write` | `droost_db_create` / `_update` / `_delete` |
| `allow_entity_write` | `droost_entity_create` / `_update` / `_delete` (+ submodule writers) |
| `allow_scaffold` | `droost_scaffold`, `droost_structure_create` |
| `allow_module_ops` | `droost_module_install` / `_uninstall`, `droost_cron_run` |
| `allow_eval` | `droost_eval` (separate; master never arms it) |
| `allow_destructive` | master — arms all of the above except `allow_eval` |

> The running MCP server caches the flag at startup: after changing it, reload/restart the server in
> the editor. The refusal message says so.

## Configuration tools

- **`droost_config_set`** (`allow_config_write`, CLI-only) — sets one key on an **existing** config
  object. Refuses to create new objects; **refuses any `droost*.` config name** (regex
  `^droost(_[a-z0-9_]+)?\.`) so an agent with only `allow_destructive` cannot flip `allow_eval` (or a
  submodule gate) — flag changes must go through Drush/the admin form out-of-band. Echoed old/new
  values are redacted by key name.

## Raw-SQL write tiers — `DbWriteToolBase` + `SqlVerb`

Each tier (`droost_db_create` INSERT, `droost_db_update` UPDATE, `droost_db_delete` DELETE) runs a
**single statement of one verb**. `execute()` (in `DbWriteToolBase`) enforces, in order:
`requireCliTransport` → `gate('allow_db_write')` → leading verb matches the tier (`SqlVerb::leading`)
→ not multi-statement (`SqlVerb::isMultiStatement`) → **not a write to the `{config}` table**
(`SqlVerb::writesConfigTable`, so a raw SQL write cannot arm a gate flag) → per-verb guard. Guards:
UPDATE with no WHERE is refused unless `confirm:true`; DELETE always requires `confirm:true` and
refuses a no-WHERE wipe outright (use `droost_entity_delete` for record-safe deletes). Execution uses
`prepareStatement($sql, [], TRUE)` to report affected rows. `SqlVerb` (`src/Sql/SqlVerb.php`) is
documented as an **intent** helper (best-effort leading-keyword matches), explicitly *not* a security
boundary — appropriate for a local dev tool.

## Entity CRUD — `EntityWriteToolBase`

`droost_entity_create` / `_update` / `_delete` (`allow_entity_write`, CLI-only via `blockedByGate()`).
Operations go through entity storage handlers so hooks, computed fields, id assignment and
critical-record protection (e.g. user 1) are exact. Reads the `values` field map; resolves storage via
`storageFor()`.

## Module & runtime ops

- **`droost_module_install`** / **`droost_module_uninstall`** (`allow_module_ops`, CLI-only) — enable/
  disable modules + deps; report what actually changed (before/after snapshot).
- **`droost_cron_run`** (`allow_module_ops`, CLI-only) — runs cron.
- **`droost_cache_rebuild`** — rebuilds caches. Extends `DroostToolBase` (not gated by a flag): a
  cache clear is low-risk and often needed right after a scaffold/install.

## PHP evaluation — `droost_eval`

The Tinker analog (`EvalCode.php`). `requireCliTransport()` **then** `gate('allow_eval')` — both must
pass. Runs `eval($code)` inside `shielded()`, capturing output and return value, each capped at 2000
chars. Documented as extremely dangerous, off by default, separate from every other flag, and
trusted-local-only. `hook_requirements` raises this to an **error**-severity status report entry when
`allow_eval` is on.

See [scaffold-verify.md](scaffold-verify.md) for `droost_scaffold` / `droost_structure_create` /
`droost_verify` (also gated/CLI-only), and [../config/settings.md](../config/settings.md) for the
flags' schema and the settings form.
