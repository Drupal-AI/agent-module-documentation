# Services, AJAX commands, theme & libraries

## Services

| Service id | Class / purpose |
|------------|-----------------|
| `plugin.manager.field_widget_actions` | `FieldWidgetActionManager` — the plugin manager. Also aliased to `Drupal\field_widget_actions\FieldWidgetActionManagerInterface`. |
| `Drupal\field_widget_actions\Hook\FieldWidgetAction` | Autowired class holding the module's hook implementations (form alters, theme, config-action alter, presave, settings-summary alter). |
| `logger.channel.field_widget_actions` | Logger channel `field_widget_actions`. |

### Plugin manager methods

```php
$manager = \Drupal::service('plugin.manager.field_widget_actions');

// Definitions valid for a given widget id + field type (empty type/widget lists = all).
$defs = $manager->getAllowedFieldWidgetActions($widget_plugin_id, $field_type);

// Only actions whose instance is a FieldWidgetFormActionInterface (modal-form actions).
$formDefs = $manager->getFieldWidgetActionFormDefinitions();

// Instantiate an action with a stored config array.
$action = $manager->createInstance($plugin_id, $configuration);
```

Alter definitions with `hook_field_widget_action_info_alter(&$definitions)`.

## AJAX fill commands

Modal/form and direct-fill actions insert values into the target widget with these render-array
commands (PHP class → JS `Drupal.AjaxCommands` method):

| PHP command | JS command | Behaviour |
|-------------|-----------|-----------|
| `Ajax\FillEditorCommand` | `fieldWidgetActionsFillEditor` | Sets a CKEditor 4/5 instance's data (`setData`); falls back to `element.value` + change/input events when no editor is attached. |
| `Ajax\FillSimpleFieldCommand` | `fieldWidgetActionsFillSimpleField` | Sets a plain input/textarea `value` and dispatches change/input. |
| `Ajax\FillSelectCommand` | `fieldWidgetActionsFillSelect` | Sets a `<select>`/option-widget value. |
| `Ajax\FillCheckboxesOrRadiosCommand` | `fieldWidgetActionsFillCheckboxesOrRadios` | Checks/selects a set of entity IDs on a checkboxes (cardinality > 1) or radios (cardinality 1) widget. Takes `(string $selector, array $values)`; the payload is `{command, selector, values}` (values are `array_filter`ed). The JS matches `name^="base["` (falling back to the form without `[widget]`). |

Each simple fill command takes `(string $selector, string $data)` and renders `{command, selector, data}`.
`FieldWidgetRefinableFormActionBase::submitModalFormFillFields()` chooses FillEditor for
formatted-text targets and FillSimpleField otherwise.

## Theme

`hook_theme` registers **`field_widget_actions_suggestions`** with a single `suggestions`
variable. Template `field-widget-actions-suggestions.html.twig` renders each suggestion as a
`.fwa-use-suggestion` button (auto-escaped). The `suggestions` library's behaviour
(`Drupal.behaviors.suggestionsFieldWidgetActions`) fills the target element (from
`drupalSettings.fwa_suggestion_target.target`) when a suggestion is clicked and closes the dialog.

## Libraries (`field_widget_actions.libraries.yml`)

| Library | Attached where | Contains |
|---------|----------------|----------|
| `admin_ui` | *Manage form display* third-party settings UI | `admin.js` (drag-sort of actions) + `admin.css`; deps core/once, core/sortable, core/drupal. |
| `widget_button` | every action button | `automatic.js` — auto-clicks any button with `data-fwa-automatic="true"` on attach; `widget-button.css`. |
| `suggestions` | suggestions modal | `suggestions.js` + `suggestions.css`; deps core/drupal.dialog.ajax, core/drupalSettings. |
| `commands` | modal-form actions | the four `commands.fill_*.js` AJAX command handlers (editor, simple field, select, checkboxes/radios); deps core/drupal.dialog.ajax, core/drupalSettings. |
| `gin_compatibility_fix` | modal-form actions | `gin-modal-compatibility-fix.css` for the Gin admin theme. |

## Alter hooks this module provides

- `hook_field_widget_action_info_alter(array &$definitions)` — alter the discovered
  `FieldWidgetAction` plugin definitions (invoked by the manager).
- `hook_field_widget_actions_childless_widgets_alter(array &$childless_widgets)` — append a
  widget plugin id to the list of "childless" widgets (default: `tagify_select_widget`,
  `select2`, `options_select`). The form alters wrap these in a `field-widget-actions-container`
  so the buttons render beside JS-enhanced selects. Documented in `field_widget_actions.api.php`.

## Button markup

Each action button carries `data-wrapper-id`, `data-widget-id`, `data-widget-field`,
`data-widget-delta`, and — when the *Automatic* option is set — `data-fwa-automatic="true"`,
plus `#field_widget_action_field_name` / `#field_widget_action_field_delta` /
`#field_widget_action_settings` render properties used to locate the target on submit.
