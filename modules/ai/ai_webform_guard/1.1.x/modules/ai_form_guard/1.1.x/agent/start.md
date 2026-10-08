<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Form Guard (ai_form_guard) — agent index

Submodule of **AI Webform Guard** that extends the same AI spam-detection engine to arbitrary
**custom (non-Webform) forms**, matched by form id. Package *Spam Protection*. Core `^10 || ^11`.
License GPL-2.0-or-later. Installed 1.1.7.

- **Requires** `ai_webform_guard:ai_webform_guard` and `ai:ai`. Reuses the parent's
  `ai_webform_guard.spam_detection` and `ai_webform_guard.provider` services directly.
- **No own permissions** (route uses core `administer ai`), no Drush, no entities/plugins. Provides
  config schema.

## What it provides

- **Service** `ai_form_guard.hook.form` → `Hook\AiFormGuardFormHooks` (tagged `hook_subscriber`),
  built with the parent's config factory, provider helper, logger, and spam-detection service.
- **Hooks**:
  - `#[Hook('form_ai_webform_guard_settings_alter')]` — adds a **"Custom Form IDs"** textarea to the
    parent settings form plus a submit handler that saves `ai_form_guard.settings:custom_form_ids`.
  - `#[Hook('form_alter')]` — for any form whose id is in that list, adds the `spam_confirm` checkbox
    (when human-iteration is on) and a `validateCustomFormSubmission()` validation handler.
- **Route** `ai_form_guard.fields_settings` → `/admin/config/ai/ai-webform-guard/custom-form-fields`
  (`administer ai`), form `Form\AIFormGuardFieldsSettingsForm` — per-form excluded fields + prompt.
- **Config** `ai_form_guard.settings` (`custom_form_ids`: text) and `ai_form_guard.fields_settings`
  (`settings_fields.<form_id>.{excluded_fields, custom_prompt}`).

Parent index → [../../../../agent/start.md](../../../../agent/start.md).

## Solution docs

- **Config objects, the two hooks, field/prompt settings, the shared engine** →
  [config/settings.md](config/settings.md)

## Notes for agents

- All AI behaviour (model, threshold, flood, whitelist, human-iteration, egress) is the parent's;
  this module only chooses *which* forms and *which* fields. Submission content still goes to the
  external AI provider.
