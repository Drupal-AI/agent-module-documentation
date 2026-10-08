<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Condition plugin: `node_boolean`

`src/Plugin/Condition/NodeBoolean.php` — the module's only code. Class `NodeBoolean` extends
`Drupal\Core\Condition\ConditionPluginBase` and implements `ContainerFactoryPluginInterface`.

## Install & use

1. `drush en node_boolean` (or enable in the UI). No config to import, no permission to grant.
2. Ensure the target node bundle has at least one **Boolean** field (a checkbox), e.g.
   `field_featured` on Article.
3. Edit a block at **Block Layout** (`/admin/structure/block`) → *Configure* → **Visibility** →
   the **"Node boolean"** tab. Tick the boolean field(s) to evaluate. Optionally tick
   *Evaluate all fields rather than any*, and/or the standard core *Negate the condition*.
4. The block now renders on a node page only when the selected field(s) evaluate as configured for
   the node in context.

The plugin is also usable by any other consumer of core condition plugins that supplies a `node`
context; blocks are the common case.

## Annotation & context

```
@Condition(
  id = "node_boolean",
  label = @Translation("Node boolean"),
  context_definitions = {
    "node" = @ContextDefinition("entity:node", required = TRUE, label = @Translation("node"))
  }
)
```

`create()` injects `entity_field.manager` and stores it as `$this->entityFieldManager`.

## Config keys (`defaultConfiguration()`)

Stored inside the host block/condition config, not a standalone config object (no schema file ships).

- `boolean` — array of selected boolean field machine names. Default `[]`.
- `all` — bool. Default `FALSE`. When TRUE, evaluate **all** selected fields (AND); when FALSE,
  **any** (OR).
- Plus core condition defaults (including `negate`) via `+ parent::defaultConfiguration()`.

## Form (`buildConfigurationForm`)

- `boolean`: `#type => checkboxes`, titled *"Fields that should be true (any)"*. Options come from
  `getBooleanNodeFieldMap()` — every node boolean field, keyed by field machine name, labelled by
  `ucfirst(str_replace('_', ' ', $field_id))`.
- `all`: `#type => checkbox`, *"Evaluate all fields rather than any"*.
- Returns `parent::buildConfigurationForm()` (which adds the core *Negate* checkbox).

`submitConfigurationForm()` saves `array_filter($form_state->getValue('boolean'))` and `all`; if the
resulting `boolean` is empty it resets `$this->configuration = []` (clears the condition).

## Evaluation logic

`getBooleanNodeFieldMap()` returns `entity_field.manager->getFieldMapByFieldType('boolean')['node']`
— the site-wide map of node boolean fields with their bundles.

- `evaluate()`: if `boolean` is empty → returns TRUE (no-op condition). Else delegates to
  `evaluateAll()` when `all` is truthy, otherwise `evaluateAny()`.
- `evaluateAny()`: for each selected field, if the field exists on the context node's bundle
  (`$fields[$field]['bundles'][$node->getType()]`) and has a value and that value is truthy →
  return TRUE. Returns FALSE if none match.
- `evaluateAll()`: returns FALSE as soon as a selected field is missing from the node's bundle, is
  empty, or is unchecked; returns TRUE only when every selected field is present-and-checked.
- Core wraps the result with `negate` when *Negate the condition* is on.

## Notes / caveats

- `summary()` calls `explode(', ', $booleans)` where `$booleans` is the config **array** — passing
  an array where a string is expected. The summary label is cosmetic (shown in the visibility
  listing) and does not affect `evaluate()`; treat it as a display quirk, not a functional path.
- In **any** mode a field absent from the node's bundle is skipped; in **all** mode an absent field
  makes the condition FALSE for that node — so mixing bundles matters when using "all".
- This is display logic only: a block hidden by the condition is not rendered, **not**
  access-protected. Do not use it as a security boundary.
