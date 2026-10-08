# 403 to 404 (m4032404) — agent index

Converts Drupal **403 Access Denied** responses into **404 Not Found** so protected pages appear
non-existent. Implemented by one exception subscriber (`M4032404EventSubscriber`, priority 50 on
`KernelEvents::EXCEPTION`) that swaps `AccessDeniedHttpException` for `NotFoundHttpException`.
Configure route `m4032404.config` → `/admin/config/system/m4032404`.

- **Settings keys (`admin_only`, `pages`, `negate`), the two permissions, and how the subscriber
  decides to redirect** → [configure/settings.md](configure/settings.md)

Key facts: config object `m4032404.settings` (defaults `admin_only: false`, `pages: []`,
`negate: true`). The `access 403 page` permission lets a user bypass the redirect and see the real
403. With an empty `pages` list the behaviour applies everywhere. No plugins, no Drush.
