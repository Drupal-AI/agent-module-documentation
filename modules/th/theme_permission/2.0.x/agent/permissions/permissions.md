# Theme Permission — permissions & access model

## The dynamic permissions

`theme_permission.permissions.yml` registers a `permission_callbacks` entry pointing at
`\Drupal\theme_permission\ThemePerm::dynamicPermissions()`. That method iterates every **installed**
theme (`theme_handler->listInfo()`) and emits, per theme:

| Permission (machine name) | Gates |
|---|---|
| `administer themes <theme>` | Managing that theme: it appears on the Appearance page and its install / set-default / settings / block-per-theme operations are allowed. |
| `uninstall themes <theme>` | The **Uninstall** operation for that theme (in addition to `administer themes <theme>`). |
| `Edit Administration theme` | (Emitted once.) Whether the admin-theme selection form at the bottom of the Appearance page is shown. |

`<theme>` is the theme machine name, so on a site with Olivero + Claro installed you get
`administer themes olivero`, `uninstall themes olivero`, `administer themes claro`,
`uninstall themes claro`, and `Edit Administration theme`. Newly installing a theme makes its pair of
permissions appear on `/admin/people/permissions`.

Assign these on the normal permissions page (`/admin/people/permissions`) or in a role's config
(`user.role.<rid>` `permissions:` list).

## How access is enforced (RouteSubscriber)

`Drupal\theme_permission\Routing\RouteSubscriber::alterRoutes()`:

- Replaces the **Appearance page** (`system.themes_page`) controller with
  `\Drupal\theme_permission\Controller\AccessController::themesPage` (title "Appearance"). This
  controller is a fork of core's themes page that only lists a theme, and only builds its operation
  links, when `currentUser()->hasPermission("administer themes $theme_name")` (uninstall links also
  require `uninstall themes $theme_name`). The admin-theme form is added only for
  `Edit Administration theme`.
- Adds `_custom_access = \Drupal\theme_permission\Controller\AccessController::access` to these
  routes: `block.admin_display_theme`, `system.theme_settings_theme`, `system.theme_set_default`,
  `system.theme_install`, `system.theme_uninstall`.

`AccessController::access()` reads the target theme from the route's `theme` argument (or the `theme`
query parameter) and returns **allowed** iff `$account->hasPermission("administer themes $theme")`,
otherwise **forbidden**.

## Notes for an agent

- These per-theme permissions are **not** in a static `*.permissions.yml` list — they are generated,
  so the available machine names depend on installed themes. To enumerate them at runtime:
  `(new \Drupal\theme_permission\ThemePerm(\Drupal::service('theme_handler')))->dynamicPermissions()`.
- Core's own `administer themes` still works; this module adds a finer-grained alternative on top.
- Granting `administer themes <theme>` lets a role **install** that theme; installing a theme is
  inherently powerful (a theme can run its own PHP via templates/preprocess), so grant per-theme
  install rights only to trusted roles.
