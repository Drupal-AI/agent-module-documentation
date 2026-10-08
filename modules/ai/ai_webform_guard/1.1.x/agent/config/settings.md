<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, routes & config objects

## Install / enable

`drush en ai_webform_guard`. Requires `ai` (with a working chat provider, e.g. OpenAI) and
`webform`. No default provider is set by the module — configure one in the AI module, or pick a
model here. Uninstall deletes both config objects (`ai_webform_guard_uninstall()`).

## Routes (all require core permission `administer ai`)

- `ai_webform_guard.settings` → `/admin/config/ai/ai-webform-guard/ai-webform-guard-settings`,
  form `Form\AIWebformGuardSettingsForm` (form id `ai_webform_guard_settings`).
- `ai_webform_fields_guard.settings` → `/admin/config/ai/ai-webform-guard/ai-webform-guard-fields`,
  form `Form\AIWebformGuardFieldsSettingsForm` (form id `ai_webform_guard_fields_settings`).
- `ai_webform_guard.list` → `/admin/config/ai/ai-webform-guard` — core `SystemController` admin
  menu block; parent of the two forms (menu links in `ai_webform_guard.links.menu.yml`).

There is no `configure` key in the `.info.yml`.

## Config object `ai_webform_guard.settings`

Schema `config/schema/ai_webform_guard.schema.yml`; defaults `config/install/…settings.yml`. Edited
by `AIWebformGuardSettingsForm` (each element uses `#config_target` except `whitelist`, which the
form's `submitForm()` splits from a textarea into an array).

| Key | Type | Default | Meaning |
|---|---|---|---|
| `prompt` | string | (long spam-classifier text) | System prompt prepended to the submission. Required in the form; described as Twig-rendered. |
| `ai_model` | string | `''` | Provider/model as a "simple option" string; empty = AI module default for `chat_with_complex_json`. Select options come from `getSimpleProviderModelOptions('chat', …, [ChatJsonOutput])`. |
| `error_message` | string | `''` | Message shown on a blocked submission; empty = "This submission has been identified as spam." |
| `log_spam_attempts` | bool | `true` | Log each block to channel `ai_webform_guard` (notice) with probability + full AI response. |
| `human_iteration` | bool | `false` | Enables the `spam_confirm` confirmation checkbox flow (see services doc). |
| `max_words` | int | `500` | Truncate submission text to N words before sending (min 30 in form). |
| `flood_control` | bool | `true` | Enable per-form/IP flood blocking. |
| `flood_window` | int | `60` | Flood window, seconds. |
| `flood_threshold` | int | `5` | Allowed spam hits before blocking without an AI call. |
| `whitelist` | sequence(string) | `[]` | IP patterns (one per line, `*` wildcards) that bypass the AI check via `PathMatcher::matchPath` on the client IP. |
| `spam_probability_threshold` | int | `70` | Block when AI probability ≥ this (0–100; form-validated). 50 aggressive / 70 balanced / 90 permissive. |

`hook_update_9001`–`9004` (`.install`) backfill `max_words`, the flood keys, `whitelist`, and
`spam_probability_threshold` on existing sites.

## Config object `ai_webform_guard.fields_settings`

Edited by `AIWebformGuardFieldsSettingsForm`, which lists every Webform (`Webform::loadMultiple()`)
and, per Webform, its value elements (`getElementsInitializedFlattenedAndHasValue()`). Structure:

```
settings_fields:
  <webform_id>:
    custom_prompt: <string>            # per-Webform prompt override (else global prompt)
    enable_spam_confirmation_flow: bool # toggle email_confirmation handler on spam (needs
                                        #   webform_email_confirmation_link; checkbox disabled if absent)
    excluded_fields:
      <field_key>: 0|1                 # 1 = drop this field from the AI prompt
```

These per-Webform values are read in `Hook\AiWebformGuardFormHooks::validateSubmission()` and passed
to `SpamDetectionService::detectSpam()` as `excluded_fields` / `custom_prompt`.
