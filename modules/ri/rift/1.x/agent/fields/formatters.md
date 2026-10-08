# Field formatters

RIFT applies to an **`entity_reference` field whose `target_type` is `media`** (a media-reference
field), not to a core image field. Both formatters extend core's `EntityReferenceEntityFormatter`
and render each referenced media through `{{ media|rift_picture(config) }}`, where `config` is the
selected RIFT view-mode definition.

## `rift_media_entity_reference_picture` — "Rift Media Picture"

`src/Plugin/Field/FieldFormatter/RiftMediaEntityReferencePictureFormatter.php`

- Settings: `view_mode` (a select of `rift_picture_view_modes` definitions; **required**). Schema:
  `field.formatter.settings.rift_picture` (`view_mode: string`).
- `viewElements()` builds one `inline_template` per referenced entity:
  `'{{ media|rift_picture(config) }}'` with `config = definitions[$view_mode] ?? []`. Cache metadata
  merges the entity's tags/contexts/max-age with `rift.settings` cache tags; cache keys include the
  entity type/id and view mode.
- `isApplicable()`: only for `entity_reference` → `media` **where every target bundle's media source
  plugin id is `image`**. So it is offered only for image-only media-reference fields.

## `rift_media_entity_reference_picture_with_fallback` — "Rift Media Picture (with fallback)"

`…/RiftMediaEntityReferencePictureWithFallbackFormatter.php`

- Settings: `rift_view_mode` (RIFT view mode) **and** `view_mode` (a standard media view mode used as
  the fallback), plus `link`. `defaultSettings()` = `['rift_view_mode' => '', 'view_mode' => 'default',
  'link' => FALSE] + parent::defaultSettings()`.
- `viewElements()`: starts from `parent::viewElements()` (the normal entity-reference render using the
  fallback view mode), then, for each referenced media **whose source plugin id is `image`**, replaces
  the element with the RIFT picture. Non-image media (video, SVG, …) keep the fallback rendering. Note
  the RIFT override reads `$this->getSetting('rift_view_mode')`.
- `isApplicable()`: any `entity_reference` → `media` field (broader than the plain formatter, since it
  can fall back for non-image bundles).

## Configuring on a field

Manage display of the entity holding the media-reference field → set the field's format to *Rift
Media Picture* (or *… with fallback*) → pick a **Rift View mode** (defined in
`rift.settings:view_modes` or a `*.rift_picture_view_modes.yml` plugin). The view modes and the
image styles they need are created via the RIFT settings/UI or the starter kit
(see [configure/settings.md](../configure/settings.md)).
