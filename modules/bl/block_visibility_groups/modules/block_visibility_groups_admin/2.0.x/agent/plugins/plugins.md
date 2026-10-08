# The `ConditionCreator` plugin type

This submodule (unlike the base module) **does** define its own plugin type. A ConditionCreator wraps
one kind of core **Condition** plugin with (a) form elements to gather its settings and (b) logic to
turn a form submission into that Condition's config array — used by `ConditionCreatorForm` to build a
group "from the current page".

## The manager

`src/ConditionCreatorManager.php` extends `DefaultPluginManager` (service
`plugin.manager.block_visibility_groups_admin.condition_creator`, `parent: default_plugin_manager`):

- Discovery directory: `Plugin/ConditionCreator` (so plugins live in
  `src/Plugin/ConditionCreator/` of any module).
- Interface: `Drupal\block_visibility_groups_admin\Plugin\ConditionCreatorInterface`.
- Annotation: `Drupal\block_visibility_groups_admin\Annotation\ConditionCreator`.
- Alter hook: `hook_block_visibility_condition_creator_alter()` (via `alterInfo`).
- Cache: `block_visibility_groups_admin:creator`.

`createInstance($plugin_id, $configuration)` is **overridden**: it *requires* a `route_name` in
`$configuration` (throws `\Exception` otherwise), resolves it via `router.route_provider`, replaces it
with a `RouteMatch` under the `route` key, and passes that to the plugin. So callers pass
`['route_name' => …, 'parameters' => …]`, and plugins receive a resolved `route`.

## The annotation

`@ConditionCreator` properties: `id`, `label`, `condition_plugin` (the id of the **core Condition**
plugin this creator produces config for).

## The interface & base class

`ConditionCreatorInterface` methods:

| Method | Purpose |
|---|---|
| `createConditionElements()` | Return the form render array for this condition. |
| `createConditionConfig($plugin_info)` | Build the core Condition config array from the submitted values. |
| `getNewConditionLabel()` | Label shown for the new condition (empty ⇒ creator is skipped). |
| `itemSelected($condition_info)` | Whether the user actually selected/filled this condition. |

`ConditionCreatorBase` (extends `PluginBase`, uses `StringTranslationTrait`) reads `$configuration['route']`
into `$this->route`, and provides defaults: `createConditionElements()` renders a checkbox fieldset;
`createConditionConfig()` sets `id` (from the annotation's `condition_plugin`) and `negate = 0`;
`itemSelected()` checks the `selected` checkbox.

## Bundled creators (`src/Plugin/ConditionCreator/`)

| id | label | condition_plugin | Notes |
|---|---|---|---|
| `route` | Route | `request_path` | Label shows the current path with route params replaced by `*`; stores `pages` = that pattern. |
| `roles` | Roles | `user_role` | Checkboxes of all roles; adds `context_mapping: user → @user.current_user_context:current_user`. |
| `node_type` | Content Types | `node_type` | Needs a `node` id in `parameters`; pre-checks the current node's bundle; adds `context_mapping: node → @node.node_route_context:node`. Implements `ContainerFactoryPluginInterface` to inject `node_type` storage. |

## Add your own

Create `src/Plugin/ConditionCreator/MyCreator.php` in any module:

```php
/**
 * @ConditionCreator(
 *   id = "my_thing",
 *   label = "My Thing",
 *   condition_plugin = "my_condition"
 * )
 */
class MyCreator extends ConditionCreatorBase {
  public function getNewConditionLabel() { return $this->t('My thing'); }
  public function createConditionElements() {
    $elements = parent::createConditionElements();
    $elements['condition_config'] = ['#type' => 'value', '#value' => ['foo' => 'bar']];
    return $elements;
  }
}
```

Return an empty array / falsy `getNewConditionLabel()` to have the creator skipped for a given
route/parameters (as `node_type` does when there is no node in scope).
