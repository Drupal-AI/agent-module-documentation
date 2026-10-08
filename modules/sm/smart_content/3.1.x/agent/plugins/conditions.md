# Condition plugins (Condition, ConditionType, ConditionGroup)

Smart Content has **three** related plugin types on the condition side. A **Condition** is one
testable case; a **ConditionType** is the reusable form-widget + client evaluator (textfield,
number, select, …) a condition uses; a **ConditionGroup** is just a label/bucket that groups
conditions in the "add condition" select.

## The three managers

| Service id | Class | Plugin dir | Interface | Annotation |
|---|---|---|---|---|
| `plugin.manager.smart_content.condition` | `Condition\ConditionManager` | `Plugin/smart_content/Condition` | `Condition\ConditionInterface` | `@SmartCondition` |
| `plugin.manager.smart_content.condition_type` | `Condition\Type\ConditionTypeManager` | `Plugin/smart_content/Condition/Type` | `Condition\Type\ConditionTypeInterface` | `@SmartConditionType` |
| `plugin.manager.smart_content.condition_group` | `Condition\Group\ConditionGroupManager` | `Plugin/smart_content/Condition/Group` | `Condition\Group\ConditionGroupInterface` | `@SmartConditionGroup` |

`ConditionManager` implements `FallbackPluginManagerInterface` → unknown condition ids resolve to
the `broken` plugin. Alter hooks: `hook_smart_content_info` (conditions),
`hook_smart_content_smart_condition_type_info`, `hook_smart_content_condition_group_info`.
`ConditionManager::getFormOptions()` builds the grouped select (skips definitions with
`group === 'hidden'`).

## `@SmartCondition` annotation

```
@SmartCondition(
  id = "browser",
  label = @Translation("Browser"),
  group = "browser",         // a condition_group id (or "hidden")
  weight = 0,
  unique = true,             // optional; see "Field" below
  deriver = "…"              // optional
)
```

Bundled conditions (`src/Plugin/smart_content/Condition/`): `is_true` (group `common`), `group`
(group `common`, `unique = true` — a composite AND/OR container of other conditions), `broken`
(fallback). The **smart_content_browser** submodule adds condition `browser` (derived per browser
signal via `BrowserDerivative`).

### ConditionBase — what a condition carries

`Condition\ConditionBase` (abstract, `ContainerFactoryPluginInterface`, injects the condition-group
manager) implements: `isNegated()/setNegated()`, `getWeight()/setWeight()`,
`getTypeId()` (returns `'plugin:' . pluginId`), and `getAttachedSettings()` which emits the
client-side **field** descriptor:

```php
['field' => [
  'pluginId' => $this->getPluginId(),
  'type'     => $this->getTypeId(),   // 'plugin:<id>' unless a ConditionType overrides it
  'negate'   => $this->isNegated(),
  'unique'   => $definition['unique'],
]]
```

`ConditionConfigurableBase` adds `PluginFormInterface`; `ConditionTypeConfigurableBase` is the base
for conditions that delegate their widget to a **ConditionType** (this is what `browser` extends).
Config schema for a stored condition: `id`, `weight`, `negate` (bool), `type`
(`config/schema/smart_content.condition.schema.yml`).

## ConditionType plugins (the widgets + client evaluators)

A ConditionType is a form widget whose values are auto-stored to configuration
(`ConditionTypeBase::submitConfigurationForm()` writes `$form_state->getValues()` straight into
config). Bundled types (`Plugin/smart_content/Condition/Type/`): `textfield`, `number`, `select`,
`boolean`, `key_value`, `array_textfield`. Each defines `getOperators()`, `defaultFieldConfiguration()`,
`getHtmlSummary()`, and a `getLibraries()` of `smart_content/condition_type.standard`. Example —
`textfield` operators: `equals`, `contains`, `starts_with`, `empty`; `number` operators: `equals`,
`gt`, `lt`, `gte`, `lte`. Per-type config schemas live in `smart_content.condition.schema.yml`
under keys like `smart_content.condition.plugin.type:textfield`.

## The client-side "Field" concept

"Field" is a **JavaScript** plugin, not a Drupal field. Each condition's `getAttachedSettings()`
`field.pluginId` names a JS collector registered at `Drupal.smartContent.plugin.Field[pluginId]`
that returns (or resolves a Promise for) the browser value to test — e.g. `condition.common.js`
registers `Field['group']` and `Field['is_true']`; the browser submodule's `condition.browser.js`
registers browser fields. The matching **ConditionType** evaluator lives at
`Drupal.smartContent.plugin.ConditionType[type]` and returns true/false given the field value and the
stored settings. `field.unique` controls caching: non-unique fields are looked up once and shared
across conditions; unique fields are evaluated per condition (see `conditionFieldManager` in
`js/smart_content.js`). See [decisions.md](decisions.md) for the full runtime.

## Add a condition plugin

1. Create `src/Plugin/smart_content/Condition/MyCondition.php` with a `@SmartCondition` annotation
   (pick an existing `group` or register one via `@SmartConditionGroup`). Extend
   `ConditionConfigurableBase` for a self-contained widget, or `ConditionTypeConfigurableBase` to
   reuse a ConditionType widget.
2. Return the JS library that registers your `Drupal.smartContent.plugin.Field[<pluginId>]` collector
   from `getLibraries()`. If you reuse a ConditionType, also return `smart_content/condition_type.standard`.
3. For many derived signals (like browser), add a `deriver`.
4. Client-side: register the field collector (and, if custom, a `ConditionType` evaluator) — return
   a boolean or a Promise. Conditions are evaluated **in the browser** and are visible/modifiable to
   the visitor; never use them for server-side access control.
