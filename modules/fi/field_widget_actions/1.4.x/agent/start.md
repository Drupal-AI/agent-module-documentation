<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Widget Actions (field_widget_actions) — agent index

A developer framework that attaches AJAX action buttons directly to **field widgets**
on entity edit forms (node/media/user/etc.), without a custom form alter per button.
An action is a `FieldWidgetAction` plugin; site builders enable and configure actions
**per field widget** under *Manage form display* (the widget's third-party settings). An
action either fills the field directly, opens a suggestions modal, or opens a modal form
whose generated content can be iteratively refined before insertion. The base framework
does no content generation itself — that is supplied by action plugins (e.g. the AI or
ECA modules, or your own).

- **No module dependencies.** Core `^10.3 || ^11.1 || ^12`. No admin settings page
  (`configure` is null); everything is configured on individual field widgets.
- Provides the **`FieldWidgetAction`** plugin type; provides config schema; no permissions,
  no drush.

- **Turn an action on for a field / set button label, automatic, multiple, refinement** → [configure/actions.md](configure/actions.md)
- **Write a custom action plugin (direct-fill, suggestions, or modal/refinable)** → [plugins/field-widget-action.md](plugins/field-widget-action.md)
- **Use the plugin manager, AJAX fill commands, alter hook, suggestions theme** → [api/services.md](api/services.md)
- **Understand the form hooks that inject the buttons / the recipe config action** → [hooks/field-widget-hooks.md](hooks/field-widget-hooks.md)

## Key facts

- Plugin type: **`FieldWidgetAction`**. Attribute `Drupal\field_widget_actions\Attribute\FieldWidgetAction`;
  plugin dir `Plugin/FieldWidgetAction`; interface `FieldWidgetActionInterface`; base classes
  `FieldWidgetActionBase`, `FieldWidgetFormActionBase`, `FieldWidgetRefinableFormActionBase`.
- Plugin manager service: **`plugin.manager.field_widget_actions`** (`FieldWidgetActionManager`,
  alias `FieldWidgetActionManagerInterface`). Alter hook `field_widget_action_info`. Cache bin key `field_widget_action_plugins`.
- Config lives in the form-display component third-party settings under provider key
  **`field_widget_actions`** (keyed by UUID). Per-action keys: `plugin_id`, `enabled`,
  `automatic`, `button_label`, `multiple`, `weight`, `enable_refinement`, `refinement_modal_title`.
- Config schema types: `field_widget_action_plugin_base`, `field_widget_action.plugin.*`,
  `field.widget.third_party.field_widget_actions`.
- Modal route: **`field_widget_actions.modal_form_action`** → `/admin/field-widget-action/modal/{plugin_id}/{tempstore_id}`
  (`FieldWidgetActionFormController::submitModal`). Modal state uses the `field_widget_actions_form_collection`
  private tempstore.
- Recipe/config-action: **`setComponentThirdPartySetting`** (`SetupFieldWidgetAction`), targets `entity_form_display`.
- Theme hook `field_widget_actions_suggestions`. AJAX commands `fieldWidgetActionsFillEditor` /
  `fieldWidgetActionsFillSimpleField` / `fieldWidgetActionsFillSelect`. Libraries `admin_ui`,
  `widget_button`, `suggestions`, `commands`, `gin_compatibility_fix`.
- post_update `field_widget_actions_post_update_ensure_valid_uuids` re-keys legacy list settings to UUIDs.
