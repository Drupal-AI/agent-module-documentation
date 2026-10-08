<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FZ152 — agent index

Adds a required personal-data-processing **consent checkbox** to chosen forms and publishes a
**privacy-policy page**, for Russian law 152-FZ compliance. Depends on core `filter`. One
permission (`administer fz152`, restrict access). Ships Russian default config. No Drush, no
plugin types. Config UI at `fz152.settings` (`/admin/config/system/fz152`).

- **The three config forms, config objects/keys, form-id matching syntax, the privacy-policy
  page, and the `Fz152Service` API** → [configure/settings.md](configure/settings.md)

Submodules (own docs):
- `fz152_contact` (Contact-form integration) → [../../modules/fz152_contact/2.0.x/agent/start.md](../../modules/fz152_contact/2.0.x/agent/start.md)
- `fz152_consent` (logs consents as entities) → [../../modules/fz152_consent/2.0.x/agent/start.md](../../modules/fz152_consent/2.0.x/agent/start.md)

Key facts:
- Checkbox injected in `hook_form_alter` (`fz152.module`) when `fz152.settings:enable` is TRUE and
  the form id matches a listed pattern; validator `fz152_agreement_element_validate` requires it.
- Config objects: `fz152.settings` (enable, is_checkbox, `checkbox_title`..`checkbox_title_10`),
  `fz152.forms` (`forms` string), `fz152.privacy_policy_page` (enable, title, path, text).
- Form list line format: `form_id|weight|checkbox_title_number`, one per line, `*` = wildcard.
- Privacy page route `fz152.privacy_policy_page` = `access content`; `Fz152RouteSubscriber` sets its
  path from config or removes it when disabled.
