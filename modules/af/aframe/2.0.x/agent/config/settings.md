<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# A-Frame settings + libraries

## Install & enable

```bash
composer require drupal/aframe
drush en aframe -y
```

No declared module dependencies (formatters/widgets use core `file` and Field API). After enable,
configure at **`/admin/config/media/aframe`**.

## Settings form

Route `aframe.settings` → `Drupal\aframe\Form\AframeSettingsForm` (`ConfigFormBase`,
`getFormId()` = `aframe_settings_form`), form id path `/admin/config/media/aframe`, requirement
`_permission: 'administer site configuration'`. `configure` in `.info.yml` points here.
Editable config: **`aframe.settings`** only.

## Config object `aframe.settings`

Install defaults (`config/install/aframe.settings.yml`), schema (`config/schema/aframe.schema.yml`,
`type: config_object`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `library_source` | string | `cdn` | `cdn` or `local` (self-hosted). Radio on the form. |
| `aframe_version` | string | `1.5.0` | A-Frame version textfield (required). |
| `background_color` | string | `#ECECEC` | Default scene background (hex). |
| `enable_fog` | boolean | `false` | Turn on scene fog. |
| `fog_type` | string | `linear` | `linear` or `exponential`. |
| `fog_color` | string | `#ECECEC` | Fog color. |
| `fog_near` | integer | `1` | Linear fog near distance. |
| `fog_far` | integer | `100` | Linear fog far distance. |
| `ambient_light_color` | string | `#FFFFFF` | Ambient light color. |
| `ambient_light_intensity` | float | `0.5` | Ambient light intensity (0–1). |
| `directional_light_color` | string | `#FFFFFF` | Directional light color. |
| `directional_light_intensity` | float | `0.6` | Directional light intensity (0–1). |
| `inspector_roles` | sequence(string) | `[]` | Role IDs allowed to open the visual Inspector in the `aframe_inspector` widget. |

`submitForm()` writes each value; `inspector_roles` is `array_filter()`ed (unchecked roles
dropped). Fog and custom-lighting fields use `#states` to show only when relevant.

## Where the config is consumed

- `aframe_preprocess_aframe_model_viewer()` (`aframe.module`) reads `enable_fog`, `fog_type`,
  `fog_color`, `fog_near`, `fog_far` to build the `fog_attributes` string.
- `AframeModelFormatter::buildViewElement()` / `AframeModelWidget::formElement()` read
  `background_color` and the four lighting keys as defaults (the formatter lets a per-display
  override them).
- `AframeInspectorWidget::formElement()` reads `inspector_roles` and compares against
  `\Drupal::currentUser()->getRoles()`; users with `administer site configuration` always pass.
  The gate only controls whether the Inspector UI/library is attached to the edit form.

## Libraries (`aframe.libraries.yml`)

- `aframe` — external JS `https://cdn.jsdelivr.net/npm/aframe@1.7.1/dist/aframe-master.min.js`.
- `aframe-inspector` — external JS `aframe-inspector@1.7.1` (depends on `aframe/aframe`).
- `orbit-controls` — external JS `aframe-orbit-controls@1.3.0` (depends on `aframe/aframe`).
- `inspector-widget` — local `js/inspector-widget.js` + `css/inspector-widget.css` (deps:
  `core/drupal`, `core/drupalSettings`, `core/once`).
- `model-viewer` — local `js/model-viewer.js` + `css/model-viewer.css` (dep: `aframe/aframe`).

**Note (functional):** the CDN library URLs hard-code A-Frame **1.7.1**, so the `library_source`
and `aframe_version` settings do not actually change which library files load — those keys are
stored but not wired into `aframe.libraries.yml`. `AframeSceneFormatter` and the Inspector JS also
hard-code the `1.7.1` script URLs independently.
