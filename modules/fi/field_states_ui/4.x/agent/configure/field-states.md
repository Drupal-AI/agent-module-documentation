<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a field state

No central admin page — configure per field widget on **Manage form display**.

## Where it is stored

Config entity: `core.entity_form_display.<entity_type>.<bundle>.<form_mode>`
Path within a widget component:

```yaml
content:
  <field_name>:
    type: <widget>
    third_party_settings:
      field_states_ui:
        field_states:
          - id: visible            # a FieldState plugin id
            data:
              target: field_trigger   # the field whose value is watched
              comparison: value       # value | empty | filled | checked | unchecked | ...
              value: 'Canada'         # value to compare (used when comparison = value)
            uuid: 4f1c…               # unique per state
```

`field_states` is a **list** — a field can carry several states.

## State plugin ids (built in)

`visible`, `invisible`, `required`, `optional`, `enabled`, `disabled`, `checked`, `unchecked`,
`expanded`, `collapsed`. (These map to Drupal core's States API states.)

## The `data` keys

- **`target`** — machine name of the field (on the same form) whose state/value is watched.
- **`comparison`** — how to compare: `value` (equals `data.value`), or a state condition such as
  `empty`, `filled`, `checked`, `unchecked` (per the States API). When `comparison` is `value`,
  `value` is used; otherwise the comparison itself is the trigger.
- **`value`** — the value to compare against (defaults to `TRUE`).

Result: the manager builds a `#states` array like
`['visible' => ['select[name=".../field_trigger..."]' => ['value' => 'Canada']]]` on the widget.

## Via the UI

1. Go to the bundle's *Manage form display* (e.g. `/admin/structure/types/manage/article/form-display`).
2. Click the gear/cog on the field row.
3. In **Manage Field States**, choose a state, click **Add**, set *Target field*, *Comparison*,
   *Value*, then **Update** and **Save**. The widget summary lists the configured states.

## Via drush php:eval (scriptable)

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$c = $fd->getComponent('field_detail');            // the field to control
$c['third_party_settings']['field_states_ui']['field_states'] = [
  [
    'id' => 'visible',
    'data' => ['target' => 'field_trigger', 'comparison' => 'value', 'value' => 'Canada'],
    'uuid' => \Drupal::service('uuid')->generate(),
  ],
];
$fd->setComponent('field_detail', $c)->save();
```

## Read it back

```bash
drush cget core.entity_form_display.node.article.default content.field_detail
# look for third_party_settings.field_states_ui.field_states
```

## Config schema

`config/schema/field_states_ui.schema.yml` defines
`field.widget.third_party.field_states_ui` (the `field_states` sequence) and the per-state
`field_states_ui.state.*` mapping (`target`, `comparison`, `value`).
