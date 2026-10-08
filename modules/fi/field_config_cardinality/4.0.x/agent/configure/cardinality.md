<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Set per-instance (per-bundle) cardinality

Core cardinality lives on the **field storage** and is shared by all bundles. This module adds a
per-**instance** override stored on the `FieldConfig`.

## Where it is stored

Config entity: `field.field.<entity_type>.<bundle>.<field_name>`

```yaml
third_party_settings:
  field_config_cardinality:
    cardinality_config: '3'      # instance limit: a positive number, or '-1' for unlimited
    cardinality_label_config: false          # optional: use custom empty-label text
    # optional custom empty-label text (only when cardinality_label_config is true):
    unlimited_not_required: ''
    limited_not_required: ''
    limited_required: ''
```

- `cardinality_config` (string) is the effective per-instance limit. It must be **≤ the storage
  cardinality**. If the storage is unlimited (`-1`) you may set any positive number; if the
  storage is limited to N you can only go down to N.
- Omit / empty `cardinality_config` ⇒ the instance uses the storage cardinality (no override).

## Via the UI

1. Go to the field instance edit form, e.g. **Structure → Content types → <type> → Manage fields
   → <field> → Edit** (route `entity.field_config.node_field_edit_form`, form
   `field_config_edit_form`).
2. In the **"Allowed number of values (Cardinality Instance)"** fieldset choose **Limited** (and
   a number) or **Unlimited**. (Unlimited is only offered if the storage itself is unlimited.)
3. Optionally tick **"Use Cardinality Empty label config"** to set custom empty-label text in the
   **"Empty label options (Cardinality Instance)"** fieldset for the unlimited-not-required,
   limited-not-required, and limited-required cases.
4. Save. The entity builder `field_config_cardinality_form_builder` writes `cardinality_config`
   (and the label options) into the instance's third-party settings.

## Via drush / PHP

```php
$fc = \Drupal::entityTypeManager()->getStorage('field_config')
  ->load('node.page.field_tags');                  // <entity>.<bundle>.<field>
$fc->setThirdPartySetting('field_config_cardinality', 'cardinality_config', '3'); // limit to 3
$fc->save();
```

Read it back:

```bash
drush cget field.field.node.page.field_tags third_party_settings.field_config_cardinality
```

Or in PHP:
`$fc->getThirdPartySetting('field_config_cardinality', 'cardinality_config')`.

## Notes

- The field **storage** must allow at least the instance limit. Set the storage to unlimited (or
  ≥ your target) first; this module never raises a storage's cap.
- Config schema `field.field.*.*.*.third_party.field_config_cardinality` validates
  `cardinality_config`, `cardinality_label_config`, and `cardinality_label_options`.
- The stored value is only the *configuration*; the actual capping of value rows happens in the
  widget at form-render time — see [../api/widgets.md](../api/widgets.md).
