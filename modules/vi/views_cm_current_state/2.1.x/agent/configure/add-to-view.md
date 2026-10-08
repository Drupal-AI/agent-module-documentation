<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add the "Current state" field to a view

The module has **no configuration of its own** (`configure: null`, no schema, no settings). You use
it by adding its Views field to a view.

## Via the Views UI

1. Edit any view (e.g. `/admin/structure/views/view/content`).
2. Under **Fields**, click **Add**.
3. Search for **Current state** — it is listed under the **Content revision** group (it is offered
   on every view because it is attached to the global `views` table).
4. Add and **Apply**. Give it a label such as "Current state". Save the view.

The field has no special settings beyond the standard Views field options (label, rewrite, exclude,
`hide_alter_empty`). It renders the latest revision's moderation-state label at display time.

## Config shape (in a `views.view.*` config entity)

Inside `display.<display>.display_options.fields`, the component looks like:

```yaml
current_state_views_field:
  id: current_state_views_field
  table: views                       # the global/special table, NOT the entity table
  field: current_state_views_field
  plugin_id: current_state_views_field
  relationship: none
  label: 'Current state'
```

## Scriptable (drush php:eval)

```php
$view = \Drupal\views\Entity\View::load('content');
$display = &$view->getDisplay('default');
$display['display_options']['fields']['current_state_views_field'] = [
  'id' => 'current_state_views_field',
  'table' => 'views',
  'field' => 'current_state_views_field',
  'plugin_id' => 'current_state_views_field',
  'label' => 'Current state',
];
$view->save();
```

## Read it back

```bash
drush cget views.view.content display.default.display_options.fields.current_state_views_field
```

## Requirements / gotchas

- Both `views` and `content_moderation` must be enabled (module dependencies).
- The value reflects the **latest** revision (a pending draft), which is why it can differ from the
  core "Moderation state" field in the same view.
- The field adds nothing to the SQL query (its `query()` is a no-op); it computes from the loaded
  row entity. It is therefore not sortable or filterable as a real column.
