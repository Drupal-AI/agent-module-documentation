<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DLF AIM 3D Viewer (dlf_aim_3d_viewer) — agent index

Drupal integration for the three.js-based **DLF AIM 3D Viewer** JS library. Displays 3D models
attached to a **core file field** on entity displays, and (unless "lightweight" mode is on) runs a
bash/Python/**Blender** server-side pipeline that uncompresses archives, converts many formats to
**GLB**, and renders thumbnails. Built for **WissKI** repositories but works standalone.

- Core: `^10 || ^11`. Only hard dependency: core **`field`**. License GPL-2.0-or-later. Version 1.0.2.
- Optional/soft: `wisski_core` (the `wisski_individual` entity used by the savePreview route),
  core `image`, `colorbox` (referenced by the formatter's base classes).
- The viewer JS/CSS is **not shipped** — install it separately to
  `web/libraries/dlf_aim_3d_viewer/` (see `dlf_aim_3d_viewer.libraries.yml`).

## What it provides (from source)

- **Field formatters** (`src/Plugin/Field/FieldFormatter/`): `DlfAim3DViewerFormatter`
  (id `dlf_aim_3d_viewer`, for `file` fields) and `DlfAim3DDerivativeLinkFormatter`.
- **Queue worker** `ConvertWorker` (id `dlf_aim_3d_viewer_convert`) — background model conversion.
- **Services**: `dlf_aim_3d_viewer.config_applier` (`DlfAim3dViewerConfigApplier`),
  `dlf_aim_3d_viewer.model_format_manager` (`ModelFormatManager`),
  `dlf_aim_3d_viewer.convert_process` (`ConvertProcessService`, runs `scripts/*.sh` via Symfony Process).
- **Config**: config object `dlf_aim_3d_viewer.settings` (schema + install defaults), settings form
  `DlfAim3dViewerConfigForm` at `/admin/config/dlf_aim_3d_viewer`.
- **Drush**: `dlf_aim_3d_viewer:configure` (alias `dlf_aim_3dv-config`).
- **Permissions** (`dlf_aim_3d_viewer.permissions.yml`): `administer dlf_aim_3d_viewer`,
  `access dlf_aim_3d_viewer editor`, `access dlf_aim_3dmodels`.
- **Hooks** (`.module`): `hook_entity_presave/insert/update` enqueue conversions for the configured
  target bundle; `hook_file_validate` (note: defined as `dlf_aim_3d_viewer_hook_file_validate`, an
  atypical name), plus JS-settings/CSRF attach helpers.
- **Routes** (`dlf_aim_3d_viewer.routing.yml`): config menu/form; editor API `save-metadata`,
  `upload-thumbnail`, `xml-export/{id}` (permission `access dlf_aim_3d_viewer editor`); model API
  `status/{id}` and `create` (permission `access content`); and a WissKI `savePreview` manifest route.

## Solution docs

- Formatter — enable it on a file field, how it resolves the model path →
  [fields/formatter.md](fields/formatter.md)
- Settings config object, schema keys, the settings form and the Drush command →
  [config/settings.md](config/settings.md)
- Conversion pipeline — queue worker, `ConvertProcessService`, the entity-save hooks and the
  background runner → [pipeline/conversion.md](pipeline/conversion.md)
- Editor & model HTTP API — the routes, controllers, methods and permissions →
  [api/routes.md](api/routes.md)
