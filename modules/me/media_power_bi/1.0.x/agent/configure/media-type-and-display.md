<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Set up a Power BI media type and its display

There is **no configure route** (`configure: null`) and no settings page. Setup is: create a
Media type that uses the `media_power_bi` source, then place/format the media. State lives in
the `media.type.<id>` config entity plus the source-field config.

## The media source plugin

- id: `media_power_bi`, label **"Media Power BI"**
- `allowed_field_types = {"string_long"}` — the source field is a plain long-text field holding
  the embed URL.
- `default_thumbnail_filename = "generic.png"`, `getMetadataAttributes()` returns `[]` (no
  extracted metadata).
- Declares a source-field constraint `media_power_bi` (see Validation below).
- Provides a Media Library add form: `media_library_add =
  Drupal\media_power_bi\Form\MediaPowerBiMediaForm` (form id ends `_power_bi`), a single
  **"Embed Code"** textarea for pasting the Power BI share/embed fragment.

## Create the media type (UI)

1. Go to *Configuration → Media → Media types* (`/admin/structure/media/add`).
2. Set a name (e.g. "Power BI"), and for **Media source** choose **Media Power BI**.
3. Save. Drupal creates the `string_long` source field automatically.

## Create the media type (scriptable)

```php
use Drupal\media\Entity\MediaType;
$type = MediaType::create([
  'id' => 'power_bi', 'label' => 'Power BI', 'source' => 'media_power_bi',
]);
$type->save();
// Create + wire the source field the source plugin defines:
$source = $type->getSource();
$field = $source->createSourceField($type);
$field->getFieldStorageDefinition()->save();
$field->save();
$type->set('source_configuration', ['source_field' => $field->getName()])->save();
```

Read back the source: `drush cget media.type.power_bi source` → `media_power_bi`.

## Validation constraint

- Constraint id `media_power_bi` (`MediaPowerBiConstraint`), validator
  `MediaPowerBiConstraintValidator`, applied to the source field.
- The stored URL is trimmed and must be **non-empty** (`emptyUrlMessage`) and its host must be
  one of `app.powerbi.com`, `app.powerbigov.us`, `app.high.powerbigov.us`,
  `app.mil.powerbigov.us` (`MediaPowerBiHelper::isValidPowerBiUrl()`), else `invalidUrlMessage`
  ("This does not appear to contain a valid Power BI embed…").

## Display formatter

- Formatter id `media_power_bi` (label "Media Power BI"), for `string_long` fields — set it on
  the source field's **Manage display** for the media type.
- Settings: `width` (default `100%`) and `height` (default `900px`) — any valid CSS unit.
- It renders the `media_power_bi` theme hook (an `<iframe>`) only when the value passes the
  same host validation; invalid/empty items render nothing. See
  [../theming/iframe-template.md](../theming/iframe-template.md).

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('media.power_bi.default');
$vd->setComponent('field_media_media_power_bi', [
  'type' => 'media_power_bi', 'label' => 'hidden',
  'settings' => ['width' => '100%', 'height' => '600px'],
])->save();
```

(The source field name is whatever `createSourceField()` generated, e.g.
`field_media_media_power_bi` — check `media.type.power_bi` → `source_configuration.source_field`.)
