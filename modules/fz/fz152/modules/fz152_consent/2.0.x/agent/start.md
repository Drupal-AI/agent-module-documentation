<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FZ152 — Consent — agent index

Logs each consent captured on an FZ152-tracked form as a `fz152_consent` content entity (IP,
form id, source values) and lists them in a View. Depends on `fz152` + core `views`. Permission
`administer fz152_consent` (restrict access). Config UI `fz152_consent.settings` at
`/admin/config/system/fz152/consent-settings`.

- **Source-field config, the submit-handler flow, the `fz152_consent` entity, and the service** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config `fz152_consent.settings:source` — newline-separated form field names to store
  (default `name\nsurname\nemail\nphone\nmail`).
- `fz152_consent.module` `hook_form_alter` appends `_fz152_consent_custom_form_submit` to tracked
  forms (same matching as parent via `fz152.service` + `fz152_contact.service`).
- Entity `fz152_consent` (base table `fz152_consent`): fields `created`, `ip`, `form_id`, `source`;
  `admin_permission = administer fz152_consent`; delete + delete-multiple routes; View `fz152_consents`.
- Records created by `FZ152ConsentService::createConsent($ip, $form_id, $source)` (service
  `fz152_consent.service`) only when at least one source value is present.
