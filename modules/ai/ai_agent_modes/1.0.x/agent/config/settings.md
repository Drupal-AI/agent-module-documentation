<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site settings: `ai_agent_modes.settings`

Form `SettingsForm` (`src/Form/SettingsForm.php`, `ConfigFormBase`) at route
`ai_agent_modes.settings` → `/admin/config/ai/agent-modes/settings` (local task *Settings*,
permission `administer ai agent modes`). Writes the single config object `ai_agent_modes.settings`
(schema `ai_agent_modes.schema.yml` → `ai_agent_modes.settings`, install defaults in
`config/install/ai_agent_modes.settings.yml`).

## Top-level keys

| Key | Type | Default | Meaning |
|---|---|---|---|
| `show_dropdown` | bool | `true` | Offer the mode dropdown at all. Off leaves modes in place but stops asking; anything scoped by config still applies. `ModeManager::dropdownEnabled()` treats unset as `true`. |
| `canvas_position` | string | `toolbar` | Dropdown placement in the Canvas AI panel: `top`, `above_input`, `below_input`, `toolbar`. |
| `chatbot_position` | string | `above_chat` | Placement in the AI Chatbot (DeepChat) panel: `above_chat`, `below_input`, `header`. Site default an assistant can override. |
| `tool_scope_enforcement` | bool | `true` | Site-wide switch for the *withholding* half of a `restrict` mode. Off = every `restrict` mode behaves as steer-only, no mode edits. Unset counts as enabled. |
| `speech_to_text` | mapping | disabled | DeepChat microphone (browser Web Speech). See below. |
| `text_to_speech` | mapping | disabled | Read replies aloud (browser speech synthesis). See below. |

Note the settings form asks about the Canvas AI panel; `chatbot_position` is set as the site
default that an AI Assistant falls back to when it declares no placement of its own.

## `speech_to_text` mapping

`enabled` (bool, default false), `position` (`input_start`|`input_end`|`outside_start`|
`outside_end`), `language` (`browser`|`site`|BCP-47 tag), `display_interim_results` (bool),
`stop_after_submit` (bool), `submit_after_silence` (bool), `submit_after_silence_ms` (int, 4000),
`interim_color` / `final_color` (string), `commands` mapping (`stop`, `pause`, `resume`,
`remove_all_text`, `submit`, `command_mode` phrase strings, plus `substrings` and `case_sensitive`
bools), `translations` (string, one `spoken|written` pair per line). These mirror DeepChat's own
`speechToText` options. Azure is intentionally not offered here (it needs a key/token); add it from
code with `hook_ai_agent_modes_speech_alter()`.

## `text_to_speech` mapping

`enabled` (bool, default false), `language` (`browser`|`site`|BCP-47), `voice_name` (string; a name
not installed falls back to the default voice), `pitch` (float 0–2), `rate` (float 0.1–10),
`volume` (float 0–1).

Both speech directions ship **off**; the `ai_agent_modes_post_update_add_speech` update writes them
off on existing sites too. Recognition/synthesis is the browser's own — a Chromium browser may
recognise in the cloud, so audio can leave the machine through the browser; the module sends nothing
itself and needs no key.

## Per-assistant overrides (third-party settings)

`AssistantSettingsHooks` implements `form_ai_assistant_form_alter` to add a fieldset to each AI
Assistant's edit form, stored as third-party settings on the assistant entity (schema
`ai_assistant_api.ai_assistant.*.third_party.ai_agent_modes`). Keys: `chatbot_position`,
`speech_to_text` (`on`/`off`), `speech_to_text_position`, `text_to_speech` (`on`/`off`). Absent =
the site setting applies. These travel with that assistant's configuration.

## Selector block settings

The `ai_agent_mode_selector` block stores `ai_assistant`, `parent_agent`, `surface`
(schema `block.settings.ai_agent_mode_selector`) — see [../api/scoping.md](../api/scoping.md).

## post_update functions (`ai_agent_modes.post_update.php`)

`_add_scope_strength` (writes `tool_scope_enforcement: true`, re-saves every mode),
`_add_chatbot_position` (`above_chat`), `_add_speech` (both directions off), `_add_show_dropdown`
(`true`). Each only fills a key that is still NULL, so an upgrade never changes existing behaviour.
