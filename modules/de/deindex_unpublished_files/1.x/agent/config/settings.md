<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & routes

## Install / enable

`drush en deindex_unpublished_files -y` (or `composer require drupal/deindex_unpublished_files`
first). Requires core `file` and `media` (declared deps). No composer runtime deps. Core
`^10.3 || ^11 || ^12`.

There is **no `config/install`** default and **no `config/schema`** shipped. The config object
`deindex_unpublished_files.settings` therefore has **no default `unpublish_mode`** — until an admin
saves the settings form, `unpublish_mode` is `null` and `MediaHooks::mediaPresave()` takes neither
the `move` nor the `prefix` branch, i.e. **no files are relocated**. Pick a mode after enabling.

## Settings form

- Class `SettingsForm extends ConfigFormBase` (`src/Form/SettingsForm.php`), form id
  `deindex_unpublished_files_settings`, editable config `deindex_unpublished_files.settings`.
- Route `deindex_unpublished_files.settings` →
  `/admin/config/media/media-settings/deindex-unpublished-files`, `_permission: administer site configuration`,
  `_admin_route: TRUE`. Menu link under *Configuration → Media* (`*.links.menu.yml`), and it is the
  module's `configure` route (info.yml).
- One field, `unpublish_mode` (`#type => radios`, bound via `#config_target`):
  - `prefix` — "Prefix filename with .ht_"
  - `move` — "Move file to private/unpublishedfiles"
- `validateForm()`: when `move` is selected it checks that the `private` stream wrapper resolves to a
  configured directory path (via `StreamWrapperManagerInterface::getViaScheme('private')`) and that
  `private://unpublishedfiles` exists on disk (`FileSystemInterface::realpath()` + `is_dir()`); it sets
  a form error if the private path is unset or the folder is missing. The admin must create
  `private://unpublishedfiles/` and set the private file path in `settings.php` before `move` works.

## Media usage overview route

- Route `deindex_unpublished_files.unpublished_media_usage` →
  `/admin/content/deindex-unpublished-files/unpublished-media`, `_permission: administer media`,
  `_admin_route: TRUE`. Menu link "Unpublish media by usage" under *Content*. Form
  `UnpublishedMediaUsageForm` — see [../api/media-usage-inspector.md](../api/media-usage-inspector.md).

## Update hook

`deindex_unpublished_files_update_10001()` (`.install`) rebuilds the router
(`router.builder->rebuild()`) and menu links for the added usage page.
