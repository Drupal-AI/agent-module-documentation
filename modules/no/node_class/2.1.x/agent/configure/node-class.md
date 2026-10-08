<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Set and read a node's CSS class

There is **no admin settings page** (`configure: null`). The class is stored on each node in the
base field `node_class`, which the module adds to the `node` entity type for all bundles.

## Where it appears in the UI

On any node add/edit form there is a collapsible **"Node Class settings"** group in the right-hand
*advanced* sidebar (same area as Authoring information / URL alias), containing a **"CSS class(es)"**
text field. Type one or more space-separated classes and save. The group is added by
`node_class_form_node_form_alter()` and is closed by default.

## Set it programmatically

`node_class` is a normal base field, so set it like any node field:

```php
$node = \Drupal\node\Entity\Node::load(123);
$node->set('node_class', 'featured two-column');
$node->save();
```

At creation time:

```php
$node = \Drupal\node\Entity\Node::create([
  'type' => 'article',
  'title' => 'Promoted',
  'node_class' => 'featured',
]);
$node->save();
```

## Read it back

```php
$value = \Drupal\node\Entity\Node::load(123)->get('node_class')->value; // e.g. "featured two-column"
```

Or over drush:

```bash
drush php:eval 'print \Drupal\node\Entity\Node::load(123)->get("node_class")->value;'
```

## Field characteristics

- It is a **base field** (`BaseFieldDefinition::create('string')`), so it exists on every content
  type automatically — you do **not** add it per bundle under *Manage fields*.
- It is `setDisplayConfigurable('form', TRUE)` with a `string_textfield` widget at weight 35, so its
  form widget can be moved/hidden per bundle on *Manage form display* if desired.
- Cardinality is 1 (a single string). To apply several classes, put them space-separated in the one
  value; the whole string is appended as a single class token (see `theming/output.md`).
- No `config/install` and no `config/schema` ship with the module; nothing to `drush cget`.

## "Turn it off" for a bundle

Because it is a base field, you cannot delete it per bundle. To hide the input on a given content
type, set the `node_class` widget to *Disabled* (hidden region) on that bundle's *Manage form
display*. Existing stored values still render unless cleared.
