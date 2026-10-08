<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Direct Save adds a single admin form that writes the site's entire active configuration straight into the configuration sync directory, optionally taking a timestamped backup of the existing files first.

---

The module is a thin one-form utility. It adds the route `config_direct_save.update_configuration_form` at `/admin/config/development/configuration/full/update` (surfaced as an "Update" local task on the core Synchronize page, `config.sync`) gated by the core `export configuration` permission. The form offers a "Config source" select (populated only with the site's sync directory from `Settings::get('config_sync_directory')`) and a "Backup" checkbox. On submit it lists every active config object via the config factory, deletes the existing `*.yml` files in the sync directory, and re-writes each config object (and every config collection, e.g. language overrides) as YAML using `Drupal\Component\Serialization\Yaml::encode()`. With "Backup" checked it first recursively copies the sync directory to a sibling folder suffixed with the current date/time (`sync-DD-MM-YYYY-H-i-s`). It effectively performs a full `drush config:export`-style dump through the UI, without Drush or the config diff review screen. It defines no config object, schema, service, plugin, or Drush command of its own, and has no settings page.

---

- Export the full active configuration to the sync directory from the browser, without shell/Drush access.
- Give a non-developer site builder a one-click "save my config to files" button.
- Take a timestamped backup of the current sync directory before overwriting it.
- Dump config on a host where you cannot run `drush config:export` (restricted shell, shared hosting).
- Snapshot configuration right before a risky change so it can be committed to version control.
- Regenerate the sync directory files after making config changes through the admin UI.
- Seed an empty sync directory so a fresh checkout has an initial config export.
- Provide an "export configuration" workflow to a trusted editor role via a single permission.
- Capture config from a production box to copy down to a development environment.
- Overwrite stale sync files that no longer match the active configuration.
- Include config collections (language overrides, etc.) in the exported files, not just the default collection.
- Keep a dated backup trail of successive config exports for auditing.
- Export config immediately after enabling/configuring a module through Extend.
- Bridge a gap in a deployment pipeline where only the web UI is reachable.
- Let a content-ops team push config to files without teaching them Drush.
- Force a clean re-export that removes YAML for config that no longer exists.
- Produce the YAML needed to review a config change in a code review.
- Support a "config first" workflow where builders edit in the UI then click Update to write files.
- Recover a working sync directory after it was accidentally emptied.
- Standardise config-export steps for editors by pointing them at one URL.
- Use the Update local task next to core's Synchronize screen for quick access.
- Make ad-hoc config backups before importing a feature or recipe.
- Avoid CLI entirely on locked-down managed Drupal hosting.
