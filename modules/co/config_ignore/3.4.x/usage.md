Config Ignore lets you protect selected configuration from being overwritten during `drush config:import`/`config:export`, so environment-specific settings you keep on the live site (site name, API keys, dev toggles) survive configuration deployments.

---

Drupal's configuration management overwrites the active site config with whatever is in the sync folder on import (and vice-versa on export), which is a problem when some configuration must differ per environment. Config Ignore hooks into core's storage-transform events for import and export and removes ignored items from the transformation so the destination value is kept instead. You list configuration names — one per line — on its settings form at `admin/config/development/configuration/ignore`, using exact names (`system.site`), wildcards (`webform.webform.*`, or `*` for everything), force-import exceptions (`~webform.webform.contact`), single-key targeting (`user.mail:register_no_approval_required.body`), and language-collection patterns (`language.fr|*`). Three operating modes let you scale complexity: **simple** (one list applied to both directions), **intermediate** (separate import/export lists), and **advanced** (separate create/update/delete lists per direction). Its own `config_ignore.settings` is stored as config, so ignore rules are themselves deployable, and `settings.php` overrides let you tune event priority, choose which storage supplies the rules, or deactivate ignoring entirely. Developers can add rules dynamically with `hook_config_ignore_settings_alter()` / `hook_config_ignore_ignored_alter()`, and a Drush option (`--deactivate-config-ignore`) allows a one-off full import/export. It is a lightweight, dependency-free companion to config workflows and pairs well with Config Split for module-level environment differences.

---

- Keep the live site name, slogan, and email (`system.site`) from being reverted on config import.
- Preserve development-only settings such as `devel.settings` across deployments.
- Protect API keys and third-party credentials stored in configuration on production.
- Ignore an entire config namespace with a wildcard like `webform.webform.*`.
- Ignore every configuration on a site with a single `*` line while still importing new modules.
- Force-import one item that a wildcard would otherwise ignore using `~webform.webform.contact`.
- Ignore a single key inside a config object, e.g. `user.mail:register_no_approval_required.body`.
- Ignore all translations of a config collection with `language.*|*`.
- Ignore only the French language overrides with `language.fr|*`.
- Ignore just the site name across every language via `language.*|system.site:name`.
- Keep `smtp.settings` different on staging vs production.
- Prevent block or webform content changes made in the UI from being wiped by `drush cim`.
- Use simple mode to apply one ignore list symmetrically to import and export.
- Use intermediate mode to ignore config on import but still export it (or vice versa).
- Use advanced mode to ignore only creates, only updates, or only deletes per direction.
- Preserve site-created config (ignore create on import) that should not be deployed.
- Prevent deletion of active config missing from the sync folder (ignore delete on import).
- Stop locally-changed config from being written back to the sync folder (ignore update on export).
- Temporarily export the full configuration with `drush config:export --deactivate-config-ignore`.
- Temporarily import everything with `drush config:import --deactivate-config-ignore`.
- Fully disable the module at runtime via `$settings['config_ignore_deactivate'] = TRUE;`.
- Tune when ignoring runs by setting `config_ignore_import_priority` / `config_ignore_export_priority`.
- Control which storage supplies the ignore rules with `$settings['config_ignore_storage']`.
- Deploy the ignore rules themselves as config so all environments share the same list.
- Add ignore patterns programmatically from a custom module with `hook_config_ignore_settings_alter()`.
- Remove or adjust another module's ignore entries with `hook_config_ignore_ignored_alter()`.
- Bypass a single ignored item on demand using core's single-config import UI.
- Pair with Config Split to keep environment-specific modules and settings cleanly separated.
- Keep content-type or field tweaks made directly on production during an emergency fix.
