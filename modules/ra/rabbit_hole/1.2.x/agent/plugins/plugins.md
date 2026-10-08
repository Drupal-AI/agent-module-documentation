# Plugin types Rabbit Hole defines

Two plugin types, both classic annotation-based (managers extend `DefaultPluginManager`).

## 1. Behavior plugins — what action to take

- Namespace: `Plugin/RabbitHoleBehaviorPlugin`
- Annotation: `@RabbitHoleBehaviorPlugin` (`Drupal\rabbit_hole\Annotation\RabbitHoleBehaviorPlugin`, keys `id`, `label`)
- Interface: `RabbitHoleBehaviorPluginInterface`; base: `RabbitHoleBehaviorPluginBase`
- Manager: `plugin.manager.rabbit_hole_behavior_plugin`; alter hook: `hook_rabbit_hole_rabbit_hole_behavior_plugin_info_alter()`
- Built-ins: `DisplayPage` (display_page), `AccessDenied` (access_denied), `PageNotFound` (page_not_found), `PageRedirect` (page_redirect)

Implement `performAction(EntityInterface $entity, Response $current_response = NULL)` to
return a `Response` (or NULL to display). Override `settingsForm()` to add form controls and
`alterExtraFields()` to declare base fields (as `PageRedirect` does for `rh_redirect`).

```php
namespace Drupal\mymodule\Plugin\RabbitHoleBehaviorPlugin;

use Drupal\rabbit_hole\Plugin\RabbitHoleBehaviorPluginBase;
use Drupal\Core\Entity\EntityInterface;
use Symfony\Component\HttpFoundation\Response;

/**
 * @RabbitHoleBehaviorPlugin(
 *   id = "gone",
 *   label = @Translation("410 Gone")
 * )
 */
class Gone extends RabbitHoleBehaviorPluginBase {
  public function performAction(EntityInterface $entity, Response $current_response = NULL) {
    return new Response('', 410);
  }
}
```

## 2. Entity plugins — which entity types are supported

- Namespace: `Plugin/RabbitHoleEntityPlugin`
- Annotation: `@RabbitHoleEntityPlugin` (keys `id`, `label`, `entityType`)
- Base: `RabbitHoleEntityPluginBase`; Manager: `plugin.manager.rabbit_hole_entity_plugin`

Each submodule ships one (e.g. `rh_node`'s `Node` with `entityType = "node"`). The manager's
`loadSupportedEntityTypes()` / `loadSupportedBundleEntityTypes()` drive which forms get the
Rabbit Hole tab, and permissions are generated per supported entity type. To add support for a
custom entity type, drop a plugin like:

```php
/**
 * @RabbitHoleEntityPlugin(
 *  id = "rh_my_entity",
 *  label = @Translation("My entity"),
 *  entityType = "my_entity"
 * )
 */
class MyEntity extends RabbitHoleEntityPluginBase {}
```
