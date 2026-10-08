# Mapping UI routes & permissions

## Routes

| Route | Path | Permission |
|---|---|---|
| `entity.salesforce_mapping.list` | `/admin/structure/salesforce/mappings` | `administer salesforce mapping` |
| `entity.salesforce_mapping.add_form` | `/admin/structure/salesforce/mappings/add` | `administer salesforce mapping` |
| `entity.salesforce_mapping.edit_form` | `/admin/structure/salesforce/mappings/manage/{salesforce_mapping}` | `administer salesforce mapping` |
| `entity.salesforce_mapping.fields` | `.../manage/{salesforce_mapping}/fields` | `administer salesforce mapping` |
| enable / disable / delete forms | `.../manage/{salesforce_mapping}/{enable\|disable\|delete}` | `administer salesforce mapping` |
| `entity.salesforce_mapped_object.list` | `/admin/content/salesforce` | `administer salesforce mapped objects` |

(The very top `/admin/structure/salesforce` list also checks `administer salesforce`.)

## Grant access

To let a role manage mappings via the UI, grant the `salesforce_mapping` permission:
```php
$role = \Drupal\user\Entity\Role::load('sf_admin');
$role->grantPermission('administer salesforce mapping')->save();
```
```bash
drush role:perm:add sf_admin 'administer salesforce mapping'
```
For mapped-object management, grant `administer salesforce mapped objects`.

## What the field-mapping form does

`.../manage/{mapping}/fields` builds the mapping's `field_mappings` — each row selects a
SalesforceMappingField plugin (`properties`, `record_type`, …; see
`salesforce_mapping/plugins/field-plugins.md`), a Drupal field/property, a Salesforce field,
and a direction.

## Notes

- This module adds **no config of its own** — it edits `salesforce_mapping` entities. Read
  those back with `drush cget salesforce.mapping.<id>`.
- The mapping entity model is documented under `salesforce_mapping`.
