# HTTP Client Error Status — agent index

Provides one Condition plugin, `http_client_error_status` ("HTTP 40x Client error status code"), that is
TRUE when the current request is a 401/403/404 error page. Used mainly as a **block visibility
condition**. In 3.1.x it doubles as a migration helper toward core's `response_status` condition, with a
listing page + three Drush commands. No `configure` route in info.yml. Provides a permission, Drush
commands, and config schema.

- **The condition plugin (settings, `evaluate()`), using it on blocks, and the core-migration model** →
  [configure/condition.md](configure/condition.md)
- **The `hces:list` / `hces:remove` / `hces:update` Drush commands and the `Main` service** →
  [drush/commands.md](drush/commands.md)

Key facts:
- Condition id `http_client_error_status`; settings `request_401`, `request_403`, `request_404` (bool) +
  `negate`; schema `condition.plugin.http_client_error_status`.
- `evaluate()` matches `request->attributes->get('exception')->getStatusCode()`; cache context
  `url.path`.
- Listing page `admin/config/development/http-client-error-status` (permission
  `administer http_client_error_status configuration`), controller `BlockListingController`, theme
  `http_client_error_status_table`.
- Core's `response_status` covers 403/404/200 but NOT 401; migration keeps 401 on this plugin.
- `hook_uninstall()` → `Main::removePluginInstances()` strips the condition from blocks (blocks kept).
