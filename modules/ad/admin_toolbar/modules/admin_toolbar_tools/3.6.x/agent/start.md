# admin_toolbar_tools — agent start

Adds action links (flush caches, run cron, add content, logout) under the Drupal icon in the
Admin Toolbar. Requires `admin_toolbar`. Links are built by a menu-link derivative
(`Plugin/Derivative/ExtraLinks.php`). Config UI:
`/admin/config/user-interface/admin-toolbar-tools` (route `admin_toolbar_tools.settings`).

- Settings (bundles-per-type, local tasks) → [configure/settings.md](configure/settings.md)
- Cache-flush & cron action routes → [api/actions.md](api/actions.md)
