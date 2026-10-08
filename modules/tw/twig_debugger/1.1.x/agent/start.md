<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig Debugger — agent index

A one-checkbox module that toggles Drupal's Twig template-engine **debug** mode. Saving the
form with the box on writes `sites/default/services.yml` with `twig.config` `debug: true`,
`auto_reload: true`, `cache: false` and clears caches; turning it off deletes that file.
No plugins, no Drush, no services, no config schema. One permission, one settings form.

- **Enable/disable Twig debugging, the config key, the services.yml it writes, and how to
  do it safely from code/drush** → [configure/twig-debugging.md](configure/twig-debugging.md)

Key facts:
- Route/`configure`: `twig_debugger.settings` at `/admin/config/development/twig-debugger`.
- Permission: `administer twig debugger configuration`.
- Persistent config: `twig_debugger.settings:enabled` (1 = on). The config does **not**
  exist until the form is first saved.
- The real toggle is the `twig.config` block in `sites/default/services.yml`
  (`debug` / `auto_reload` / `cache`) — the form only writes/removes that file.
