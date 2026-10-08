<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Blocking web install of modules & themes

How `disable_web_install` neutralizes Drupal's Update Manager web-install flow. Source: two files
plus a `.module` and a service definition.

## Install / enable

```
composer require drupal/disable_web_install
drush en disable_web_install -y
drush cr
```

There is nothing to configure — no settings form, no config object, no permissions. Enabling the
module applies the hardening; uninstalling it restores the normal install UI.

## The three routes it overrides

`DisableWebInstall::ROUTE_MAPPINGS` (const in `src/DisableWebInstall.php`) maps each core Update
Manager install route to a harmless redirect target:

| Overridden route (core `update` module) | Redirects to        | Typical path             |
| --------------------------------------- | ------------------- | ------------------------ |
| `update.module_install`                 | `system.modules_list` | `/admin/modules/install` |
| `update.report_install`                 | `update.status`     | (Update Manager report install) |
| `update.theme_install`                  | `system.themes_page` | `/admin/theme/install`   |

## Mechanism

- **Route alter** — `RouteSubscriber::alterRoutes()` (`src/Routing/RouteSubscriber.php`) runs on the
  dynamic route-collection event. For each mapping it checks both the source route and the redirect
  target exist, then calls `$route->setDefaults([...])` to replace the route's `_controller` with
  `\Drupal\disable_web_install\DisableWebInstall::redirect` and pass the hardcoded
  `redirect_route_name`. It deliberately does **not** modify the route's access/permission
  requirements, so the original access check still applies; only the rendered page changes.
- **Controller** — `DisableWebInstall::redirect()` returns
  `new RedirectResponse(Url::fromRoute($redirect_route_name)->toString())`. Because
  `redirect_route_name` is always the hardcoded mapping value (never a query parameter or path
  argument), the redirect destination is fixed and cannot be steered by a request.
- **Menu cleanup** — `DisableWebInstall::menuLinkAlter()` removes the corresponding menu links and
  local actions so the "Install new module" / "Install new theme" buttons vanish. It is invoked from
  `disable_web_install.module` via `hook_menu_links_discovered_alter()` and
  `hook_menu_local_actions_alter()`; the match is a regex anchored to the mapped route names
  (`(^|:)<route>$`), which also catches derivative/prefixed link ids.

## What it does NOT do

- It does not change who *can* reach `/admin/modules/install` — an administrator with
  `administer modules` still passes the access check and is simply bounced to the module list.
- It does not disable `/core/install.php` or the CLI/Composer install paths; installing code via
  Composer or drush continues to work as intended.
- It does not touch the update *status* / notification features, so "updates available" reporting and
  email notifications from the `update` module keep working.

## Verifying it works

After enabling and clearing cache:

- Visit `/admin/modules/install` (or `/admin/theme/install`) as an admin → you are redirected to the
  module list / appearance page instead of seeing the upload-and-install form.
- The "Install new module" / "Install new theme" local action buttons no longer appear on
  `/admin/modules` and `/admin/appearance`.
- `/admin/reports/updates` still lists available updates.
