<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# A-Frame Integration (aframe) — agent index

Integrates the **A-Frame** WebVR/WebXR JS framework into Drupal's Field API: two field
formatters, two field widgets, a theme template, and a global settings form. Version dir
`2.0.x` (packaged `2.0.0-alpha1`). Core `^10 || ^11`. Package `Custom`. License GPL-2.0-or-later.

## What it actually is (from source)

- **Formatters** (`src/Plugin/Field/FieldFormatter/`):
  - `aframe_model` → `AframeModelFormatter` — for **file** fields. Renders an uploaded 3D model
    (glTF/GLB/OBJ/DAE) via `#theme => 'aframe_model_viewer'`.
  - `aframe_scene` → `AframeSceneFormatter` — for **text_long / string_long** fields. Renders the
    stored scene into an `<iframe srcdoc>` viewer.
- **Widgets** (`src/Plugin/Field/FieldWidget/`):
  - `aframe_model_widget` → `AframeModelWidget` (extends core `FileWidget`) — file upload with a
    live 3D preview.
  - `aframe_inspector` → `AframeInspectorWidget` — a (disabled) HTML-source textarea plus the
    visual A-Frame Inspector, gated by `inspector_roles` config.
- **Settings form**: route `aframe.settings` at `/admin/config/media/aframe`
  (`src/Form/AframeSettingsForm.php`, `_permission: administer site configuration`). Config object
  `aframe.settings` (install defaults `config/install/aframe.settings.yml`, schema
  `config/schema/aframe.schema.yml`).
- **Theme + hooks** (`aframe.module`): `hook_theme('aframe_model_viewer')`,
  `aframe_preprocess_aframe_model_viewer()` (picks the model loader by file extension, builds fog),
  `hook_help`. Template `templates/aframe-model-viewer.html.twig`.
- **Libraries** (`aframe.libraries.yml`): `aframe`, `aframe-inspector`, `orbit-controls` load
  A-Frame **1.7.1** JS from `cdn.jsdelivr.net`; `inspector-widget`, `model-viewer` are local
  JS/CSS.
- **No** routes beyond the settings form, **no** `*.permissions.yml`, **no** Drush, **no**
  submodules, **no** entities. (The `data.json` field `provides_permissions` is false — the one
  route uses the core `administer site configuration` permission.)

## Solution docs

- [config/settings.md](config/settings.md) — the settings form, every `aframe.settings` key + schema,
  the CDN libraries, and how library source/version actually resolve.
- [fields/formatters-and-widgets.md](fields/formatters-and-widgets.md) — enabling each formatter and
  widget, their settings, the model-viewer template variables, and the scene/preview render path.
