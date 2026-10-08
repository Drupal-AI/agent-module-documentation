<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — CKEditor AI Agent

## 1. Install the AI backend (required)

The module has **no provider/model/key settings of its own** — it delegates entirely to
the `ai` module. Set it up first:

1. Enable an AI provider plugin, e.g. `drupal/ai_provider_dxpr` (composer `suggest`),
   `ai_provider_openai`, `ai_provider_anthropic`, or `ai_provider_ollama`.
2. Configure a default **Chat** provider at `/admin/config/ai/settings`.

`AiAgentConfigurationManager::checkAiProvider()` drives both `hook_requirements`
(status report) and the "AI Provider" status panel at the top of the settings form:
it reports ERROR when no provider is installed or none is chat-ready (missing key),
WARNING when a chat provider exists but no default is selected, and OK otherwise
(showing the active `provider / model`).

## 2. Global settings form

`/admin/config/content/ckeditor-ai-agent` (`AiAgentSettingsForm`, permission
`administer ckeditor ai agent`, config object `ckeditor_ai_agent.settings`). Sections:

- **AI Provider** — read-only status panel only (link to `/admin/config/ai/settings`).
  No key or endpoint field.
- **AI Response Configuration** — `temperature` (validated 0–2, default 0.7),
  `maxOutputTokens`, `maxInputTokens`, `contextSize`, `editorContextRatio` (default 0.3),
  `contentScope`.
- **Advanced Prompt Settings** — per-component **overrides** and **additions** for the
  system prompt: `responseRules`, `htmlFormatting`, `contentStructure`, `tone`,
  `imageHandling`, `referenceGuidelines`, `contextRequirements`.
- **Tone of Voice** — optionally back the tone dropdown with a taxonomy vocabulary
  (`toneOfVoiceVocabulary`); each term's *description* is the tone instruction, ordered
  by weight, first term = default tone.
- **AI Edit Commands** — optionally back the command menu with a hierarchical vocabulary
  (`commandsVocabulary`); parent terms are categories, child terms' descriptions are the
  command prompts.
- **Performance** — `timeOutDuration` (default 120000 ms), `retryAttempts` (default 1).
- **Debug & Error** — `debugMode`, `streamContent`, `showErrorDuration` (default 5000 ms).
- **AI Output Security** — `aiOutputSecurity.allowedDomains`: a list of domains that AI
  output is allowed to reference; default `['promptahuman.com']`. Enforced client-side by
  `ai-output-filter.js` (URLs to other hosts are redacted / images replaced). Supports
  `*` (allow all) and `*.example.com` wildcards; domains already present in the editor's
  existing content are auto-allowed for that operation.

`hook_install` seeds two vocabularies (`ai_agent_commands`, `ai_tone_of_voice`) with
default terms and wires them into config.

## 3. Per-editor / per-text-format configuration

The plugin is a `CKEditor5PluginConfigurable`. Its settings live on each text format's
editor config; the per-editor form (`buildConfigurationForm`) exposes the same fields and
falls back to the global config when a field is empty. `getDynamicPluginConfig()` merges
global + per-editor values, forces `endpointUrl` to the tokenized proxy route and
`engine: 'dxai'`, and never sends a provider/model/key to the browser.

## 4. Enable in the toolbar

At `/admin/config/content/formats`, edit a text format (e.g. Full HTML) and drag the
**AI Agent** (`aiAgentButton`) and **AI Agent Tone** (`aiAgentToneButton`) buttons into the
CKEditor 5 toolbar. `hook_install`/`update_9004` auto-add these to `basic_html`,
`full_html`, `content_format`, and `easy_email` toolbars when present. Finally grant
`use ckeditor ai agent` to the roles that should have AI access.
