<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enabling rotation on an image field

There is **no module settings page** (`configure: null`). Rotation is turned on **per image
field** via a third-party setting, and gated by a permission.

## Via the UI

1. Go to the image field's settings: *Structure › Content types › <type> › Manage fields ›
   <image field> › Edit*.
2. Tick **"Enable rotate function"** ("If checked a button to rotate the image will appear near
   each uploaded image").
3. Save. Ensure the roles that should rotate have the **`rotate images`** permission.

## Where it is stored

On the field instance (`FieldConfig`) as a third-party setting:

```
field.field.<entity_type>.<bundle>.<field_name>:
  third_party_settings:
    simple_image_rotate:
      enable_rotate: true
```

(Schema: `field.field_settings.image.*.third_party.simple_image_rotate` → `enable_rotate` bool.)

## In code

```php
use Drupal\field\Entity\FieldConfig;

$fc = FieldConfig::loadByName('node', 'article', 'field_photo');   // an image field
$fc->setThirdPartySetting('simple_image_rotate', 'enable_rotate', TRUE);
$fc->save();

// read it back:
$enabled = $fc->getThirdPartySetting('simple_image_rotate', 'enable_rotate', FALSE);
```

## Notes

- Only **image** fields are affected; the checkbox is added by
  `hook_form_field_config_edit_form_alter()` only when the field type is `image`.
- The rotate button appears in the widget only when `enable_rotate` is on **and** the current
  user has `rotate images` (see [../permissions/permissions.md](../permissions/permissions.md)).
- The actual file rotation happens on save — see [../api/mechanism.md](../api/mechanism.md).
