# Showing an entity's UUID (widget + formatter)

UUID Extra has no config page. You enable UUID display through the normal display UIs (or by
editing the display config entities). The module's job is only to make the `uuid` base field
*appear* in those UIs and to provide the two plugins that render it.

## What the module changes

- `uuid_extra_entity_base_field_info_alter()` — for every entity type, takes the field named by
  `$entity_type->getKey('uuid')` and marks it `setDisplayConfigurable('view', TRUE)` and
  `setDisplayConfigurable('form', TRUE)`. That is what makes `uuid` show up as a row on
  *Manage form display* and *Manage display*.
- `uuid_extra_form_alter()` — sets `$form['uuid']['#access'] = TRUE` when the active form display
  has a `uuid` component, so the widget is actually reachable on the edit form.

## The two plugins

| Kind | id | Class | Behavior |
|---|---|---|---|
| Field widget | `uuid` | `UuidFieldWidget` | Renders a **disabled** `textfield` prefilled with the current UUID — visible but not editable. |
| Field formatter | `uuid` | `UuidFieldFormatter` | Outputs each item's `value` (the UUID string) as `#markup`. |

Both declare `field_types = { "uuid" }`, i.e. they only apply to the entity `uuid` field.

## UI steps

- **On the edit form:** go to *Structure → Content types → <type> → Manage form display*, drag
  **UUID** out of *Disabled*, pick the **UUID** widget, Save. The field shows as a read-only textfield.
- **On rendered output:** go to *Manage display* (choose the view mode), enable **UUID**, pick the
  **UUID** formatter, Save.

The same applies to any entity type that has a `uuid` key (users, taxonomy terms, media, …) via
that entity's own Manage form/display pages.

## Doing it in code / config

Set a `uuid` component on the relevant display config entity:

```php
// Read-only UUID on the Article edit form.
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$fd->setComponent('uuid', ['type' => 'uuid', 'weight' => 99, 'region' => 'content'])->save();

// Render the UUID on the Article default view display.
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('uuid', ['type' => 'uuid', 'label' => 'inline', 'weight' => 99, 'region' => 'content'])->save();
```

In exported config this is a `content.uuid` entry (with `type: uuid`) inside
`core.entity_form_display.*` / `core.entity_view_display.*`. Remove it with `removeComponent('uuid')`
(equivalently, drag the field to *Disabled* in the UI).
