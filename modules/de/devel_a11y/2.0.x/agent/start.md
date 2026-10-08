<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Devel Accessibility (devel_a11y) — agent index

Devel add-on that makes Drupal's invisible accessibility JavaScript observable to
developers: it logs every `Drupal.announce()` ARIA-live message and every tabbing-
manager constraint to the browser console, and can visually outline the elements
the tabbing manager currently traps focus to. Depends on `devel`; core
`^11.2 || ^12`. Defines no permissions, no drush, no plugins, no blocks.

- **Settings form, config object + schema keys, drush/PHP to set, when aids attach** →
  [configure/settings.md](configure/settings.md)
- **The three front-end libraries, their JS/CSS, console output, visual overlay** →
  [theme/libraries.md](theme/libraries.md)

Key facts:
- Route `devel_a11y.settings` → `/admin/config/development/devel/a11y`
  (`Form\Settings`, `_permission: access devel information`). `configure` in
  `info.yml` points here. Menu/task links parent to `devel.admin_settings`.
- Config `devel_a11y.settings` (schema shipped, `FullyValidatable`), 3 booleans,
  defaults all TRUE: `aural.announce.log`, `keyboard.tabbingmanager.log`,
  `keyboard.tabbingmanager.visualize`.
- Libraries in `devel_a11y.libraries.yml`: `announce.log`, `tabbingmanager.log`,
  `tabbingmanager.visualize` (deps `core/drupal.announce`,
  `core/drupal.tabbingmanager`, `core/jquery`).
- Hooks are OO classes: `Hook\Attachments` (`#[Hook('page_attachments')]`) attaches
  enabled libraries only for users with `access devel information`; `Hook\Help`
  (`#[Hook('help')]`). `services.yml` only sets
  `devel_a11y.skip_procedural_hook_scan: true` — no service definitions.
- No permissions.yml, no *.install, no drush.services.yml, no plugins, no blocks.

```bash
drush en devel devel_a11y -y
drush cget devel_a11y.settings
drush cset devel_a11y.settings keyboard.tabbingmanager.visualize false -y
```

Notes: the aids attach on every page for permitted users; logging is console-only
(nothing server-side). Keep the module off on production, like Devel itself.
