<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Override a base field's label / description

The module only exposes core's `base_field_override` config entity through a UI. You override
the **label** and **description** of a base field for one bundle.

## Where it is stored

Config entity: `base_field_override` (core). Id/name:
`<entity_type>.<bundle>.<field_name>` → config
`core.base_field_override.<entity_type>.<bundle>.<field_name>`.

```bash
drush cget core.base_field_override.node.article.title
# label: 'Headline'   description: '...'
```

## Via the UI

1. Go to the bundle's *Manage fields* page (e.g. Article:
   `/admin/structure/types/manage/article/fields`).
2. Click the **Base fields Override** secondary tab (beside *Fields*).
3. Use the list to **Add**/**Edit**/**Delete** an override for a base field. The edit form
   (`BaseFieldOverrideForm`) exposes **Label** (required) and **Description**, plus the base
   field type's own field-settings form.
4. **Save settings**. Deleting the override reverts to the code-defined default.

Requires permission `administer <entity_type> fields` (e.g. `administer node fields`), and the
base field must be display-configurable on the form.

## Programmatically (scriptable)

```php
use Drupal\Core\Field\Entity\BaseFieldOverride;

$def = \Drupal::service('entity_field.manager')
  ->getFieldDefinitions('node', 'article')['title'];        // a base field definition
BaseFieldOverride::createFromBaseFieldDefinition($def, 'article')
  ->setLabel('Headline')
  ->setDescription('The article headline.')
  ->save();
```

To load/modify an existing one:
`BaseFieldOverride::load('node.article.title')->setLabel('...')->save();`
To revert: `BaseFieldOverride::load('node.article.title')->delete();`
