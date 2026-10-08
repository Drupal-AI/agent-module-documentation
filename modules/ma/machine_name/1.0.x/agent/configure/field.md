# Configure the machine_name field

No module settings page — you configure it as a normal field on an entity bundle.

## Add the field

*Structure › (bundle) › Manage fields › Add field* → choose **Machine name**. Storage: `varchar`,
length 64, indexed, NOT NULL, default `''` (cardinality as chosen). Set the widget on *Manage form
display* and the formatter on *Manage display*.

## Widget settings (`machine_name` widget)

Schema `field.widget.settings.machine_name`:

| Setting | Default | Effect |
|---|---|---|
| `editable` | `FALSE` | When FALSE, the input is `#disabled` once the entity is **not new** (value locked after first save). TRUE keeps it editable. |
| `unique` | `TRUE` | Enables the `MachineNameUnique` uniqueness check (see below). |

The widget renders `#type = 'machine_name'`, `#maxlength = 64`, with an `exists` callback that
**always returns FALSE** — the real uniqueness enforcement is the validation constraint, not the element's
live check.

## Uniqueness constraint

The field item carries a `MachineNameUnique` constraint (case-sensitive). `MachineNameUniqueValidator`:

1. Skips empty values.
2. Loads `<entity_type>.<bundle>.default` `entity_form_display`; if that display's component for this field
   does **not** have `settings.unique` truthy, it does nothing.
3. Runs `\Drupal::entityQuery(<entity_type>)->accessCheck(FALSE)` matching `<field>.value`, excluding the
   current entity id, and adds violation *"The machine name %value is already in use…"* if any match.

Caveats for agents:
- Uniqueness is driven by the **default** form-display widget settings, even when saving via another form
  mode or programmatically — enable `unique` on the default form display to have it enforced everywhere.
- The query uses `accessCheck(FALSE)`, so uniqueness is checked against all entities regardless of the
  current user's access.

## Formatter (`machine_name`)

Outputs each value as `nl2br(Html::escape($item->value))` — plain, escaped text.

## Set widget settings via Drush

```php
// drush php:eval — machine_name widget on node.article.field_key, locked & unique.
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$fd->setComponent('field_key', [
  'type' => 'machine_name', 'region' => 'content',
  'settings' => ['editable' => FALSE, 'unique' => TRUE],
])->save();
```
