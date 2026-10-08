<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drutopia Site (drutopia_site) — agent index

Configuration-only **base feature** for the [Drutopia](https://www.drupal.org/project/drutopia) distribution. It installs a shared authoring baseline: three text formats + CKEditor 5 editors, two `block_content` bundles (`basic`, `slide`), and additive permission grants for six site roles. **No `src/` PHP, no routes, no services, no `*.permissions.yml`.** Package `Drutopia`. License GPL-2.0-or-later.

- **Version:** `2.0.x` — this is a **dev checkout**: `.info.yml` has no `version:` key. `data.json` version is set to the version-dir `2.0.x`.
- **Core:** `^10.2 || ^11 || ^12`.
- **Install note:** in this environment the module **did not enable** because its Drutopia dependency chain (`drutopia_core`, `ds`, `workflow_buttons`, etc.) is not fully present. That is **expected** — these docs are written from the on-disk source, and enabling is not required to document a config-only feature.

## What it actually provides

- **Config it ships** (`config/install`, `config/actions`) and the three `.install` update hooks — the grouped inventory, the autosave setting, and the exact permission set granted to each of the six roles → [config/config.md](config/config.md).
- **No** entities/plugins/routes/services/permission definitions of its own. Bundles/fields/formats it ships are plain exported core config.

## Dependencies (from `.info.yml`)

`admin_toolbar:admin_toolbar_tools`, `admin_toolbar:admin_toolbar_search`, `autosave_form`, core `block_content`/`ckeditor5`/`editor`/`field`/`filter`/`menu_ui`/`text`, `drutopia_core`, `ds`, `entity_reference_revisions`, `menu_admin_per_menu`, `paragraphs`, `role_delegation`. `composer.json` additionally requires `workflow_buttons` and `wysiwyg_linebreaks` (referenced by the role config-actions but not listed as module deps in `.info.yml`).

## Update hooks (`drutopia_site.install`)

- `drutopia_site_update_8101()` — uninstall `admin_links_access_filter`, install `admin_toolbar_links_access_filter`.
- `drutopia_site_update_8102()` — install `autosave_form`, `menu_admin_per_menu`, `role_delegation`, `wysiwyg_linebreaks`.
- `drutopia_site_update_9201()` — install `admin_toolbar_search`.
