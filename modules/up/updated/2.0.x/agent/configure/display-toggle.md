<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `display_updated` toggle & permission

Whether the [Last Updated block](block.md) shows on a given node is decided by a boolean base
field, **`display_updated`**, that the module adds to every node type
(`updated_entity_base_field_info()`). Default value: **FALSE**.

## Per-node checkbox

`updated_form_node_form_alter()` puts the `display_updated` widget on the node edit form as a
"Display updated date" checkbox, grouped into a "Page display options" details section
(`#group` `advanced`, i.e. the sidebar). Untick it to hide the updated date on that node; tick
it to show it (the block's access then allows it).

Scriptable — it's a normal entity field:

```php
$node->set('display_updated', TRUE)->save();   // show the updated-date block on this node
```

## Per-content-type default

`updated_form_node_type_form_alter()` adds a "Display updated date." checkbox to each content
type's edit form ("Page display defaults"). Saving it writes the bundle default through a
`BaseFieldOverride` (config `core.base_field_override.node.<bundle>.display_updated`,
`default_value: [{ value: 1 }]`). New nodes of that type then default to the chosen value
(still overridable per node).

```php
// Make new Article nodes default to showing the updated date.
$defs = \Drupal::service('entity_field.manager')->getFieldDefinitions('node', 'article');
$defs['display_updated']->getConfig('article')->setDefaultValue(TRUE)->save();
\Drupal::service('entity_field.manager')->clearCachedFieldDefinitions();
```

Read back: `drush cget core.base_field_override.node.article.display_updated default_value`, or
create a dummy node and check `->display_updated->value`.

## Permission: `administer node last updated date`

Defined in `updated.permissions.yml` ("Configure the display of the node last updated date").
Users **without** it see the `display_updated` field **disabled** on both the node form and the
content-type form (with an explanatory message); users with it can toggle it. The permission
governs only this module's block display, not other ways of showing the changed date.

Grant it:

```php
\Drupal\user\Entity\Role::load('content_editor')
  ->grantPermission('administer node last updated date')->save();
```

## Uninstall note

`updated_uninstall()` deletes the `display_updated` `BaseFieldOverride`s it created for each
node type.
