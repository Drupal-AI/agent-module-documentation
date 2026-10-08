<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Suite automates Drupal's configuration export and import and lets a configuration export be reused across sites that have different UUIDs.

---

Core's configuration workflow is a pair of Drush commands (`config:export`/`config:import`) plus a synchronise screen, and it assumes a discipline that real teams do not always keep: change configuration, export it, commit it, import it on the next environment. Config Suite removes the two Drush steps by wiring them to events. **Automatic export** listens for the config-save event and copies each saved item straight from the database into the `config_sync_directory` the moment a form is saved. **Automatic import** listens on every request and, for a user in the `administrator` role, runs a full core config import from the sync folder whenever that folder is newer than the last config write — so a `git pull` into the sync folder is applied simply by loading a page as an admin. It also **disables core's cross-site UUID check**, so an export taken from one site can be imported into another copy with a different `system.site:uuid` without the "Site UUID in source storage does not match the target storage." error. Both toggles live at `/admin/config/config_suite/admin_settings` behind the `administer config suite` permission and default to on; installing the module also performs a one-time full export so the sync folder matches the running site. Version **2.0.5** on core `^10.1 || ^11`, with no dependencies beyond core. Two things are worth weighing before adopting automation here: automating export means the git diff records every config save (accidents included), so the review step effectively moves to your VCS commit; and where a team can lock production instead, making configuration immutable with `config_readonly` removes configuration drift rather than continuously reconciling it.

---

- Automatically export configuration to the sync folder when a form is saved.
- Automatically import pending configuration when an admin loads a page.
- Reuse a configuration export from one site on another with a different UUID.
- Avoid running `drush config:export` after every change.
- Avoid running `drush config:import` after a git pull.
- Keep the sync folder continuously in step with the database.
- Deploy configuration by committing sync files and pulling on the target.
- Onboard a new site copy from an existing site's exported config.
- Skip the "Site UUID does not match" error when importing foreign config.
- Reduce forgotten configuration exports.
- Support a git-based configuration workflow.
- Let non-CLI admins apply configuration by browsing the site.
- Move configuration between local, staging and production copies.
- Toggle automatic import on or off per environment.
- Toggle automatic export on or off per environment.
- Seed the sync folder with the full active config at install time.
- Keep configuration collections in sync alongside the main config.
- Compare the sync folder against active config on each admin request.
- Reduce manual steps in a configuration deployment.
- Support a client-managed site where admins avoid the CLI.
