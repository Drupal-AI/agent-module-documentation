# Configure required strategies

## Site default strategy

Route `required_api.default_plugin` → `/admin/config/user-interface/required` (perm
`administer required settings`). Form `RequiredDefaultPluginForm` sets config
`required_api.plugins:default_plugin` (install value `default`). This id is used for any field
that hasn't chosen its own strategy (`RequiredManager::getDefaultPluginId()`).

## Per-field strategy

`required_api_form_field_config_edit_form_alter()` rewrites the **field settings** form
(`field_config_edit_form`, e.g. *Manage fields → edit*):

- Hides the core `required` checkbox (`$form['required']['#access'] = FALSE`).
- If more than one strategy exists, adds radios **"Choose a required strategy"** (`#parents`
  `third_party_settings/required_api/required_plugin`), AJAX-refreshing the options area.
- Renders the selected plugin's `formElement()` under `required_plugin_options`.
- A missing/unknown plugin id surfaces as the `broken` strategy and a validation error forces
  choosing another.

Stored on the `field_config` entity third-party settings:

```yaml
third_party_settings:
  required_api:
    required_plugin: default            # or a custom strategy id
    required_plugin_options: true       # shape defined by the plugin (schema: required_api.plugin_options.<id>)
```

`hook_field_config_presave`: for the `default` strategy the saved `required_plugin_options`
(bool) is written back to `$entity->setRequired()`; for any other non-empty strategy the field
is forced `setRequired(TRUE)` (so the core marker shows) and the strategy relaxes it at runtime.

## Runtime enforcement

- `hook_form_alter`: for each `FieldConfig` on the edited entity that has a `required_plugin`,
  adds `required_api_form_element_after_build` to the widget. That `#after_build` calls
  `plugin->isRequired($fieldDefinition, $entity)` and sets the element's `#required`
  (`$element['#required']`, `[0]['#required']`, `[0]['value']['#required']`).
- `required_api.form_error_handler` decorates core `form_error_handler`: on a content entity
  form it rebuilds the entity from submitted values, then removes `@name field is required.` /
  `The %field date is required.` errors for every non-base field whose strategy returns
  `isRequired() === false` (walking entity-reference/`subform` paths via `parseFieldPath()` /
  `isFieldActuallyRequired()`). Remaining errors are re-added and delegated to the inner handler.

## `RequiredManager` service (`plugin.manager.required_api.required`)

| Method | Purpose |
|---|---|
| `getInstance(['field_definition'=>$fd, 'plugin_id'=>?])` | plugin instance for a field (plugin id defaults to the field's configured/default strategy). |
| `getPluginId(FieldDefinitionInterface $fd)` | the field's `required_plugin` third-party setting, else the site default. |
| `getDefaultPluginId()` | config `required_api.plugins:default_plugin`. |
| `getDefinitionsAsOptions()` | strategy id → label map (excludes `broken`), for select elements. |
| `getFallbackPluginId()` | returns `broken` (implements `FallbackPluginManagerInterface`). |

`getInstance` from custom code:

```php
$plugin = \Drupal::service('plugin.manager.required_api.required')
  ->getInstance(['field_definition' => $field_definition]);
$is_required = $plugin->isRequired($field_definition, $entity);
```
