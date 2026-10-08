<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# A-Frame formatters & widgets

Four plugins, all in `src/Plugin/Field/`. Select them on **Manage form display** (widgets) and
**Manage display** (formatters).

## `aframe_model` formatter — `AframeModelFormatter`

- `field_types = { "file" }`. Label "A-Frame 3D Model Viewer".
- `viewElements()` iterates items, skips items without `target_id`/`entity`, guesses a MIME type if
  missing, and gets the model URL with `$file->createFileUrl(FALSE)`. Renders via
  `#theme => 'aframe_model_viewer'`, attaching libraries `aframe/aframe` + `aframe/model-viewer`.
- `defaultSettings()` / `settingsForm()`: `width` (`100%`), `height` (`600px`),
  `camera_position` (`0 1.6 3`), `camera_rotation`, `model_position`, `model_scale`,
  `model_rotation`, `background_color` (empty → global default), `use_default_lighting` (1),
  `custom_ambient_color`/`custom_ambient_intensity`/`custom_directional_color`/
  `custom_directional_intensity`, `auto_rotate` (0), `show_download_button` (1).
- `buildViewElement()` resolves background + lighting from the per-display settings or falls back to
  `aframe.settings` config, then passes everything to the template.

### Template `aframe-model-viewer.html.twig` + preprocess

- `aframe_theme()` registers `aframe_model_viewer` with variables (file_url, width/height, camera,
  model transform, colors, intensities, `auto_rotate`, `show_download_button`).
- `aframe_preprocess_aframe_model_viewer()`:
  - maps file extension → `model_type` (`gltf`/`glb` → `gltf-model`, `obj` → `obj-model`,
    `dae` → `collada-model`, default `gltf-model`);
  - builds `scene_attributes` (`embedded`, sizing `style`);
  - builds `fog_attributes` from `aframe.settings` when `enable_fog`;
  - sets `model_components` to `auto-rotate="speed: 0.5"` when `auto_rotate`.
- The Twig template emits an `<a-scene>` with `<a-entity camera>`, ambient + directional lights, and
  the model entity (`{{ model_type }}="{{ file_url }}"` or `obj-model="obj: {{ file_url }}"`), plus
  an optional download `<a>` and a small inline script that swaps the "Loading…" placeholder for the
  scene once `AFRAME` is defined.

## `aframe_scene` formatter — `AframeSceneFormatter`

- `field_types = { "text_long", "string_long" }`. Label "A-Frame Scene Viewer".
- Settings: `width` (`100%`), `height` (`600px`).
- `viewElements()`: for each item, takes `$item->value`, derives a `scene_id`
  (`aframe-scene-{delta}-{md5 prefix}`), builds an HTML document (A-Frame **1.7.1** script from
  jsDelivr, plus the orbit-controls script when the value contains `orbit-controls`) with the field
  value placed in the `<body>`, and renders it as an `<iframe srcdoc="…">` (`html_tag`,
  `allowfullscreen`) inside a `container`.

## `aframe_model_widget` widget — `AframeModelWidget`

- `field_types = { "file" }`, **extends core `FileWidget`**. Label "A-Frame 3D Model Upload with
  Preview".
- Adds settings: `show_preview` (TRUE), `preview_width` (`100%`), `preview_height` (`400px`),
  `camera_position`, `model_scale`, `auto_rotate`.
- `formElement()` calls `parent::formElement()`, then — when `show_preview` and a file exists —
  appends a `#weight 100` preview using `#theme => 'aframe_model_viewer'` with config-derived
  background/lighting and libraries `aframe/aframe` + `aframe/model-viewer`.

## `aframe_inspector` widget — `AframeInspectorWidget`

- `field_types = { "text_long", "string_long" }`, extends `WidgetBase`. Label "A-Frame Inspector
  Scene Builder".
- Settings: `include_base_scene` (TRUE), `default_camera_position` (`0 1.6 3`),
  `enable_stats` (FALSE).
- `formElement()`:
  - computes `$can_use_inspector` from `aframe.settings.inspector_roles` ∩ current user roles, OR
    `administer site configuration`;
  - for a **new** entity with an empty value and `include_base_scene`, seeds a starter `<a-scene>`
    template (scene/camera/lights + sample box/sphere/cylinder/plane);
  - when allowed, adds an `.aframe-scene-preview` prefix + description and attaches
    `aframe/inspector-widget`;
  - wraps a **disabled** textarea (class `aframe-scene-textarea`) inside a collapsed
    "Advanced: HTML Source" details element.
- `massageFormValues()` flattens the nested `$values[$delta]['value']['value']` back to
  `$values[$delta]['value']` before save.
- `js/inspector-widget.js` (`Drupal.behaviors.aframeInspectorWidget`) builds an iframe running the
  A-Frame Inspector, syncs edits back into the textarea via `postMessage`, and re-writes the iframe
  from the textarea on manual edits.

## Quick enable (config)

```bash
# Formatter on a file field's default view display:
drush cset core.entity_view_display.node.page.default \
  content.field_model.type aframe_model -y
# Widget on the form display:
drush cset core.entity_form_display.node.page.default \
  content.field_model.type aframe_model_widget -y
drush cr
```
