# Configure actions on a field widget

There is **no module settings page**. Actions are enabled and configured **per field
widget** on *Manage form display*. Configuration is stored in that display component's
third-party settings under the provider key `field_widget_actions`.

## Via the UI

1. Structure → the entity type → *Manage form display*.
2. Click the gear/cog next to the field you want a button on.
3. Open the **Field Widget Actions** details element. Pick an action from *Add New Action*
   and click **Add action** (AJAX). The dropdown only lists actions whose plugin
   `field_types`/`widget_types` allow this field+widget, and whose `isAvailable()` returns TRUE.
4. Configure the new action's settings (below), reorder actions by drag-and-drop, **Update**, then **Save**.

Only actions available for the field/widget appear. An action that becomes unavailable
later (e.g. an AI Automator removed from the field) is hidden at render time and a warning
is shown; the stored config is kept, not dropped.

## Per-action settings

Each configured action is a map keyed by a generated **UUID** inside
`third_party_settings.field_widget_actions`. Keys (config schema `field_widget_action_plugin_base`):

| Key | Type | Meaning |
|-----|------|---------|
| `plugin_id` | string | The `FieldWidgetAction` plugin id (validated by `PluginExists`). |
| `enabled` | bool | Render this action's button on the form. Default FALSE. |
| `automatic` | bool | Auto-trigger the button on form load (JS dispatches a `mousedown`) instead of a manual click. Only shown when `enabled`. |
| `button_label` | label | Button text; falls back to the plugin label. |
| `multiple` | bool | TRUE → one button per field item (delta); FALSE → one button for the whole field. Only offered on multi-value fields. |
| `weight` | int | Ordering (drag-and-drop writes this hidden value). |
| `enable_refinement` | bool | Refinable actions only: show generated content in a modal with a *Refine* loop before insert. |
| `refinement_modal_title` | label (nullable) | Refinable actions only: title of the refinement dialog; blank = action label. |

`enable_refinement`/`refinement_modal_title` exist only for actions extending
`FieldWidgetRefinableFormActionBase` (see [plugins/field-widget-action.md](../plugins/field-widget-action.md)).

## Set it in code / PHP

```php
$display = \Drupal::service('entity_display.repository')
  ->getFormDisplay('node', 'article');           // EntityFormDisplayInterface
$component = $display->getComponent('body');
$component['third_party_settings']['field_widget_actions'][\Drupal::service('uuid')->generate()] = [
  'plugin_id'   => 'my_action',
  'enabled'     => TRUE,
  'automatic'   => FALSE,
  'button_label'=> 'Suggest',
  'multiple'    => FALSE,
  'weight'      => 0,
];
$display->setComponent('body', $component)->save();
```

`hook_entity_form_display_presave` (see hooks doc) normalises any non-UUID keys to UUIDs on
save, and post_update `field_widget_actions_post_update_ensure_valid_uuids` fixes legacy data.

## Set it in a recipe / config action

The module registers a config action **`setComponentThirdPartySetting`** (plugin class
`SetupFieldWidgetAction`, applies to `entity_form_display` entities). It merges `settings`
into the component's `third_party_settings.field_widget_actions` (provider is forced to
`field_widget_actions`). Placeholders `%bundle`, `%entity_type`, `%view_mode` are substituted.

```yaml
config:
  actions:
    core.entity_form_display.node.article.default:
      setComponentThirdPartySetting:
        component: body
        settings:
          <uuid-or-key>:
            plugin_id: my_action
            enabled: true
            button_label: Suggest
```

A list of parameter maps is also accepted to set several components at once. This action is
**only** for this module's third-party settings; for other providers use core's own config action.
