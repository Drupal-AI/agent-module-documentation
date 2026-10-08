<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events and integration points

The module ships **no `*.api.php`**; the extension points are a Symfony event and the ordinary
core hooks it implements (which you can react to or alter).

## `permissions_by_term.access.denied`

```php
Drupal\permissions_by_term\Event\PermissionsByTermDeniedEvent
  const NAME = 'permissions_by_term.access.denied';
  public function getNid();          // the node that was denied
```

Dispatched from `AccessCheck::dispatchDeniedEvent()` when access to a node is refused (via
`hook_node_access()` → `dispatchDeniedEventOnRestricedAccess()`, and from the module's kernel
event listener). Typical uses: redirect to a paywall/login page, log the attempt, or show a
custom message.

```php
// mymodule.services.yml
// services:
//   mymodule.pbt_denied:
//     class: Drupal\mymodule\EventSubscriber\PbtDeniedSubscriber
//     tags: [{ name: event_subscriber }]

use Drupal\permissions_by_term\Event\PermissionsByTermDeniedEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class PbtDeniedSubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [PermissionsByTermDeniedEvent::NAME => ['onDenied']];
  }

  public function onDenied(PermissionsByTermDeniedEvent $event): void {
    \Drupal::logger('mymodule')->notice('Denied node @nid', ['@nid' => $event->getNid()]);
  }

}
```

The **submodule** `permissions_by_entity` adds a second event,
`permissions_by_entity.entity_field_value_access_denied_event`
(`PermissionsByEntityEvents::ENTITY_FIELD_VALUE_ACCESS_DENIED_EVENT`), carrying the field, the
referenced entity, the uid and the field-delta index — its own
`RemoveEntityFromViewEventSubscriber` uses it to strip inaccessible referenced entities from a
rendered field.

## Hooks this module implements (know them before you add your own)

`hook_help`, `hook_form_alter` (adds `permissions_by_term_validate()` to **every** form),
`hook_form_taxonomy_term_form_alter`, `hook_form_user_form_alter`, `hook_form_node_form_alter`,
`hook_node_grants`, `hook_node_access`, `hook_node_access_records`, `hook_options_list_alter`,
`hook_user_insert`, `hook_user_update`, `hook_node_insert`, `hook_user_cancel`,
`hook_taxonomy_term_delete`, `hook_theme`, plus `hook_schema`, `hook_requirements`,
`hook_install`, `hook_uninstall` in `permissions_by_term.install`.

Consequences worth planning around:

- `hook_form_alter()` attaches the term validator globally, so any form submitting a
  `taxonomy_term` entity-reference widget is validated against the current user's grants.
- `hook_node_access_records()` returns `NULL` (no opinion) in several cases — node type without a
  taxonomy field, node without terms while `permission_mode` is off, no permission set on any of
  the node's terms, or `disable_node_access_records` on. Only in the remaining case does it emit a
  grant `['realm' => 'permissions_by_term', 'gid' => $nid, …]`.
- Theme hook `permissions_by_term_render_node_details` (template
  `src/View/node-details.html.twig`, variables `roles`, `users`) renders the node-form info panel;
  override it in a theme to change that panel.

## Library

`permissions_by_term/nodeForm` (`js/webpack-dist/bundle.js`, depends on `core/drupalSettings`) is
attached to node forms to fetch the permission info asynchronously from the two
`access-info-*` controllers.
