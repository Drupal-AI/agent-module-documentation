# Protect nodes with Node Keep

## Base fields (on every node)

`node_keep_entity_base_field_info()` adds to all node bundles:

- **`node_keeper`** (boolean) — "Prevent this node from being deleted". Revisionable, translatable.
- **`alias_keeper`** (boolean) — "Prevent this node's alias from being changed". **Only added when
  the `pathauto` module is enabled.**

Both are shown as checkboxes in a "Node keep" details section in the node form's advanced sidebar
(`node_keep_form_node_form_alter()`).

## Per node (edit form or code)

UI: edit the node → open **Node keep** in the right sidebar → tick the box → Save. Requires
`administer node_keep per node` to change and `access node_keep widget` to even see it.

Code:

```php
$node->set('node_keeper', TRUE);   // block deletion
$node->set('alias_keeper', TRUE);  // block alias change (Pathauto only)
$node->save();
```

Read back: `$node->get('node_keeper')->value` (1/0). Query all protected nodes:

```php
$nids = \Drupal::entityTypeManager()->getStorage('node')
  ->getQuery()->accessCheck(FALSE)->condition('node_keeper', 1)->execute();
```

## Per content type defaults

The node type form gains a **"Node keep defaults"** section (`node_keep_form_node_type_form_alter()`)
with a checkbox per field. Saving stores two things:

1. Third-party settings on the `node.type.<bundle>` config entity:
   `$type->setThirdPartySetting('node_keep', 'node_keeper', TRUE)` (and `alias_keeper`).
2. The **default value of the base field override** for that bundle, so new nodes inherit it
   (`node_keep_form_node_type_submit()` calls `->getConfig($bundle)->setDefaultValue(...)->save()`).

```php
$type = \Drupal\node\Entity\NodeType::load('article');
$type->setThirdPartySetting('node_keep', 'node_keeper', TRUE)->save();
```

## Global settings

Config object `node_keep.settings`, form route `node_keep.settings` → `/admin/config/content/node-keep`
(permission `administer node_keep`). Only key:

| Key | Type | Default | Effect |
|---|---|---|---|
| `hide_warning_messages` | bool | (unset ⇒ falsy) | Hide the "limited access permissions" warning shown on protected nodes' edit/delete pages |

```bash
drush cset node_keep.settings hide_warning_messages true -y
```
