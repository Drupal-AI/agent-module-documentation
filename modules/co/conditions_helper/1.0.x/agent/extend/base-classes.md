# Conditions Helper — base form classes

Two abstract classes give near-turnkey condition UIs. Subclass them in your module.

## `ConditionSelectorSettingsFormBase` (extends `ConfigFormBase`)

A settings form where admins pick which condition plugins are enabled for a feature. It embeds the
selector checkboxes from `conditions_helper.condition_selector_form_builder` and saves the ticked
plugin IDs under the standardized config key **`enabled_conditions`** (constant
`ENABLED_CONDITIONS_KEY`, exposed via `static::getEnabledConditionsKey()`). The scope passed to the
alter hook is the form's `getFormId()`.

Subclass responsibilities: implement `getFormId()` and `getEditableConfigNames()`; the base handles
`buildForm()` (loads current selection, renders checkboxes as `$form['enabled_conditions']` with
`#tree = TRUE`) and `submitForm()` (`array_filter` the values, save to the first editable config name).

```php
class MyFeatureConditionsSettingsForm extends ConditionSelectorSettingsFormBase {
  public function getFormId(): string { return 'my_feature_conditions_settings'; }
  protected function getEditableConfigNames(): array { return ['my_module.settings']; }
}
```

Saved shape: `my_module.settings:enabled_conditions: [ 'node_type', 'user_role', ... ]`. Define a
matching schema in your module (sequence of strings).

## `ConditionsFormBase` (extends `FormBase`)

A thin base that dependency-injects `conditions_helper.form_builder` (as `$this->conditionsFormBuilder`)
for forms that embed the detailed per-condition configuration UI. You implement `getFormId()`,
`buildForm()` (call `buildConditionsForm(...)`), and `submitForm()` (call `submitConditionsForm(...)`),
then persist the collected configuration to your own config/entity. Because it extends `FormBase` (not
`ConfigFormBase`), you choose where to store the result.

## Config schema for stored conditions

The module does not store your condition data for you. The README recommends storing conditions as a
mapping keyed by plugin ID that resolves to each plugin's own schema:

```yaml
my_module.item.*:
  type: sequence
  sequence:
    type: condition.plugin.[%key]
```

Well-behaved core/contrib condition plugins provide `condition.plugin.<id>` schema types covering
their settings plus the common `negate` and `context_mapping` keys.
