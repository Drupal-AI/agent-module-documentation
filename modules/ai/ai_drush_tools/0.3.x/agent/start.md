<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Drush Tools (ai_drush_tools) — agent index

Five **Drush commands** for Drupal module upgrade checks and Drupal.org project inspection, with an
**optional** pluggable AI-commentary layer. Package **Development**. Core `^10.3 || ^11`. License
GPL-2.0-or-later. Version 0.3.0. No routes, permissions, entities, or config objects — CLI only.

- **The upgrade/inspection commands (`ai:module-check`, `ai:module-check-list`, `ai:project-info`)**
  → [commands/upgrade_check.md](commands/upgrade_check.md)
- **The setup wizard (`ai:setup`, `ai:setup:bridge`)** → [commands/setup.md](commands/setup.md)
- **The AI backend layer + bundled Python scripts + host bridge** → [api/ai_backends.md](api/ai_backends.md)

## Dependencies

- Requires only `drupal/core ^10.3 || ^11`. **Suggests** `drupal/ai` (auto-uses any configured
  provider). The deterministic checks need **Python 3.10+** with a virtualenv (bundled
  `scripts/drupal_module_checker`); AI enrichment optionally needs `litellm` or a host AI CLI.

## Commands (all in `Commands\UpgradeCheckCommands`, registered in `drush.services.yml`)

| Command | Alias | Purpose |
|---|---|---|
| `ai:module-check <module> --from=N` | `aimc` | Next-major compatibility of one core/contrib module. |
| `ai:module-check-list <file> --from=N` | `aimcl` | Same check for every module listed in a file. |
| `ai:project-info <project>` | `aipi` | Drupal.org project metadata / health signals. |
| `ai:setup` | — | Wizard: writes AI backend defaults into `drush.yml`. |
| `ai:setup:bridge` | — | Installs DDEV host-bridge helper scripts. |

Every check command shares the AI flags `--enrich-with-ai`, `--ai-backend`, `--ai-model`,
`--litellm-proxy`, `--host-bridge-url`, `--ai-prompt`, `--ai-dry-run`, `--project-context` /
`--no-project-context`, plus `--python-bin` / `--script-dir` runtime overrides.

## How it is built (from source)

- **Deterministic engine**: PHP delegates to a bundled Python checker via `proc_open` (argv array):
  `scripts/drupal_module_checker/check_module.py` and `check_project.py`, whose services fetch from
  Packagist and Drupal.org (`scripts/drupal_module_checker/services/http_fetcher.py`, `requests`).
- **AI backend layer** (`src/Ai/`): `AiRequest` / `AiResponse` domain objects, `AiBackendResolver`
  (preference/`auto` precedence), and backends in `src/Ai/Backend/`: `DrupalAiBackend`,
  `LiteLlmProxyBackend`, `PythonLiteLlmBackend`, `ClaudeCliBackend` / `CodexCliBackend` /
  `OpenCodeCliBackend` (local CLI via `proc_open`), and `Claude|Codex|OpenCodeHostBackend`
  (HTTP to a host bridge, `AbstractHostBridgeBackend`).
- **Host bridge**: `scripts/ai_host_bridge.py` (a small HTTP server the operator starts on the host)
  runs host-native AI CLIs on request — see [api/ai_backends.md](api/ai_backends.md).
- `AiCommandBase` holds shared option/env resolution (API keys read from env vars, not stored).

## Operating notes

- `ai:setup` writes only `ai-backend` / `ai-model` / `litellm-proxy` / `host-bridge-url` under an
  `ai_drush_tools.options` key in the chosen `drush.yml`. It never writes API keys — those stay in
  environment variables (`OPENAI_API_KEY`, `ANTHROPIC_API_KEY`, `LLM_MODEL`, …).
- All shelling out (Python checker, AI CLIs, `command -v`) uses argv arrays / `escapeshellarg`; all
  HTTP uses the default TLS-verifying client.
