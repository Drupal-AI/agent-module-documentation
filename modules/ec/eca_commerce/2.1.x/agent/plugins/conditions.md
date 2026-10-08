# ECA Commerce conditions

Source: `src/Plugin/ECA/Condition/Commerce.php` + `CommerceDeriver.php`.
One ECA condition plugin `#[EcaCondition(id: 'eca_commerce_commerce', deriver: CommerceDeriver)]`.
The deriver iterates `plugin.manager.commerce_condition->getDefinitions()` and exposes **every**
Commerce condition plugin as an ECA condition with id `eca_commerce_commerce:<commerce_condition_id>`
and label `Commerce: <display_label>`. So whatever conditions Commerce (core + submodules) provides —
order total price, order item quantity, product category/type, store, currency, etc. — become
selectable ECA conditions.

## How it evaluates

- Each derived condition declares a single required context `entity` (`ContextDefinition('entity', …,
  required)`). Bind the entity to check (order, order item, product…) to that context in the model.
- `evaluate()` instantiates the wrapped Commerce condition via `original_id`, copies the ECA-configured
  values into it, then calls the Commerce plugin's own `evaluate($entity)`. Array-typed config values
  are accepted as comma-separated strings and split with `array_map('trim', explode(','…))`.
- Any `ContextException`/`PluginException` (e.g. wrong/missing entity) makes it return `FALSE`.
- The result passes through ECA's standard `negationCheck()`, so the "Negate the Condition" boolean
  (schema `eca.condition.plugin.eca_commerce_commerce:*`) inverts it.

## BPMN compatibility rewrites (important gotcha)

`buildConfigurationForm()` builds the wrapped plugin's form, then `filterFormFields()` mutates it
because the BPMN modeller can't render every element:

- `#type => checkboxes` fields are **removed entirely** (unsupported in BPMN — see eca issue 3340550).
  If a Commerce condition relies solely on a checkboxes widget, that option is not configurable here.
- `commerce_entity_select` and `entity_autocomplete` widgets are converted to a plain `textfield`
  with description "Provide a comma separated list of entity IDs." — so you enter raw entity IDs.

Config for the negate flag lives under schema type `eca.condition.plugin.eca_commerce_commerce:*`
(maps to `tamper.[%parent.original_id]` + a `negate` boolean).
