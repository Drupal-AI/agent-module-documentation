<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Anonymous-redirect event subscriber

The module's entire behavior is one event subscriber. There is no UI, config, route, permission or schema.

## Install / enable
- `drush en anonymous_redirection -y` (or via Extend). No configuration step follows — it is active the
  moment it is enabled. Requires core `user` (declared in `anonymous_redirection.info.yml`).
- To turn it off, uninstall the module (`drush pmu anonymous_redirection -y`). There is no "disable
  redirection" toggle.

## Service definition
`anonymous_redirection.services.yml`:
```yaml
services:
  anonymous_redirection.event_subscriber:
    class: Drupal\anonymous_redirection\EventSubscriber\AnonymousRedirectionSubscriber
    arguments: ['@current_user', '@request_stack']
    tags:
      - { name: event_subscriber }
```

## Class: `AnonymousRedirectionSubscriber`
File: `src/EventSubscriber/AnonymousRedirectionSubscriber.php`. Implements `EventSubscriberInterface`.
Constructor injects `AccountInterface $current_user` and `RequestStack $request_stack`.

- `getSubscribedEvents()` → subscribes `onRequest` to `KernelEvents::REQUEST` at **priority 28**
  (runs after core routing has populated the `_route` request attribute, before the controller).
- `onRequest(RequestEvent $event)`:
  1. Reads the current request from the request stack and its `_route` attribute.
  2. If the user is anonymous **and** `_route` is none of `user.login`, `user.register`, `user.pass`,
     it sets the response to `new RedirectResponse('/user/login')` — a `302` to a fixed internal path.

The whitelist of three auth routes is the only escape hatch; it exists solely to prevent an infinite
redirect loop and to keep self-service login/registration/password-reset reachable.

## Operational notes
- **Scope is the whole site.** Every anonymous route not in the whitelist is redirected, including the
  front page, `system.*` AJAX/asset routes, `image.style_public` derivatives, and REST/JSON:API/GraphQL
  endpoints. If you need anonymous access to any of those, this module is too coarse.
- **No destination handling.** It does not append a `?destination=` parameter, so users are not returned
  to the originally requested page after login. Core's own `403 → /user/login` flow (via
  `RedirectResponse` with destination) is not used here.
- **Extending the whitelist** (the only way to allow specific anonymous routes) requires a code change or
  a custom higher-priority subscriber that short-circuits this one; there is no config to add exceptions.
  A custom subscriber must run at a priority **> 28** and stop propagation to win.
- **Interaction with core access.** This runs regardless of route access; content access is otherwise
  still governed by normal Drupal permissions for authenticated users.
