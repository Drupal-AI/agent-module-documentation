<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enabling purging on a field

There is no settings page. You enable Entity Reference Purger on each `entity_reference`
field individually.

## Config field (Manage fields UI)

`entity_reference_purger_form_field_config_edit_form_alter()` adds an "Entity Reference
Purger" details section to the field edit form of any non-computed `entity_reference` field
(e.g. `/admin/structure/types/manage/article/fields/node.article.field_related`):

- **Remove orphaned entity references** → `remove_orphaned` (checkbox, default off).
- **Use queue** → `use_queue` (checkbox, **default on** in the form; only visible when
  `remove_orphaned` is checked). On = defer purge to cron; off = purge immediately on delete.

Stored as third-party settings on the `FieldConfig`, config
`field.field.<entity_type>.<bundle>.<field_name>`:

```yaml
third_party_settings:
  entity_reference_purger:
    remove_orphaned: true
    use_queue: false
```

Config schema: `field.field.*.*.*.third_party.entity_reference_purger`
(`remove_orphaned: boolean`, `use_queue: boolean`).

### Set it programmatically on a config field

```php
$fc = \Drupal\field\Entity\FieldConfig::loadByName('node', 'article', 'field_related');
$fc->setThirdPartySetting('entity_reference_purger', 'remove_orphaned', TRUE);
$fc->setThirdPartySetting('entity_reference_purger', 'use_queue', FALSE);
$fc->save();
```

Read it back with `$fc->getThirdPartySettings('entity_reference_purger')` or
`$fc->getThirdPartySetting('entity_reference_purger', 'remove_orphaned')`.

## Base field (code)

For a base `entity_reference` field, add the setting to its `BaseFieldDefinition`:

```php
$fields['my_ref'] = BaseFieldDefinition::create('entity_reference')
  ->setSetting('target_type', 'node')
  ->setSetting('entity_reference_purger', [
    'remove_orphaned' => TRUE,
    'use_queue' => FALSE,
  ]);
```

The module reads `remove_orphaned` / `use_queue` from `getThirdPartySettings()` for
`FieldConfig` and from `getSetting('entity_reference_purger')` for `BaseFieldDefinition`.
Computed fields are ignored.
