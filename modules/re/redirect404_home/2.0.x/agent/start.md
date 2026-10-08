# Redirect 404 to Home Page — agent index

Overrides core's `system.404` route controller to answer missing-page requests with a
configurable HTTP redirect (301/302/303/307) + optional Messenger message. Config UI at
`admin/config/search/redirect404_home` (`configure` = `redirect404_home.settings`, permission
`administer site configuration`). No own permissions, no Drush, no dependencies. Provides a config
schema for its three settings.

- **Settings keys, the route override, the redirect-loop caveat, and how to enable it** →
  [configure/settings.md](configure/settings.md)

Key facts:
- `RouteSubscriber::alterRoutes()` sets `system.404`'s `_controller` to
  `\Drupal\redirect404_home\Controller\Redirect404Home::on404`.
- Config object `redirect404_home.settings`: `redirection` (int, default `301`),
  `status_message` (string, default `''`), `status_message_color` (`status`/`warning`/`error`,
  default `status`).
- CAVEAT: as shipped (2.0.3) `on404()` redirects to `Url::fromRoute('system.404')` = `/system/404`,
  which it has itself overridden → verified infinite 301 loop on Drupal 11, NOT a redirect to the
  front page. Confirm behavior before use.
