<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the IEF table columns

There is no admin settings page. Setup happens in two places: the **referencing** field's form
display (pick the widget) and the **referenced** bundle's `ief_table` **view mode** display (pick
the columns).

## 1. Use the widget on the reference field

On the entity that *contains* the entity_reference field, Manage form display → set that field's
widget to **"Inline entity form - Complex - Table View Mode"**
(`inline_entity_form_complex_table_view_mode`), configure it, and **Save**.

Equivalent config (form display component):

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$c = $fd->getComponent('field_ief_ref');            // an entity_reference field (e.g. → node)
$c['type'] = 'inline_entity_form_complex_table_view_mode';
$fd->setComponent('field_ief_ref', $c)->save();
```

Saving this form display fires `hook_entity_update()`, which **auto-creates the view mode**
`<target_entity_type>.ief_table` (label "Inline Entity Form Table") if it does not exist —
e.g. `node.ief_table`. (You can also create it manually at
*Structure → Display modes → View modes*, machine name `<entity_type>.ief_table`.)

## 2. Enable and configure the `ief_table` display for the referenced bundle

On the *referenced* bundle (the entity type the field points at), go to Manage display, enable the
**"Inline Entity Form Table"** custom display, switch to that secondary tab, and place/order the
fields you want as columns.

Equivalent config (view display for the referenced bundle):

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->create([
  'targetEntityType' => 'node',
  'bundle' => 'article',
  'mode' => 'ief_table',
  'status' => TRUE,
]);
$vd->setComponent('title', ['type' => 'string', 'label' => 'hidden', 'weight' => 0]);
$vd->setComponent('body',  ['type' => 'text_default', 'label' => 'hidden', 'weight' => 1]);
$vd->save();
```

Each configured, visible field/extra-field becomes a **column** in the IEF table (see
[plugins/widget.md](../plugins/widget.md) for the column-building logic). Field labels are hidden
in the table; the module hides the label column in the `ief_table` view-display edit form and marks
IEF's native columns with a `*`.

## Notes

- The `ief_table` view mode cannot be deleted while the module is enabled
  (`hook_entity_view_mode_access()` forbids `delete` for `<entity_type>.ief_table`).
- Read back the widget: `drush cget core.entity_form_display.node.article.default content.field_ief_ref`
  → look for `type: inline_entity_form_complex_table_view_mode`.
- Read back the columns: `drush cget core.entity_view_display.node.article.ief_table`.
