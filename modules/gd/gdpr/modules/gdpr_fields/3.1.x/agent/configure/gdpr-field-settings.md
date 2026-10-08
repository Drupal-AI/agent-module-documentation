<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GDPR field settings and the `gdpr_fields_config` config entity

There is no dedicated settings page. GDPR settings are added to each field's normal edit form
(`hook_form_field_config_edit_form_alter` adds a "GDPR field settings" details element), and
on submit they are written to the `gdpr_fields_config` config entity for that entity type.

## The config entity

- Entity type `gdpr_fields_config` (class `GdprFieldConfigEntity`), `config_prefix
  gdpr_fields_config`, id = the **entity type id** (e.g. `user`, `node`).
- Config object name: `gdpr_fields.gdpr_fields_config.<entity_type>`.
- `config_export`: `id`, `bundles`, `filenames`.

Structure:
```yaml
# config: gdpr_fields.gdpr_fields_config.user
id: user
bundles:
  user:                     # bundle
    mail:                   # field name
      bundle: user
      name: mail
      entity_type_id: user
      enabled: true
      rta: inc              # Right to Access: inc | maybe | no
      rtf: anonymize        # Right to be Forgotten: anonymize | remove | maybe | no
      anonymizer: email_anonymizer   # an anonymizer plugin id
      notes: ''
      relationship: 0       # 0 disabled, 1 follow, 2 owner/reverse
      sars_filename: ''
filenames:
  user: ''
```

Per-field keys: `enabled` (bool), `rta` (`inc|maybe|no`), `rtf`
(`anonymize|remove|maybe|no`), `anonymizer` (anonymizer plugin id), `notes`, `relationship`
(int 0/1/2), `sars_filename`, `entity_type_id`.

## Third-party settings mirror

A simplified copy is stored on the field config itself:
`field.field.<entity>.<bundle>.<field>.third_party.gdpr_fields` with `gdpr_fields_rta` and
`gdpr_fields_rtf` (see `config/schema/gdpr_field.schema.yml`).

## Set it programmatically

```php
use Drupal\gdpr_fields\Entity\GdprFieldConfigEntity;
use Drupal\gdpr_fields\Entity\GdprField;

$config = GdprFieldConfigEntity::load('user') ?? GdprFieldConfigEntity::create(['id' => 'user']);
$field = new GdprField(['bundle' => 'user', 'name' => 'mail', 'entity_type_id' => 'user']);
$field->setEnabled(TRUE)->setRta('inc')->setRtf('anonymize')->setAnonymizer('email_anonymizer');
$config->setField($field);
$config->save();

// read back:
GdprFieldConfigEntity::load('user')->getField('user', 'mail')->anonymizer; // 'email_anonymizer'
```

`GdprField` setters: `setEnabled`, `setRta`, `setRtf`, `setAnonymizer`, `setNotes`; the RTF/RTA
human labels come from `rtfDescription()` / `rtaDescription()`.
