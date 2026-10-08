<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Condition plugins

Source: `src/DisplayModeSwitcherConditionManager.php`, `src/DisplayModeSwitcherConditionPluginBase.php`, `src/Attribute/DisplayModeSwitcherCondition.php`, `src/Plugin/Collection/DisplayModeSwitcherConditionPluginCollection.php`.

## What's available out of the box
No condition plugins ship in this project. The manager `DisplayModeSwitcherConditionManager` (service `plugin.manager.display_mode_switcher.condition`) is a two-source manager:
- `getDefinitions()` = own plugins (`Plugin/DisplayModeSwitcherCondition/`) **+** `plugin.manager.condition` (core) definitions. Own plugins win on id collision. `entity_bundle` (and its derivatives like `entity_bundle:node`) is hidden because the rule already has a Bundle field.
- `createInstance($id)` routes to the parent factory for own plugins (and calls `setExecutableManager($this)` so `ConditionPluginBase::execute()` delegates back here) or to the core manager for everything else.
- `execute($condition)` = `$condition->evaluate()` XOR-adjusted by `isNegated()`.

So all standard/contrib conditions are usable immediately: `user_role`, `node_type`, `language`, `request_path`, `current_theme`, etc.

## Adding a custom condition (any module)
1. Class in `src/Plugin/DisplayModeSwitcherCondition/MyCondition.php`, extending `DisplayModeSwitcherConditionPluginBase` (or core `ConditionPluginBase`):
```php
#[DisplayModeSwitcherCondition(
  id: 'my_condition',
  label: new TranslatableMarkup('My condition'),
)]
class MyCondition extends DisplayModeSwitcherConditionPluginBase {
  public function evaluate(): bool { /* return TRUE to pass */ }
  public function summary(): string { return 'My condition'; }
}
```
The attribute `#[DisplayModeSwitcherCondition]` takes `id`, `label`, `context_definitions`, `deriver`.

2. **Accessing the rendered entity:** the resolver calls `setEntity($entity)` on every `DisplayModeSwitcherConditionPluginBase` before evaluation, so read `$this->entity` directly in `evaluate()` — no `context_definitions` or Context API wiring. Override `getCacheTags()` to add the entity's tags if your logic reads its fields.

3. **Config schema is mandatory.** Add a `condition.plugin.{id}` type in your module's `config/schema/*.schema.yml`, inheriting `condition.plugin` but **overriding** `id.constraints.PluginExists.manager` to `plugin.manager.display_mode_switcher.condition` (core's base points at `plugin.manager.condition`, which doesn't know your plugin). Drupal deep-merges child schema so the scalar `manager` overwrites the parent:
```yaml
condition.plugin.my_condition:
  type: condition.plugin
  label: 'My condition'
  mapping:
    id:
      type: string
      constraints:
        PluginExists:
          manager: plugin.manager.display_mode_switcher.condition
          interface: 'Drupal\Core\Condition\ConditionInterface'
```
Without this override, `$entity->getTypedData()->validate()` throws `PluginNotFoundException` when a rule uses the plugin.

4. `drush cr`. The plugin appears automatically in the rule form's Conditions tabs.

## Why the custom plugin collection
`DisplayModeSwitcherConditionPluginCollection` overrides `getConfiguration()` to delegate to `DefaultLazyPluginCollection::getConfiguration()` (grandparent), bypassing `ConditionPluginCollection`'s block that strips any condition whose config equals `['id' => $id] + defaultConfiguration()`. Without this, an enabled condition carrying only default config (e.g. just `negate: false`) would be silently dropped on save and could never persist. `DisplayModeSwitcherRule::getConditions()` instantiates this collection.

## Alter hook
`hook_display_mode_switcher_condition_info_alter()` — applies to module-specific plugins only (mirrors per-manager core behaviour). Discovery cache key: `display_mode_switcher_condition_plugins`.
