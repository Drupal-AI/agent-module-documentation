<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI backend layer, Python engine & host bridge

AI enrichment is entirely optional (the deterministic checks never need it). When
`--enrich-with-ai` is set, `Commands\UpgradeCheckCommands` builds an `Ai\AiRequest` (system prompt,
user prompt, backend preference, model hint, timeout) and asks `Ai\AiBackendResolver` to pick a
backend from a precedence-ordered list, then calls `complete()` → `Ai\AiResponse`.

## Domain objects (`src/Ai/`)

- `AiRequest` — immutable payload: `systemPrompt`, `userPrompt`, `backendPreference` (default
  `auto`), `modelHint`, `timeoutSeconds` (120), `metadata`.
- `AiResponse` — `text`, `backend`, `model`, `warnings[]`, `rawError`; `hasWarnings()`.
- `AiBackendResolver::resolve()` — if a concrete `--ai-backend` is given, returns that backend only
  when `isAvailable()`; on `auto`, returns the first available backend in list order.
  `availability()` builds per-backend diagnostics (`AiBackendAvailability`).
- `AiBackendInterface` — `name()`, `isAvailable()`, `explainUnavailable()`, `complete()`.

## Backends (`src/Ai/Backend/`)

| Backend (`name()`) | Class | Mechanism |
|---|---|---|
| `drupal-ai` | `DrupalAiBackend` | Uses `ai.provider` default chat provider from the `drupal/ai` module. |
| `litellm-proxy` | `LiteLlmProxyBackend` | `\Drupal::httpClient()->post($proxyUrl/chat/completions)`. |
| `python-litellm` | `PythonLiteLlmBackend` | `proc_open` a Python `litellm` script with prompt temp-files. |
| `claude-cli` / `codex-cli` / `opencode-cli` | `*CliBackend` (`AbstractCliBackend`) | Run the local CLI on `PATH` via `proc_open`. |
| `claude-host` / `codex-host` / `opencode-host` | `*HostBackend` (`AbstractHostBridgeBackend`) | HTTP to the host bridge `/complete`. |

Implementation notes (all from source):

- Every subprocess (`AbstractCliBackend::runProcess()`, `PythonLiteLlmBackend`, the Python checker,
  `command -v` via `escapeshellarg`) is launched with an **argv array** through `proc_open`, so the
  prompt text is passed as a single argument.
- `DrupalAiBackend`, `LiteLlmProxyBackend`, and `AbstractHostBridgeBackend` use
  `\Drupal::httpClient()`; the Python side uses `requests`.
- Provider API keys are read from environment variables in `AiCommandBase` and by the Python/host
  CLIs; `ai:setup` does not persist them to `drush.yml`. The host bridge accepts an optional bearer
  token from `AI_HOST_BRIDGE_TOKEN` (`AbstractHostBridgeBackend::buildHeaders()`).

## Bundled Python checker (`scripts/drupal_module_checker/`)

An MVC-ish Python package (`models/`, `services/`, `controllers/`, `views/`) that performs the
deterministic lookups. `services/http_fetcher.py` fetches JSON/text from Packagist and Drupal.org
with `requests` (20s timeout, 3 retries, TLS verified). `services/ai_enricher.py` optionally calls
`litellm.completion()` selected by `LLM_MODEL` + standard provider key env vars. Invoked from PHP as
`python check_module.py … --format json --compact` (argv array).

## Host bridge (`scripts/ai_host_bridge.py`)

A small `ThreadingHTTPServer` the operator starts on the **host OS** so Drush inside DDEV can use
host-native AI CLIs. It exposes `GET /health` (which backends are available) and `POST /complete`
(runs the selected CLI — `claude` / `codex` / `opencode` — via `subprocess.run` with an argv list
and returns the text). `ai:setup:bridge` installs the DDEV helpers that call it.

Run it on the host:

```bash
# Local-only default:
python3 scripts/ai_host_bridge.py serve --port 4141
# Reachable from the DDEV container (recommended: also set a token):
AI_HOST_BRIDGE_TOKEN=$(openssl rand -hex 16) \
  python3 scripts/ai_host_bridge.py serve --listen 0.0.0.0 --port 4141 --token "$AI_HOST_BRIDGE_TOKEN"
```

- `--listen` defaults to `127.0.0.1`; use `0.0.0.0` only when the container must reach it.
- `--token` (or `AI_HOST_BRIDGE_TOKEN`) sets a bearer token the bridge requires; pass the same value
  to Drush via `AI_HOST_BRIDGE_TOKEN` so `*-host` backends authenticate.
- Backend availability depends on each host CLI being installed and logged in
  (`claude auth status`, `codex login status`, `opencode auth list`).
