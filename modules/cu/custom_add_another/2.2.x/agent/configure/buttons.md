<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Customise the "Add another item" / "Remove" button labels

There is no admin settings page (`configure: null`). You set the labels per field instance on the
field's edit form, and they are stored as third-party settings on the `FieldConfig` entity.

## When the options appear

The two text fields are added to the *field instance edit form* (`field_config_edit_form`)
**only** when:

- the field's **Number of values** (cardinality) is **Unlimited** (`-1`,
  `FieldStorageDefinitionInterface::CARDINALITY_UNLIMITED`), and
- the field storage is **not locked**.

On a single- or fixed-count field there is no "Add another" button, so the options are hidden.

## Via the UI

1. Go to the bundle's **Manage fields** and click **Edit** on an unlimited multi-value field
   (e.g. Article → `field_gallery`).
2. Fill in **Custom add another item button** (e.g. `Add another image`) and/or
   **Custom remove button** (e.g. `Remove image`).
3. **Save settings.** Leaving a box empty restores the default label for that button.

## Where the settings are stored

Config entity: `field.field.<entity_type>.<bundle>.<field_name>` (e.g.
`field.field.node.article.field_gallery`):

```yaml
third_party_settings:
  custom_add_another:
    custom_add_another: 'Add another image'   # the "Add another item" button label
    custom_remove: 'Remove image'             # the "Remove" button label
```

Config schema: `field.field.*.*.*.third_party.custom_add_another` (two `string` keys,
`custom_add_another` and `custom_remove`).

## Read it back

```bash
drush cget field.field.node.article.field_gallery third_party_settings.custom_add_another
```

Or in PHP:

```php
$fc = \Drupal\field\Entity\FieldConfig::loadByName('node', 'article', 'field_gallery');
$add = $fc->getThirdPartySetting('custom_add_another', 'custom_add_another');   // add-another label
$rem = $fc->getThirdPartySetting('custom_add_another', 'custom_remove');        // remove label
```

## Scriptable (drush php:eval)

```php
$fc = \Drupal\field\Entity\FieldConfig::loadByName('node', 'article', 'field_gallery');
$fc->setThirdPartySetting('custom_add_another', 'custom_add_another', 'Add another image');
$fc->setThirdPartySetting('custom_add_another', 'custom_remove', 'Remove image');
$fc->save();
```

To clear a label, `unsetThirdPartySetting('custom_add_another', '<key>')` and save (the module does
this automatically when the form field is submitted empty).

## Notes

- Settings are **per field instance / per bundle**: the same field on two bundles can carry
  different button text.
- Applies to the standard multi-value `add_more`/`remove_button`, and also to the upload/remove
  buttons of multiple **managed_file** widgets (file and image fields).
