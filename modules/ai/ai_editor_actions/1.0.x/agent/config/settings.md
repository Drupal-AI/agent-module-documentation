<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Editor Actions — settings & configuration

## Install & enable

```bash
composer require drupal/ai_editor_actions   # or drush pm:install if already present
drush en ai_editor_actions -y
```

Requires `ai`, `ckeditor5`, `editor`, `filter`, `user`. `hook_install()`
(`ai_editor_actions.install`) seeds starter categories (Rewrite, Length, Analyze, Tone, Translate)
and actions owned by uid 1 and shared with the `authenticated` role, on the site default chat
provider. `hook_requirements()` warns on the status report when no default `chat` provider is
configured.

Then, per text format at *Text formats and editors*: add the **AI Actions** button
(`aiEditorActions`) to the CKEditor 5 toolbar. Configure a default chat provider (and, for voice,
a `speech_to_text` provider) under the AI module at `/admin/config/ai/settings`. Grant the
permissions below.

## Settings object `ai_editor_actions.settings`

Form: `Form\SettingsForm` (route `ai_editor_actions.settings`, path
`/admin/config/ai/editor-actions/settings`, permission `administer ai editor actions`). Schema:
`config/schema/ai_editor_actions.schema.yml`. Install defaults: `config/install/`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `max_input_chars` | integer | `24000` | Max characters of source text sent to the model; longer selections are truncated (with a `[truncated]` note appended in `TextTransformer::prepareText()`). Form min 500. `0`/empty falls back to the service constant `MAX_INPUT_CHARS` = 24000. |
| `transforms_per_hour` | integer | `100` | Per-user hourly flood limit shared by transform/explain/transcribe. `0` = unlimited (flood not registered). |
| `system_prompt` | text | (copy-editor prompt) | System/role prompt for transformations. Empty → `TextTransformer::SYSTEM_PROMPT`. |
| `explain_prompt` | text | (explainer prompt) | System prompt for the read-only "Explain this" insight. Empty → `TextTransformer::EXPLAIN_PROMPT`. |
| `explain_provider` | string | `''` | `provider__model` simple option for "Explain this". Empty = site default chat model. |
| `audio_provider` | string | `''` | `provider__model` simple option for speech-to-text voice input. Empty = site default `speech_to_text` model. |
| `structured_output` | boolean | `true` | Ask the model for structured JSON and build clean HTML from it (`ExplanationNormalizer`); falls back to plain text/prose when unsupported. |
| `selection_menu` | boolean | `true` | Pop up the AI Actions menu at a text selection in the editor. |
| `plain_text_actions` | boolean | `true` | Enable the AI Actions balloon on plain textfields/textareas (needs `use ai plain text actions`). |
| `explain_selection` | boolean | `true` | Show an "Explain this" button when any page text is selected (needs `use ai explain selection`). |

The settings form groups these into *AI request*, *Editor* and *Beyond the editor* sections
(`Traits\SettingsTableTrait`); model selects are populated from
`AiProviderPluginManager::getSimpleProviderModelOptions()`.

## Permissions (`ai_editor_actions.permissions.yml`)

- `use ai editor actions` — run actions from the CKEditor toolbar.
- `use ai plain text actions` — AI Actions balloon on plain fields/textareas.
- `use ai explain selection` — the on-page "Explain this" selection button.
- `create ai editor actions` — create own (private) actions; also the `collection_permission`.
- `create shared ai editor actions` — share own actions with roles.
- `administer ai editor actions` — full CRUD of actions/categories; `restrict access: true`;
  the entity `admin_permission`.

## Per-action model selection

An action's `provider` field holds a `provider__model` simple option (or `''` for the site default
chat model). `TextTransformer::runChat()` resolves it via `AiProviderPluginManager::getSetProvider('chat', …)`
and logs a warning + falls back to the site default if the named provider is gone. All model calls
go through `drupal/ai` (no direct HTTP/API-key handling in this module); the provider tags each
call with `['ai_editor_actions']`.
