# Enable & configure the Groups field

There is **no settings page** (`configure: null`). The `entitygroupfield` field is a computed
base field added to entity types that have a Group relation, and it sits in the **hidden**
region by default. You enable it per bundle by placing its widget on the form display.

## Where it can appear

An entity type gets the field only if a Group relation plugin targets it:
- `user` always has it (group memberships).
- `node` (and others) get it once a group-node / group-content relation plugin is installed
  for that entity type.

## Show it on the edit form (Manage form display)

Add a component for `entitygroupfield` to
`core.entity_form_display.<entity>.<bundle>.<mode>`, choosing a widget:

- **`entitygroupfield_select_widget`** — "Group select" (default), a dropdown.
- **`entitygroupfield_autocomplete_widget`** — "Group autocomplete".

Widget settings (`defaultSettings`): `label`, `help_text`, `multiple` (default TRUE),
`required` (default FALSE).

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('user.user.default');
$fd->setComponent('entitygroupfield', [
  'type' => 'entitygroupfield_autocomplete_widget',
  'region' => 'content',
  'weight' => 5,
  'settings' => ['label' => 'Groups', 'help_text' => 'Pick this user\'s groups', 'multiple' => TRUE, 'required' => FALSE],
])->save();
// To hide again: $fd->removeComponent('entitygroupfield')->save();  // returns to the hidden region
```

## Show it on the rendered entity (Manage display)

Add `entitygroupfield` to `core.entity_view_display.<entity>.<bundle>.<mode>` with a formatter:

| Formatter | Output | Settings |
|---|---|---|
| `parent_group_label_formatter` (default) | The parent group's label | `link` (bool) — link to the group |
| `parent_group_entity_formatter` | The rendered group entity | `view_mode` |
| `parent_group_id_formatter` | The group entity ID | — |

Schema for these settings is in `config/schema/entitygroupfield.schema.yml`.
