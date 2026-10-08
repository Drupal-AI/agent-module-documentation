# Events (the integration surface)

This module is customised through **event subscribers**, not hooks (the `.module` files implement only
`hook_help`/`hook_cron`). Register a subscriber the normal way:

```yaml
# my_module.services.yml
my_module.lti_subscriber:
  class: Drupal\my_module\EventSubscriber\MyLtiSubscriber
  tags: [{ name: event_subscriber }]
```

```php
use Drupal\lti_tool_provider\Event\LtiToolProviderEvents;
use Drupal\lti_tool_provider\Event\LtiToolProviderLaunchEvent;

public static function getSubscribedEvents(): array {
  return [LtiToolProviderEvents::LAUNCH => 'onLaunch'];
}
public function onLaunch(LtiToolProviderLaunchEvent $event): void {
  $event->setDestination('/some-path');           // override post-launch redirect
}
```

## Core events — `Drupal\lti_tool_provider\Event\LtiToolProviderEvents`

Dispatched from the auth provider / launch / return flow. Every event exposes the
`LTIToolProviderContext` (`getContext()`).

| Constant | Event name | Event class | Fires | Use it to |
|---|---|---|---|---|
| `PROVISION_USER` | `lti_tool_provider.provision.user` | `LtiToolProviderProvisionUserEvent` | each launch, after the user is resolved, before login completes | inspect/adjust the user (roles & attributes submodules subscribe here) |
| `CREATE_USER` | `lti_tool_provider.create.user` | `LtiToolProviderCreateUserEvent` | only when a brand-new user is created | set fields on first provision (`getUser()`/`setUser()`) |
| `AUTHENTICATED` | `lti_tool_provider.authenticated` | `LtiToolProviderAuthenticatedEvent` | after provisioning, before `user_login_finalize()` | final say on the user/context |
| `LAUNCH` | `lti_tool_provider.launch` | `LtiToolProviderLaunchEvent` | in the launch controller, after auth, before redirect | `getDestination()` / `setDestination()` |
| `RETURN` | `lti_tool_provider.return` | `LtiToolProviderReturnEvent` | in the return controller, before logout/redirect | change the destination sent back to the platform |

The LTI context is also readable anywhere from the session:
`\Drupal::request()->getSession()->get('lti_tool_provider_context')`.

## Submodule events

- **Roles** — `LtiToolProviderRolesEvents::PROVISION` = `lti_tool_provider_roles.provision`
  (`LtiToolProviderRolesProvisionEvent`), fired after roles are applied, before the user is saved.
- **Attributes** — `LtiToolProviderAttributesEvents::PROVISION` = `lti_tool_provider_attributes.provision`
  (`LtiToolProviderAttributesProvisionEvent`), after attributes are applied, before save.
- **Provision** — `Drupal\lti_tool_provider_provision\Event\LtiToolProviderProvisionEvents`:
  `CREATE_PROVISION` (`lti_tool_provider_provision.create.provision`),
  `CREATE_ENTITY` (`…create.entity`), `SYNC_ENTITY` (`…sync.entity`),
  `REDIRECT` (`…redirect`) — hook these to alter the provision record, the created entity, the synced
  entity, or the redirect destination. The subscriber also listens on the core `LAUNCH` event.
- **Content** — `Drupal\lti_tool_provider_content\Event\LtiToolProviderContentEvents`:
  `SELECT` (`lti_tool_provider_content.select`), `RESOURCE` (`…resource`),
  `RETURN` (`…return`), `LAUNCH` (`…launch`) — alter the content-selection destination, the
  deep-linking resource properties, the response message, or the launched entity.
