<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
Configuration Partial Export lets you export only *selected* configuration objects — rather than the whole site config — either as a downloadable tarball from a UI tab or straight into the config sync directory with a Drush command.

---

The module is a developer tool for exporting a subset of Drupal configuration. It adds a **"Partial Export" tab** under *Configuration → Development → Configuration synchronization* (`/admin/config/development/configuration/single/config-partial-export`, gated by core's `export configuration` permission). The form lists config that differs from the last config **snapshot** and lets you tick individual items (plus an optional `system.site` checkbox) and download them as a gzipped tarball (`config_partial-<host>-<date>.tar.gz`); it remembers each user's last selection in State. It also ships a **Drush command** `config-partial-export` (alias `cpex`) that writes named active config objects directly into the site's `config_sync_directory` as `.yml` files — accepting a comma-separated list and shell-style `*` **wildcards** (e.g. `webform.webform.*`). Passing `--changelist` instead prints the list of active config that differs from the sync storage (grouped by create/update/delete) without exporting. There are no settings, no configure route, no config schema, and no plugins of its own; it defines only the tab, the download controller, and the Drush command. It is aimed at dev workflows where you want to move just a few changed configs into `config/install` or the sync folder without exporting everything.

---

- Export just the config objects you changed into the sync directory with `drush cpex <name>` instead of a full `drush cex`.
- Export all config for one module at once using a wildcard, e.g. `drush cpex "webform.webform.*"`.
- Grab a single view's config for a patch: `drush cpex views.view.frontpage`.
- Move a newly created content type + its fields into `config/install` for a distribution.
- Download a tarball of only the config you edited via the "Partial Export" admin tab.
- Include the site UUID (`system.site`) in an export by ticking the "Add system.site info" checkbox.
- See exactly which active configs differ from the sync storage with `drush cpex --changelist`.
- Cherry-pick config to hand to another developer without shipping unrelated changes.
- Export several specific configs in one call with a comma-separated list: `drush cpex "system.site,user.role.editor"`.
- Keep a feature branch's config change small by exporting only the affected objects.
- Script partial exports in a deploy/build pipeline to sync selected config.
- Export a block or menu configuration on its own after tweaking it in the UI.
- Pull a field storage + field instance pair into version control after adding a field.
- Export an image style you just created without touching the rest of the config.
- Snapshot a single webform's configuration for reuse on another site.
- Avoid overwriting teammates' config changes by exporting only your own objects.
- Produce a downloadable config bundle for a client to import elsewhere.
- Quickly diff active vs staged config from the CLI before deciding what to export.
- Export selected taxonomy vocabulary config after restructuring terms' settings.
- Copy a role's permission config (`user.role.*`) between environments.
- Use the "Multiple items" task under the Single export tab to pick items from a table.
- Export a view plus its dependencies by listing each config name explicitly.
- Keep `config/install` folders of a custom module up to date with hand-picked objects.
