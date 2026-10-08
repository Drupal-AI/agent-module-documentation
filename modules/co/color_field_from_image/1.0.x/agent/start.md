<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Color Field from image (color_field_from_image) — agent index

Automatically fills a **Color Field** with the **dominant color** of an **image field** on the
**same entity**, computed at entity save. No UI page, no routes, no permissions of its own —
behavior is toggled per-field in the Field UI. Package `Fields`. Core `^10.1 || ^11 || ^12`.
License GPL-2.0-or-later. Installed as **1.0.0-beta4** (version dir `1.0.x`).

## Dependencies

- Drupal modules (`.info.yml`): **`drupal:image`** (core, source image field) and
  **`color_field:color_field`** (contrib, provides the `color_field_type` target field).
- PHP library (`composer.json`): **`ksubileau/color-thief-php` `^2.0`** — the ColorThief palette
  extractor. Must be Composer-installed; the module `use`s `ColorThief\ColorThief` directly.

## What it provides (from source)

Only two hooks, wired through the OOP hook class
`src/Hook/ColorFieldFromImageHooks.php` (service `Drupal\color_field_from_image\Hook\ColorFieldFromImageHooks`,
`autowire: true`, `.services.yml`). The legacy `.module` procedural functions carry
`#[LegacyHook]` and delegate to that service.

- **`hook_form_field_config_form_alter`** (`formFieldConfigFormAlter`) — on the field-config edit
  form of a **`color_field_type`** field only (early-returns otherwise), injects a fieldset
  `third_party_settings[color_field_from_image]` with three controls:
  - `enabled` (checkbox),
  - `source_image_field` (select, required) — populated from the bundle's own `image`-type fields
    (`entity_field.manager::getFieldDefinitions`, filtered by `getType()=='image'` and a non-empty
    target bundle),
  - `image_style` (select, required, empty option = "Original image") — populated from all
    `image_style` config entities.

  A `#entity_builders` callback `color_field_from_image_form_field_config_edit_form_builder` (in
  `.module`) persists these three values as **third-party settings** on the `FieldConfig`.

- **`hook_entity_presave`** (`entityPresave`) — for every `ContentEntityInterface` save, loops the
  bundle's field definitions; for each `color_field_type` field whose `enabled` third-party setting
  is true it: loads the managed `File` from the configured `source_image_field` (guarded by
  `hasField` / `!isEmpty()` / `instanceof File`), optionally builds/loads the configured image-style
  derivative (`ImageStyle::buildUri` + `createDerivative` if missing), resolves the local realpath
  via the `file_system` service, then calls
  `ColorThief::getPalette($realpath, 10, $quality=5, null, 'hex')` and writes
  `$palette[0]` (a `#rrggbb` hex string) into the color field via `$entity->set()`.
  `NotReadableException` is caught → `messenger()->addError()` + `logger('color_field_from_image')->error()`
  (placeholders `%filename`, `%error`).

## Notable facts / gotchas

- **No routing.yml, no permissions.yml, no config schema, no config/install, no templates,
  no `.install`, no Drush.** The entire feature is field third-party settings + presave.
- The dominant color is **recomputed on every save** of an entity of that bundle when a source
  image is present — it overwrites whatever is in the color field. There is no "only if empty"
  guard and no way to lock a manually chosen color.
- Image selection is **admin-configured** (field third-party settings), never request-supplied;
  the source is always a managed file on the entity being saved.
- Requirements/config in prose: [../usage.md](../usage.md);
  human setup walk-through: [../human-docs/index.md](../human-docs/index.md).
