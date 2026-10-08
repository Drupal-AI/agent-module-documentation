<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Collector & entity traversal API

GDPR Fields exposes the metadata plus helpers to walk an entity's data graph. These are what
GDPR Tasks uses to build a Subject Access Request export or a removal.

## Reading field metadata

```php
use Drupal\gdpr_fields\Entity\GdprFieldConfigEntity;
$config = GdprFieldConfigEntity::load('user');
$field  = $config->getField('user', 'mail');   // GdprField
$field->enabled; $field->rta; $field->rtf; $field->anonymizer; $field->relationship;
$config->getAllFields();                        // all GdprField for this entity type
```

`GdprField` also has `rtaDescription()` / `rtfDescription()` (human labels), and relationship
constants `RELATIONSHIP_DISABLED = 0`, `RELATIONSHIP_FOLLOW = 1`, `RELATIONSHIP_OWNER = 2`.

## Services

- `gdpr_fields.collector` — `GDPRCollector` (constructed with `entity_type.manager`,
  `entity_field.manager`, `entity_type.bundle.info`): collects entity types/bundles/fields and
  their GDPR settings for the report and for traversal.
- `EntityTraversal` / `EntityTraversalFactory` (`EntityTraversalInterface`,
  `EntityTraversalContainerInjectionInterface`) — walk from a root entity across configured
  relationships (`relationship = 1` follow, `2` owner) to gather all of a subject's data.
  GDPR Tasks provides concrete traversals
  (`RightToAccessEntityTraversal`, `RightToBeForgottenEntityTraversal`, and the display
  variants) built via `EntityTraversalFactory` (see the gdpr_tasks services).

## Permissions & report

- Permissions: `view gdpr fields`, `edit gdpr fields`.
- Report: `GDPRController::fieldsList()` at `/admin/reports/fields/gdpr-fields`
  (route `gdpr_fields.fields_list`), filter form `GdprFieldFilterForm`.

No hooks are invited beyond the standard field-form alter; to change behaviour, write the
`gdpr_fields_config` config (see [../configure/gdpr-field-settings.md](../configure/gdpr-field-settings.md))
or consume the traversal services from your own code.
