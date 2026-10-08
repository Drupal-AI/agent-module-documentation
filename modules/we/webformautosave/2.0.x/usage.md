<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Autosave automatically saves a Webform submission as a draft whenever the user changes an input, and offers optional optimistic locking to warn when another user has modified the same submission.

---

Enabled per webform via **third-party settings** (`auto_save`, `auto_save_time` ms, `optimistic_locking`
— schema `webform.third_party.webformautosave.schema.yml`). On a webform submission form,
`hook_webform_submission_form_alter` adds a hidden, disabled draft-submit button (`::submitForm`,
`::save`, `::draft`) inside a visually-hidden container; the module's JS (`js/webformautosave.js`, on
jQuery/once) listens for input/change events and, after the debounce interval, clicks that button to
fire a standard AJAX **draft save** through Webform's own submission form. There is **no custom route,
controller, or REST endpoint** — an earlier REST-based approach was removed in `webformautosave_update_8002`
— so submission access is entirely governed by core Webform's own submission-form and draft-token
access (`getTokenUrl()`), and a user's autosaved draft is not exposed to other users by this module.
When autosave or optimistic locking is on, `hook_ENTITY_TYPE_presave` auto-configures the webform's
draft/purge settings (enables drafts, sets purge to include drafts, default 182-day purge) and, for
optimistic locking, enables the submission log. Optimistic locking stores the latest submission-log
timestamp in `$form_state` keyed by the submission token and, on validate, compares it to the current
log (`AutosaveHelper::getCurrentSubmissionLog`), setting a form error with a reload link if another
change landed first. `AutosaveHelper` (service `webformautosave.helper`) also enforces webform total/
user/entity submission limits before enabling autosave. Depends on `webform` and
`webform_submission_log`. No permissions or Drush of its own.

---

- Auto-save a long webform as a draft as the user fills it in (no "Save draft" click).
- Prevent data loss if a user navigates away mid-way through a multi-step webform.
- Debounce autosaves with a configurable delay (`auto_save_time`, default 5000 ms).
- Warn users when someone else has edited the same submission (optimistic locking).
- Keep collaborative webform submissions from silently overwriting each other.
- Auto-enable draft support and sensible purge settings when autosave is turned on.
- Purge stale autosaved drafts automatically (default 182 days).
- Respect per-webform, per-user and per-source-entity submission limits before autosaving.
- Enable autosave on only the webforms that need it via third-party settings.
- Provide a resume-later experience for authenticated (or all) users where drafts are allowed.
- Keep a submission log/audit of draft saves via webform_submission_log.
- Give editors a reload link when their form is stale rather than clobbering newer data.
- Configure autosave from the webform's General settings (third-party settings section).
- Apply autosave defaults globally via the Webform admin settings third-party section.
- Trigger draft saves purely client-side through the existing Webform AJAX submit (no extra endpoint).
