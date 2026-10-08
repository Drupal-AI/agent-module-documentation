<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Redirect behavior (event subscriber)

## Service

- Service id: `external_reset_password.redirect_subscriber` (`external_reset_password.services.yml`).
- Class: `Drupal\external_reset_password\EventSubscriber\ExternalRedirectSubscriber`.
- Arguments: `@current_route_match`, `@config.factory`.
- Tag: `event_subscriber`.

## What it does

`getSubscribedEvents()` registers `onRequest` on `kernel.request` with priority `0`.

`onRequest(RequestEvent $event)`:

1. Reads the current route name via `RouteMatchInterface::getRouteName()`.
2. Acts only when the route is `user.pass` — the core "Request new password" form at `/user/password`. It compares the route name exactly (`$route_name == 'user.pass'`), so no other route is affected.
3. Loads `external_reset_password.settings` and reads the `url` key.
4. If a URL is configured, calls `$event->setResponse(new TrustedRedirectResponse($external_url))`, sending the visitor to that URL. If `url` is empty, it does nothing and Drupal renders the normal reset request form.

The redirect target is exactly the stored config value; it is a `Drupal\Core\Routing\TrustedRedirectResponse`, as required for redirects to external hosts.

## Operating notes

- Configure the URL first (see [../config/settings.md](../config/settings.md)), then `drush cr`.
- Behavior is verified by `tests/src/Functional/ResetPasswordTest.php`: with a URL set, `/user/password` lands on the external address; with an empty URL, it stays on `/user/password`.
- To restore Drupal's built-in reset form, clear the `url` value (save an empty field) and rebuild caches.
