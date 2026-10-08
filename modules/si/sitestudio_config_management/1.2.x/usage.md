<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Wires Acquia Site Studio (Cohesion) into Drupal's standard configuration workflow: it ships the recommended Config Ignore / Config Split setup for `cohesion_*` config and hooks Drush `config:export` / `config:import` so that Site Studio packages are exported and imported automatically alongside normal config.

---

Site Studio stores most of its design (styles, components, templates) as `cohesion_*` config and needs its own package export/import and a rebuild step; keeping that in sync with `drush config:export`/`config:import` is normally manual and error-prone. This module solves it declaratively and procedurally. On install it (a) appends `cohesion_*` to `config_ignore.settings` `ignored_config_entities`, (b) ships a `config_split` split named `site_studio` whose `complete_list` is `cohesion_*` (folder `sitestudio`), and (c) programmatically writes `cohesion.sync.settings` (from `config/optional`) enabling all `cohesion_*` entity types with export limits. At runtime it registers Drush **post-command hooks**: after `config:export` it runs `sitestudio:package:export`; after `config:import` it runs `cohesion:import` + `sitestudio:package:import`, and if the Cohesion module version increased since last recorded, `cohesion:rebuild`. A `ConfigEvents::IMPORT` event subscriber additionally triggers the Site Studio import during `site:install`-from-existing-config (when the config import event fires but the post-command hook would not). All Site Studio steps are skipped unless Site Studio is configured (both `api_key` and `organization_key` set in `cohesion.settings`). The service tracks the Cohesion version in state (`sitestudio_config_management.site_studio_version`) to detect upgrades. No routes, permissions, config schema, or UI.

---

- Auto-export Site Studio packages whenever you run `drush config:export`.
- Auto-import + rebuild Site Studio config whenever you run `drush config:import`.
- Trigger a Site Studio `cohesion:rebuild` automatically after a Cohesion version upgrade.
- Ship the recommended `config_ignore` rule so `cohesion_*` config stays out of normal sync.
- Provide a ready-made `config_split` (`site_studio`) that isolates `cohesion_*` into its own folder.
- Enable all `cohesion_*` entity types for Site Studio sync via `cohesion.sync.settings`.
- Keep design config in sync across environments in a CI/CD deployment pipeline.
- Import Site Studio packages during `drush site:install` from existing config.
- Detect Site Studio version changes between deploys via Drupal state.
- Skip all Site Studio steps automatically when Site Studio is not yet configured (no API keys).
- Standardize a team's Acquia CMS config workflow without custom deploy scripts.
- Avoid manual `sitestudio:package:export` / `:import` calls after config operations.
- Separate Site Studio design config from application config for cleaner diffs.
- Log (via a dedicated logger channel) each Site Studio drush command run during export/import.
- Prevent partial deploys where Drupal config imports but Site Studio packages do not.
- Reset the recorded Site Studio version on uninstall (state cleanup).
- Use as the config-management backbone for an Acquia CMS / Site Studio site.
- Chain Site Studio import after Drupal config import in a single `config:import` command.
- Ensure a fresh environment build imports both Drupal config and Site Studio packages.
- Reduce human error when promoting Site Studio changes from dev to production.
