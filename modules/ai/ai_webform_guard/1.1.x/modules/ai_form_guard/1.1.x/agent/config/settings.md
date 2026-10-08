<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, hooks & the shared engine

## Install / enable

`drush en ai_form_guard`. Pulls in `ai_webform_guard` (and `ai`). `hook_install()` initializes both
config objects (`custom_form_ids => ''`, `settings_fields => []`). It does not remove config on
uninstall (no `hook_uninstall`).

## How a custom form gets protected

`Hook\AiFormGuardFormHooks`:
- `#[Hook('form_ai_webform_guard_settings_alter')]` adds a **Custom Form IDs** textarea (weight 10)
  to the parent's `ai_webform_guard_settings` form and a `settingsSubmit()` handler that writes
  `ai_form_guard.settings:custom_form_ids` (one form id per line).
- `#[Hook('form_alter')]` runs on **every** form; it splits `custom_form_ids`, and if `$form_id` is
  not in the list it returns immediately. For a listed form it: (a) adds the hidden `spam_confirm`
  checkbox when parent `human_iteration` is on and calls `revealHumanConfirmationCheckbox()`, and
  (b) appends `validateCustomFormSubmission` to `$form['#validate']`.

`validateCustomFormSubmission()`:
1. Resolves the form id (`$form['#form_id']` or the form object's id); returns if none or if the form
   already `hasAnyErrors()`.
2. Human-iteration short-circuits via the parent service (`isHumanConfirmationGranted()` /
   `hasMatchingHumanConfirmationGrant()`), identical to the Webform path.
3. Reads per-form `excluded_fields` / `custom_prompt` from `ai_form_guard.fields_settings`, merges
   the standard Form API keys (`submit, form_build_id, form_id, op, form_token, actions`) into the
   exclusions, and calls the parent `SpamDetectionService::detectSpam($values, [...])`.
4. On `flood_blocked` sets a rate-limit error; on spam calls the parent
   `handleSpamDetection()` (no probability arg is passed here). Exceptions set a generic error.

The AI provider, prompt base, `max_words`, `spam_probability_threshold`, flood, whitelist, logging,
and the `SpamDetectedEvent` all come from **`ai_webform_guard.settings`** / the shared service — this
submodule adds no AI settings of its own.

## Config objects

`ai_form_guard.settings` (schema `config/schema/ai_form_guard.schema.yml`):
- `custom_form_ids` (text) — newline-separated form ids to protect.

`ai_form_guard.fields_settings`:
- `settings_fields.<form_id>.excluded_fields` — map `<field_name> => 1` (fields dropped from the AI
  prompt).
- `settings_fields.<form_id>.custom_prompt` (text) — per-form prompt override; empty = global prompt.

## Fields settings form — `Form\AIFormGuardFieldsSettingsForm`

Route `ai_form_guard.fields_settings` → `/admin/config/ai/ai-webform-guard/custom-form-fields`
(`administer ai`). Iterates the configured `custom_form_ids`; if none are set it shows a link back to
the parent settings. Excluded fields are entered as a newline textarea and stored as
`array_fill_keys($lines, TRUE)` in `submitForm()`. Field names are validated only at runtime (against
the actual submitted keys), per the module README.
