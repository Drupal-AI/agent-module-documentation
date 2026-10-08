<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Delay Submit

Adds a short client-side delay before a form's submit button becomes active, aiming to reduce bot-like rapid submissions and accidental double-submits.

- Admin configures which form IDs get the delay and the delay time.
- JS disables/fades in the submit button for the configured duration.
- Includes a form-ID autocomplete to help select target forms.

---

## Installation & configuration

- Enable; settings at `/admin/config/people/delay-submit` (perm `administer delay submit settings`).
- Add form IDs (with per-form delay time) to the enabled list; global fade-in duration is configurable.
- Config object: `delay_submit.settings` (keys include `enabled_forms`, `fade_in_duration`).
- The autocomplete endpoint requires `administer site configuration`.
- Form IDs are matched by both underscore and hyphen forms.
- The JS library `delay_submit/delay_submit` is attached to matched forms.

---

## Usage & behaviour / security

- `hook_form_alter` attaches the library + `drupalSettings` (delayTime, fadeInDuration, formId) only for enabled forms.
- Routes: settings form (admin), an autocomplete controller (admin), a `logAttempt` endpoint, and a `showWarning` endpoint.
- SECURITY NOTE (low): `logAttempt` is gated only by `_permission: 'access content'`, which is effectively available to anonymous users; it writes a static warning to the log on each call, so it can be abused to flood the log (minor log-spam / DoS only — no data exposure, no state change).
- `showWarning` similarly just adds a warning message and returns JSON.
- The autocomplete controller lists webform + a few core form IDs; input is only used for a case-insensitive substring filter (no query/DB).
- Because it is client-side only, the delay is not a real security control against determined bots — treat as UX/nuisance mitigation.
- No SQL, no external calls, no sensitive data in any endpoint.
- Combine with real anti-spam (CAPTCHA/honeypot) for actual protection.
- The delay time and fade duration are purely cosmetic timings.
- Works well on webform, contact, login, register forms (the autocomplete suggests these).
- `str_replace('_','-')` normalises the form id for the DOM.
- The `logAttempt` log channel is `delay_submit`.
- Consider tightening the `logAttempt` route permission if log-flooding is a concern.
- Config keys live in `delay_submit.settings`; the settings form is `src/Form/DelaySubmitSettingsForm.php`.
- Read: `delay_submit.module`, `src/Controller/DelaySubmitController.php`, `src/Controller/FormAutocompleteController.php`.
