<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Representative Image (representative_image) — agent index

Adds a `representative_image` field type you attach to a fieldable bundle to declare **which image
represents an entity** (for `og:image`, listing thumbnails, feeds, etc.). The field stores no image of
its own — its widget is empty; instead its per-field settings name a *source* field (an image field or
an entity-reference/media field) plus a fallback behavior, and a service (`representative_image.picker`)
resolves the actual image at display time, following entity references so media references resolve to
their own representative image. The result is consumed three ways: two **field formatters**, a
**token** (`[<entity_type>:representative_image]`, registered on every entity type), and the picker
**service** for PHP.

- Depends on: core only (no `dependencies:` in info.yml; the field extends core `image`).
- Core: `^10.3 || ^11`. Package: `Media`. Legacy release string `8.x-1.5`.
- No settings page / `configure` route, no permissions, no drush, no libraries. Configuration is
  entirely **per field** (field settings + formatter settings on the bundle's form/display).
- Provides **config schema** (field/formatter/widget settings). Provides no new plugin *types* — it
  ships plugin *implementations* (field type/widget/formatters + two D7 migrate source plugins).
- Provides one alter hook (`hook_representative_image_alter`) and a D7→D11 migration path.

## What you'd do → where

- **Add the field to a bundle; choose the source image field + fallback behavior** →
  [fields/field.md](fields/field.md)
- **Display it (image style / link) or render referenced entities' representative images** →
  [fields/formatters.md](fields/formatters.md)
- **Get the image from PHP, use the token for `og:image`, alter the chosen image, or migrate from D7** →
  [api/service.md](api/service.md)

## Key facts (real machine names)

- Field type: `representative_image` (`RepresentativeImageItem` extends core `image` `ImageItem`;
  `default_widget: representative_image`, `default_formatter: representative_image`).
- Field widget: `representative_image` (`RepresentativeImageWidget` — `formElement()` returns `[]`; the
  field is configured, not filled in).
- Field formatters: `representative_image` (`RepresentativeImageFormatter`, for the `representative_image`
  field type, extends core `ImageFormatter`) and `entity_representative_image`
  (`EntityReferenceRepresentativeImage`, for `entity_reference` fields).
- Service: `representative_image.picker` = `Drupal\representative_image\RepresentativeImagePicker`
  (`@entity_field.manager`, `@entity_type.manager`, `@entity.repository`, `@module_handler`).
- Field settings keys: `representative_image_field_name` (source field), `representative_image_behavior`
  (`''`/`first`/`default`/`first_or_default`).
- Token: `representative_image` (on every entity type) → the image URL, via `hook_token_info` /
  `hook_tokens` in `representative_image.module`.
- Alter hook: `hook_representative_image_alter(FieldItemListInterface, FieldDefinitionInterface, FieldableEntityInterface)` (`representative_image.api.php`).
- Exception: `Drupal\representative_image\Exception\RepresentativeImageFieldNotDefinedException`.
- Config schema keys: `field.field_settings.representative_image`,
  `field.formatter.settings.representative_image`, `field.formatter.settings.entity_representative_image`,
  `field.widget.settings.representative_image`, `field.storage_settings.representative_image`. (A
  `representative_image.settings` config object is declared in schema but is a D7 leftover — not read by
  any code in this version.)
- Migrate sources / migrations: `d7_representative_image_field_storage_config`,
  `d7_representative_image_field_config`.
