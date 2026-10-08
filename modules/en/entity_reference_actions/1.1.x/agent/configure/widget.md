<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable & configure Entity Reference Actions on a field widget

There is no global settings page. The feature is turned on **per widget** via the widget's third-party
settings on the entity's **Manage form display** tab
(`admin/structure/<entity>/<bundle>/form-display`), on any entity-reference field. Click the widget's
cog (settings) to reveal the *Enable Entity Reference Actions* checkbox and its options.

## Third-party settings (namespace `entity_reference_actions`)

Stored in the `entity_form_display` component under
`content.<field>.third_party_settings.entity_reference_actions`. Schema
`field.widget.third_party.entity_reference_actions`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `enabled` | bool | `false` | Master switch — attaches the actions dropbutton to this widget. |
| `options.action_title` | label | `Action` | Text/label shown above the actions control. |
| `options.include_exclude` | string | `exclude` | `exclude` = offer all matching actions **except** the selected ones; `include` = offer **only** the selected ones. |
| `options.selected_actions` | sequence of string | `[]` | The `action` entity IDs referenced by the include/exclude rule (checkboxes in the form). |

Which actions can appear at all is fixed by the field: only `action` config entities whose `type`
equals the field's `target_type` (e.g. `node`, `media`, `taxonomy_term`) are listed. The
include/exclude list then narrows that set.

## Enable it with Drush (example)

```php
// drush php:eval — turn on ERA for node.article field_related, offering only the delete action.
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$component = $fd->getComponent('field_related');
$component['third_party_settings']['entity_reference_actions'] = [
  'enabled' => TRUE,
  'options' => [
    'action_title' => 'Bulk actions',
    'include_exclude' => 'include',
    'selected_actions' => ['node_delete_action'],
  ],
];
$fd->setComponent('field_related', $component)->save();
```

The settings summary on *Manage form display* shows `Entity Reference Actions: On/Off`
(`hook_field_widget_settings_summary_alter`).

## Notes

- The button is rendered as a `simple_actions` element; with more than one action it becomes a
  dropbutton (`#dropbutton => 'bulk_edit'`).
- Media Library widgets place the button beside the "Add media" control (a `#pre_render` moves it into
  `#field_suffix`).
- Visibility follows widget states (`getVisibleStateConditions`) so it appears only when appropriate for
  the widget's value(s).
