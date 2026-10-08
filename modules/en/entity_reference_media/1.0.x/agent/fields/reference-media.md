# Field type, widget & formatter — entity_reference_media

The module ships one **field type** plus its matching **widget** and **formatter**, and a media-library
**opener service** so the widget works. It is an entity-reference-to-media field that also stores a few
**per-reference** values — a caption and a video start/end time — so the *same* media item can be shown
with a different caption / start-end each place it is referenced (that data lives on the reference, not
on the shared media entity).

| Kind | Machine id | Class | Extends |
|---|---|---|---|
| Field type | `entity_reference_media` | `EntityReferenceMedia` | core `EntityReferenceItem` |
| Field widget | `entity_reference_media_library` | `EntityReferenceMediaWidget` | core `MediaLibraryWidget` |
| Field formatter | `entity_reference_media_entity` | `EntityReferenceEntityFormatter` (subclass) | core `EntityReferenceEntityFormatter` |
| Service | `entity_reference_media.opener.field_widget` | `CustomMediaLibraryFieldWidgetOpener` | core `MediaLibraryFieldWidgetOpener` |

## Field type `entity_reference_media`

`src/Plugin/Field/FieldType/EntityReferenceMedia.php`. Label **"Media Enhanced"**, category **Reference**,
`default_widget = entity_reference_media_library`, `default_formatter = entity_reference_media_entity`,
`list_class = EntityReferenceFieldItemList`. Storage is hard-wired to media: `defaultStorageSettings()`
forces `target_type => 'media'`. `getPreconfiguredOptions()` returns `[]`, so it is NOT offered as a
pre-configured shortcut on the *Add field* screen — pick the generic **"Media Enhanced"** entry (under
*Reference*) and it targets media.

Columns added on top of the parent entity-reference item (`target_id`, `entity`) — `schema()`:

| Column / property | Storage type | Property type | Meaning |
|---|---|---|---|
| `default_caption` | `int` (tiny) | boolean | 1 = show the media's own caption; 0 = use `custom_caption`. |
| `custom_caption` | `text` (big) | string | Per-reference caption text (used when `default_caption` is 0). |
| `default_start_end` | `int` (tiny) | boolean | 1 = use the media's own start/end; 0 = use the values below. |
| `video_start` | `float` | string | Per-reference video start time. |
| `video_end` | `float` | string | Per-reference video end time. |

**Field settings** (`defaultFieldSettings()` + `fieldSettingsForm()`): `field_caption` (default `TRUE`) and
`field_start_end` (default `FALSE`). The settings form rewrites each into a **checkboxes** element keyed by
the reference handler's selected media **bundles** (`handler_settings.target_bundles`), so the stored value
is a per-bundle map, e.g. `field_caption: { image: image, remote_video: 0 }`. A bundle is only offered the
caption / start-end UI when it is enabled here. If no target bundles are selected the two controls are
hidden (`#access => !empty($mediaTypes)`).

## Widget `entity_reference_media_library`

`src/Plugin/Field/FieldWidget/EntityReferenceMediaWidget.php`. `multiple_values = TRUE`,
`field_types = { entity_reference_media }`. Extends the core Media Library widget, so selection is the
normal media-library modal. For each already-selected item it injects extra controls into
`selection[$delta]`, each gated by the field settings above for that item's bundle:

- `default_caption` — checkbox "Show default caption text" (shown when `field_caption` enabled for the bundle).
- `custom_caption` — textarea, visible (JS `#states`) only when `default_caption` is unchecked.
- `default_start_end` — checkbox "Use default video start/end time" (shown when `field_start_end` enabled).
- `video_start` / `video_end` — number inputs (`min 0`, `max 9999999999`), visible only when
  `default_start_end` is unchecked.

Both `default_*` checkboxes default to **TRUE/checked** when the stored value is NULL. The widget then
**swaps the media-library opener**: it rebuilds `open_button[#media_library_state]` with
`MediaLibraryState::create('entity_reference_media.opener.field_widget', …)` so the modal's access check
runs through this module's opener (see below) instead of core's, which does not recognise the custom field
type.

## Formatter `entity_reference_media_entity`

