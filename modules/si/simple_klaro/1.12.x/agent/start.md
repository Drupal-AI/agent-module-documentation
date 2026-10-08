<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Klaro (simple_klaro) — agent index

Drupal integration for the **Klaro** consent manager (`kiprotect/klaro` JS library). Renders a
cookie/consent dialog that holds back third-party scripts until the visitor opts in. The whole
behaviour is driven by one JSON config blob edited in the settings form; saving it flushes all
caches so the change applies site-wide immediately. No module dependencies; needs the
`kiprotect/klaro` library (Composer or CDN). Core `^9.2 || ^10 || ^11`.
Configure at `/admin/config/system/simple-klaro` (route `simple_klaro.settings`).

- **Edit the Klaro JSON config, pick a library variant, exclude paths, set via drush/PHP** →
  [configure/settings.md](configure/settings.md)
- **The two permissions** → [permissions/permissions.md](permissions/permissions.md)
- **The "Cookie preferences" re-open block** → [blocks/preferences-dialog.md](blocks/preferences-dialog.md)

Key facts:
- Config object `simple_klaro.settings`. Keys: `config` (the Klaro config as a JSON **string**),
  `preferences` (re-open link label), `library` (which `libraries.yml` variant to load),
  `enabled` (bool), `exclude_paths` (one path per line, `*` wildcard, `<front>`).
- Embedded by `simple_klaro_page_attachments()` (`hook_page_attachments`, `simple_klaro.module`):
  decodes `config` into `drupalSettings.klaroConfig` and attaches `simple_klaro/<library>`.
  Skipped for users holding `bypass simple klaro` and on excluded paths.
- Two permissions, both `restrict access: true`: `administer simple klaro` (settings form),
  `bypass simple klaro` (use the site with no consent manager).
- Block plugin `simple_klaro_preferences_dialog` (`src/Plugin/Block/PreferencesDialog.php`) prints
  `<a id="klaro-preferences">`; any element with id `klaro-preferences` or class
  `klaro-preferences` opens the dialog (wired in `js/klaro.drupal.js`).
- Library variants in `simple_klaro.libraries.yml`: local vs `_cdn`, `_no_css` on/off,
  `_no_translations` on/off (8 combos), plus `klaro_editor` (Ace JSON editor on the form) and
  `klaro_sanitize` (a helper attached to the klaro library). Default `klaro` = local
  `/libraries/klaro/dist/klaro.js`.
- No Drush, no services file, no plugin types, no field/entity types. One route, one config
  object, one Block plugin, one settings form (`SettingsForm`, `ConfigFormBase`).
