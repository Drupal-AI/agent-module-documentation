<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Disable Web Install (disable_web_install) — agent index

Security-hardening module that **disables installing modules and themes through the Update Manager
web UI** while keeping its update-availability notifications. No config, no permissions, no forms —
enabling it is the whole configuration. Depends only on core **`system`** and **`update`**.
Core `>=10`, PHP 8.1. License GPL-2.0-or-later. Version 2.0.0.

- **What it overrides, how the redirect works, how to install/verify** →
  [hardening/install-blocking.md](hardening/install-blocking.md)

## What it actually is (from source)

- One event subscriber, `RouteSubscriber` (`src/Routing/RouteSubscriber.php`, service
  `disable_web_install.route_subscriber`, tag `event_subscriber`), extending
  `RouteSubscriberBase`. In `alterRoutes()` it walks `DisableWebInstall::ROUTE_MAPPINGS` and, for
  each Update Manager install route that exists, replaces its `_controller` default with
  `\Drupal\disable_web_install\DisableWebInstall::redirect` plus a hardcoded `redirect_route_name`.
- The mapping (`src/DisableWebInstall.php`, const `ROUTE_MAPPINGS`):
  `update.module_install` → `system.modules_list`, `update.report_install` → `update.status`,
  `update.theme_install` → `system.themes_page`.
- `DisableWebInstall::redirect(string $redirect_route_name = '<front>')` returns a
  `RedirectResponse` to `Url::fromRoute($redirect_route_name)`. The route name is only ever the
  hardcoded value set by the subscriber — not request- or user-supplied — so there is no
  open-redirect surface.
- `DisableWebInstall::menuLinkAlter()` unsets any menu link / local action whose route name matches
  a mapped target (regex `(^|:)<route>$`). Wired via `hook_menu_links_discovered_alter()` and
  `hook_menu_local_actions_alter()` in `disable_web_install.module`, so the "Install new
  module/theme" entry points disappear from the admin UI.

## Scope / notes

- It leaves the routes' **access requirements untouched** — it only swaps the controller, so the
  install routes still require their original permissions and simply redirect instead of rendering
  the install form. It adds no route and grants no access.
- It targets the **Update Manager** web-install flow only. It does **not** touch `/core/install.php`
  (the site installer) and is not a substitute for restricting `administer modules` /
  `administer themes` — treat it as defense in depth on a controlled deployment pipeline.
- No `config/**`, no `*.permissions.yml`, no `*.routing.yml`, no Drush, no plugins. The whole module
  is the four items above.