`src/Plugin/Field/FieldFormatter/EntityReferenceMediaFormatter.php`. Label **"Rendered entity"**. Extends
core `EntityReferenceEntityFormatter` (renders each referenced media through `entity_view()` in a chosen
`view_mode`), then optionally **overrides fields on the media entity in memory** with the per-reference
values before rendering. Injected services: `entity_field.manager`, `entity_type.bundle.info`.

Settings (`defaultSettings()` adds to the parent `view_mode` / `link`): `custom_caption`, `video_start`,
`video_end` — each a **per-media-bundle map** of *which field on the media entity* the per-reference value
should be written into. The settings form (`settingsForm()`) shows a bundle selector (`media_bundles`, a
form-only helper) and, per bundle, three selects listing that bundle's `string` / `string_long` / `text` /
`text_long` / `text_with_summary` fields to map caption / start / end onto. A mapping select is only shown
when the field type's `field_caption` / `field_start_end` is enabled for that bundle.

`viewElements()` behaviour per delta:
- If the item's `default_caption` is 0 **and** a `custom_caption` field is mapped for the bundle and the
  media has that field: it `set()`s that field to the reference's `custom_caption`. For text-type target
  fields it wraps as `['value' => …, 'format' => <existing format or basic_html>]` so the value is rendered
  through a text format; plain `string` targets get the raw value (escaped by the string formatter).
- If `default_start_end` is 0 **and** `video_start`/`video_end` fields are mapped: it `set()`s those media
  fields to the reference's `video_start` / `video_end`.
- Then renders the (mutated-in-memory, never saved) media entity via its view builder and adds `md5()` cache
  keys for the overridden values.

So overrides only take effect if (a) the field type has caption/start-end enabled for the bundle, (b) the
widget stored non-default values, and (c) the formatter maps them onto a real field that exists on the media
type. `settingsSummary()` currently returns the parent summary only (the extra summary lines are commented
out).

## Opener service `entity_reference_media.opener.field_widget`

`src/CustomMediaLibraryFieldWidgetOpener.php`, tagged `media_library.opener`, arg `@entity_type.manager`.
Copy of core's `MediaLibraryFieldWidgetOpener::checkAccess()` with one change: it accepts a field whose type
is `entity_reference` **or** `entity_reference_media` (core's only accepts `entity_reference`, so it would
reject this module's field). It still enforces the full check — required opener parameters present, entity
create/update access, `target_type === 'media'`, and field `edit` access — before allowing the media-library
modal to open. The docblock notes it is a stopgap until core issue
[#3179868](https://www.drupal.org/project/drupal/issues/3179868).

## Set up from code

```php
// 1. Storage (always targets media).
Drupal\field\Entity\FieldStorageConfig::create([
  'field_name' => 'field_media_enhanced',
  'entity_type' => 'node',
  'type' => 'entity_reference_media',
])->save();

// 2. Field instance: enable caption/start-end per media bundle.
Drupal\field\Entity\FieldConfig::create([
  'field_name' => 'field_media_enhanced',
  'entity_type' => 'node',
  'bundle' => 'article',
  'settings' => [
    'handler' => 'default:media',
    'handler_settings' => ['target_bundles' => ['image' => 'image']],
    'field_caption' => ['image' => 'image'],
    'field_start_end' => [],
  ],
])->save();

// 3. Widget + formatter on the displays.
\Drupal::service('entity_display.repository')
  ->getFormDisplay('node', 'article')
  ->setComponent('field_media_enhanced', ['type' => 'entity_reference_media_library'])
  ->save();
\Drupal::service('entity_display.repository')
  ->getViewDisplay('node', 'article')
  ->setComponent('field_media_enhanced', [
    'type' => 'entity_reference_media_entity',
    'settings' => [
      'view_mode' => 'default',
      // Map the per-reference caption onto a text field that exists on the image media type.
      'custom_caption' => ['image' => 'field_caption'],
    ],
  ])->save();
```

## Install / update

`entity_reference_media.install` has no install/requirements hook. `entity_reference_media_update_8001()`
back-fills the `_default_start_end` (int tiny), `_video_start` (float) and `_video_end` (float) columns onto
existing `<entity>__<field>` and `<entity>_revision__<field>` data tables for sites that created an
`entity_reference_media` field before those columns existed (uses the Schema API, idempotent via
`fieldExists`).
