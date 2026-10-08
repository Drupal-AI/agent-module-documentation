<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How Login Switch works (mechanism)

Three event subscribers registered in `login_switch.services.yml`, plus one theme hook.

## 1. Route override — `Routing\LoginSwitchRouteSubscriber`

Extends `RouteSubscriberBase::alterRoutes()`. For each of `login`→`user.login`,
`register`→`user.register`, `password`→`user.pass`:

```php
if ($config->get($key . '_disabled') && $route) {
  $path = $config->get($key . '_route');
  if (!empty($path)) {
    $route->setPath('/' . $path);          // move the route
  } else {
    $route->setRequirement('_access', 'false');  // deny the route
  }
}
```

Runs at router-rebuild time, so config changes need a router rebuild (`drush cr`, or the
settings form's own `router.builder->rebuild()` call on save).

## 2. noindex header — `EventSubscriber\AddNoIndexHeader`

Subscribes to `KernelEvents::RESPONSE` (priority -100). On the main request, if the current
route is one of `user.login` / `user.register` / `user.pass` and the matching `<key>_noindex`
config is true, sets `X-Robots-Tag: noindex` on the response. Note it matches by the **route
name**, so it still fires after the path has been changed by the route subscriber (the route
name is unchanged; only its path moved).

## 3. Deny `/user` when login disabled — `Routing\ExceptionEventSubscriber`

Subscribes to `KernelEvents::EXCEPTION` (priority 100). When `login_disabled` is true and the
current route is `user.page` and the user lacks the `access 403 page` permission, it replaces
the exception with a `NotFoundHttpException` — so `/user` returns 404 rather than the usual
redirect-to-login. (Only keys off `login_disabled`, not register/password.)

## 4. Theme hook — `login_switch_theme()`

Declares a `login_page` theme hook with one variable `auth_url`. The module ships no template
for it and does not render it itself; it exists so a theme can provide a
`login-page.html.twig` if it chooses to render a custom login link. Not required for the
route/noindex features.

## What it does NOT do

No plugins, no Drush commands, no services beyond the three subscribers, and no permissions of
its own. It never touches authentication logic — only route paths, access requirements on those
routes, and a response header.
