# Browser update (bu) — agent index

Shows an unobtrusive, dismissible "update your browser" notice powered by the
browser-update.org script. Core-only (no module deps). Provides one admin settings form and a
config schema; no permissions of its own, no Drush, no plugins.

- **Every setting key, the settings form, visibility logic, and how settings reach the JS** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config UI: `/admin/config/system/browser-update` (route `bu.admin_settings`, form
  `\Drupal\bu\Form\SettingsForm`, requires core `administer site configuration`).
- `hook_page_attachments()` in `bu.module` loads `bu.settings`, applies visibility, and attaches
  library `bu/bu.checker` + `drupalSettings.bu = <all settings>`; `js/bu.js` passes them to the
  remote browser-update script (which does the client-side browser detection).
- Default script source `//browser-update.org/update.min.js` when `source` is empty; overridable
  via `source` / `show_source` settings.
- Defaults ship in `config/install/bu.settings.yml`; schema in `config/schema/bu.schema.yml`.
- Append `#test-bu` to any URL, or enable `test_mode`, to force the message for preview.
