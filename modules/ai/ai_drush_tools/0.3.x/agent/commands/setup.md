<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setup commands: `ai:setup` and `ai:setup:bridge`

Both live in `Commands\UpgradeCheckCommands`. They configure the AI-commentary layer; the
deterministic checks work without them.

## `ai:setup`

`configureSetup()`. Interactive wizard (or fully flag-driven) that writes AI defaults into a
`drush.yml`.

- `--config-path=<path>` — which `drush.yml` to edit. Defaults to the active writable `drush.yml`,
  else `PROJECTROOT/drush/drush.yml`; the vendor `drush.yml` is never edited
  (`resolveSetupConfigPath()`, `writeDrushConfigFile()`).
- `--backend=<name>` — one of `python-litellm`, `litellm-proxy`, `drupal-ai`, `claude-host`,
  `codex-host`, `opencode-host`, `claude-cli`, `codex-cli`, `opencode-cli`.
- `--model=<hint>` — stored model hint (required for `python-litellm`, optional otherwise).
- `--proxy-url=<url>` — LiteLLM proxy URL (for `litellm-proxy`).
- `--host-bridge-url=<url>` — host AI bridge URL (for `*-host` backends).

What it writes (`applySetupConfig()`): only these keys, under `ai_drush_tools.options` in the chosen
file — `ai-backend`, `ai-model`, `litellm-proxy`, `host-bridge-url`. Empty values are unset. Later
`ai:module-check` / `ai:project-info` runs then pick these up as option defaults.

The interactive path can discover available models by calling provider APIs
(`discoverProviderModels()` — OpenAI/Anthropic/DeepSeek/Moonshot/OpenRouter/xAI over HTTPS), a
LiteLLM proxy (`/models`), or a local `ollama list`. When it prompts for a provider API key it uses
a **hidden** prompt (`io()->askHidden`) and uses the key only for that live discovery request — the
key is **not** written to `drush.yml`.

```bash
drush ai:setup
drush ai:setup --backend=python-litellm --model=openai/gpt-4o-mini
drush ai:setup --backend=litellm-proxy --proxy-url=http://localhost:8000/v1
drush ai:setup --backend=claude-host --host-bridge-url=http://host.docker.internal:4141
```

API keys for actual completions are read at run time from environment variables
(`OPENAI_API_KEY`, `ANTHROPIC_API_KEY`, `DEEPSEEK_API_KEY`, `MOONSHOT_API_KEY`,
`OPENROUTER_API_KEY`, `XAI_API_KEY`, `AZURE_API_KEY`, `LLM_MODEL`; host bridge:
`AI_HOST_BRIDGE_TOKEN`) — see `AiCommandBase`.

## `ai:setup:bridge`

`configureBridge()`. Installs the DDEV host-bridge helper scripts so Drush inside the container can
reach host-native AI CLIs (Claude/Codex/OpenCode) running on the host OS.

- `--port=<n>` — default host bridge port (used to build `http://host.docker.internal:<port>`).
- `--backend=claude-host|codex-host|opencode-host` and `--model=<hint>` — optionally also store
  host-backed defaults in `drush.yml` (same writer as `ai:setup`).
- `--config-path=<path>` — `drush.yml` to update.

It writes DDEV command helpers into the project (`.ddev/…`) and points at
`scripts/ai_host_bridge.py`. The bridge itself is a separate process the operator starts on the
**host**; how it works and how to run it safely is documented in
[../api/ai_backends.md](../api/ai_backends.md).

```bash
drush ai:setup:bridge --backend=claude-host --model=sonnet
```
