<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `@ViewsAddButton` plugin type

The module defines one annotation-based plugin type that produces the add-button URL and access
check for a given entity type.

- Plugin manager service: `plugin.manager.views_add_button` (`ViewsAddButtonManager`).
- Namespace: `Plugin\views_add_button`.
- Annotation: `@ViewsAddButton` (props: `id`, `label`, `category`; built-ins also set
  `target_entity`).
- Interface: `ViewsAddButtonInterface` (requires `description()`); plugins also implement static
  `generateUrl()` / `checkAccess()` / `generateLink()` used by the area/field handlers.

## Built-in plugins

| id | target_entity | URL |
|---|---|---|
| `views_add_button_node` | `node` | `Url::fromRoute('node.add', ['node_type' => $bundle])`; access via `node.add` route |
| `views_add_button_taxonomy` | `taxonomy_term` | taxonomy term add route |
| `views_add_button_user` | `user` | user add route |
| `views_add_button_eck_entity` | `` | ECK entities |
| `views_add_button_default` | `` | fallback `Url::fromUserInput('/{entity_type}/add/{bundle}')` (or `/{type}/add` when type == bundle) |

The area/field handler picks a plugin by matching the chosen entity type against each plugin's
`target_entity`; if none matches it uses **Default**. The `render_plugin` / `access_plugin` options
override this per handler.

## Service helpers

`views_add_button.service` (`ViewsAddButtonService`): `createPluginList()` (options list of
render/access plugins), `createEntityBundleList()` (the entity+bundle select options,
`"<type>+<bundle>"`), `getPluginDefinitions()`.

## Write a custom plugin

Add `mymodule/src/Plugin/views_add_button/MyEntityButton.php`, extend `PluginBase`, implement
`ViewsAddButtonInterface`, and provide static `generateUrl($entity_type, $bundle, array $options,
$context = '')` returning a `Url`, plus `checkAccess($entity_type, $bundle, $context = '')` for the
create-access check (and optionally `generateLink($text, Url $url, array $options)`):

```php
/**
 * @ViewsAddButton(
 *   id = "views_add_button_myentity",
 *   label = @Translation("My entity add button"),
 *   target_entity = "my_entity"
 * )
 */
class MyEntityButton extends PluginBase implements ViewsAddButtonInterface {
  public function description() { return $this->t('Add button for my_entity'); }
  public static function generateUrl($entity_type, $bundle, array $options, $context = '') {
    return Url::fromRoute('entity.my_entity.add_form', ['bundle' => $bundle], $options);
  }
  public static function checkAccess(string $entity_type, string $bundle, $context = '') {
    return \Drupal::service('access_manager')->checkNamedRoute('entity.my_entity.add_form', ['bundle' => $bundle], \Drupal::currentUser());
  }
}
```

Rebuild caches (`drush cr`) after adding one; it then appears for its `target_entity` (or select it
via the handler's `render_plugin`).
