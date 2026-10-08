<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Upgrade-check & project-inspection commands

All three live in `Commands\UpgradeCheckCommands` and delegate the deterministic work to the bundled
Python checker (`scripts/drupal_module_checker/check_module.py` / `check_project.py`) run via
`runPythonJsonScript()` (`proc_open` with an argv array — no shell). AI commentary is optional; see
[../api/ai_backends.md](../api/ai_backends.md).

## Install & enable

```bash
composer require drupal/ai_drush_tools
drush en ai_drush_tools -y
# One-time Python venv for the deterministic engine:
cd web/modules/contrib/ai_drush_tools/scripts/drupal_module_checker
python3 -m venv .venv && .venv/bin/pip install -r ../requirements.txt
```

`--python-bin` / `--script-dir` override the interpreter and checker location if the defaults
(a `.venv` inside the script dir) do not match your layout.

## `ai:module-check <module> --from=N` (alias `aimc`)

`check()`. Reports whether one module is compatible with core N+1.

- Argument `module` — machine name (e.g. `token`, `book`, or `drupal/pathauto`).
- Option `--from` (**required**) — the major version to upgrade FROM (e.g. `10`).
- Core modules resolve instantly from a built-in registry (incl. "moved to contrib" / "removed"
  guidance); contrib is looked up on Packagist with a Drupal.org update-feed fallback.
- Returns a structured result (status label, latest compatible release, core constraint, notes);
  works with `--format=json` for scripting.

```bash
drush ai:module-check token --from=10
drush ai:module-check book --from=10          # core module that may have moved/been removed
drush ai:module-check token --from=10 --enrich-with-ai
```

## `ai:module-check-list <file> --from=N` (alias `aimcl`)

`checkList()`. Runs the same analysis for every module in a text file (one machine name per line;
lines starting with `#` are ignored). Same AI flags as above; `--ai-dry-run` previews the shared
prompt workflow for the batch without calling a model.

```bash
drush ai:module-check-list modules.txt --from=10
drush ai:module-check-list modules.txt --from=10 --ai-dry-run
```

## `ai:project-info <project>` (alias `aipi`)

`projectInfo()`. Fetches Drupal.org project metadata directly from public APIs / update feeds.

- Argument `project` — Drupal.org project machine name.
- `--usage-version=8.x-1.x|2.0.x` — report usage for one release branch.
- `--include-issues=summary|none` (default `summary`) — issue-queue summary data.
- `--detail` — fetch a richer payload and render a detailed vertical report.
- Reports releases, compatibility, usage-by-branch, maintainers, issue summary, and
  security-advisory coverage; supports `--format=json`.

```bash
drush ai:project-info token
drush ai:project-info condition_field --usage-version=2.0.x --format=json
drush ai:project-info condition_field --detail
```

## Shared AI flags (all three)

`--enrich-with-ai` (add LLM commentary — exactly 4 bullet points built by `buildAiPrompt()` /
`buildProjectAiPrompt()`), `--ai-backend` (`auto`, `drupal-ai`, `litellm-proxy`, `claude-host`,
`codex-host`, `opencode-host`, `claude-cli`, `codex-cli`, `opencode-cli`, `python-litellm`),
`--ai-model`, `--litellm-proxy=<url>`, `--host-bridge-url=<url>`, `--ai-prompt "<text>"` or
`@file`, `--ai-dry-run` (print the prompt + stats, do not call the model), `--project-context=<path>`
/ `--no-project-context` (auto-discovers AGENTS.md / CLAUDE.md otherwise). Backend selection and
prerequisites are documented in [../api/ai_backends.md](../api/ai_backends.md).
