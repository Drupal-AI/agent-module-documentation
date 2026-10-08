<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Webform Guard (ai_webform_guard) — agent index

Blocks **Webform** submissions that a chat LLM classifies as spam. On submit, a validation handler
collects the submitted values, wraps them in an admin prompt, sends them to the **AI module**
provider, and rejects the submission when the returned spam probability meets a threshold. Package
*Spam Protection*. Core `^10 || ^11`. License GPL-2.0-or-later. Installed 1.1.7.

- **Requires** `ai:ai` (chat provider abstraction) and `webform:webform`. Dev-suggests `drupal/key`.
- **No own permissions** — all three admin routes use core `administer ai`. No Drush, no entities,
  no plugin types. Provides config schema.

## What it provides

- **Services** (`ai_webform_guard.services.yml`):
  - `ai_webform_guard.spam_detection` → `Service\SpamDetectionService` — the engine (AI call, JSON
    parse, flood, whitelist, human-confirmation grants).
  - `ai_webform_guard.provider` → `Service\ProviderHelper` — resolves the provider/model.
  - `Hook\AiWebformGuardFormHooks` — OO hook object (`hook_subscriber`).
- **Hook** `webform_submission_form_alter` adds a `#validate` handler (and, when human-iteration is
  on, a hidden `spam_confirm` checkbox) to every Webform submission form.
- **Event** `SpamDetectedEvent` (`ai_webform_guard.spam_detected`) — form id, form data, AI response
  text, client IP.
- **Config** objects `ai_webform_guard.settings` and `ai_webform_guard.fields_settings`.
- **Routes** (all `_permission: administer ai`): `ai_webform_guard.settings`,
  `ai_webform_fields_guard.settings`, `ai_webform_guard.list` (menu block at
  `/admin/config/ai/ai-webform-guard`).
- **Submodule** `ai_form_guard` — extends the same engine to arbitrary custom forms by form id
  → [modules/ai_form_guard/1.1.x/agent/start.md](../../../modules/ai_form_guard/1.1.x/agent/start.md).

## Solution docs

- **Settings, config objects, schema, routes, thresholds, flood, whitelist, per-Webform fields** →
  [config/settings.md](config/settings.md)
- **Detection engine: SpamDetectionService, the hook flow, human iteration, the event** →
  [services/spam-detection.md](services/spam-detection.md)

## Notes for agents

- Submission field content is **sent to the external AI provider** (data egress); use the
  per-Webform *excluded fields* to keep sensitive fields out of the prompt.
- The API key is held by the **AI module / Key**, never by this module. No direct HTTP is made here
  — everything goes through `$provider->chat()`.
- AI classification is one probabilistic layer; pair it with server-side anti-spam (Honeypot, flood).
