<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Disable User 1 (disable_user_1) — agent index

Blocks the account with **uid 1** — Drupal's implicit superuser — from holding a browser session. No
dependencies, no routes, no permissions, no admin UI. Core requirement `^10 || ^11`.

## Mechanism (the whole module)

- One event subscriber: `Drupal\disable_user_1\EventSubscriber\DisableUser1EventSubscriber`
  (service `disable_user_1.event_subscriber`), listening on `KernelEvents::REQUEST` (`onRequest`).
- On every request it reads `\Drupal::config('disable_user_1.settings')->get('disable_user_1')`. When
  that is **TRUE** *and* `\Drupal::currentUser()->id() == 1`, it calls `user_logout()`, adds an error
  message ("User 1 is disabled and cannot log in."), and redirects to `/`.
- It is **not** a login-form alter — the check runs per request, so it catches uid 1 no matter how the
  session was established (login form, one-time login link `user/reset/…`, password reset). The user is
  logged out on their next page view.
- `disable_user_1.module` is empty; there is no `config/install`, no config schema, no
  `permissions.yml`, no routing.

## Activation (required — the module is inert until you do this)

- The config key `disable_user_1.settings:disable_user_1` has **no default and no admin UI**. Enabling
  the module alone does nothing.
- Activate by adding to `settings.php`:
  `$config['disable_user_1.settings']['disable_user_1'] = TRUE;`
- Deactivate / recover by removing that line (or uninstalling the module) and rebuilding the cache.
- Full detail → [configure/disable_user_1.md](configure/disable_user_1.md)

## Before enabling

- **Confirm a real administrator account** (with an *administrator* role) exists and works — disabling
  uid 1 without one leaves the browser with no full administrator.
- **Why it matters:** uid 1 is a hard-coded exception in Drupal — `hasPermission()` returns TRUE for it
  regardless of the permissions page. It is the highest-value account on any site and the one least
  likely to be governed, typically created at install and shared during the build.
- **Command-line access is unaffected:** Drush does not route through the HTTP kernel this subscriber
  listens on, so Drush administration continues to work — that is also the point, moving superuser use
  from a browser password to server access.

## Key facts (real machine names)

- Subscriber class: `Drupal\disable_user_1\EventSubscriber\DisableUser1EventSubscriber`; service id
  `disable_user_1.event_subscriber`; tag `event_subscriber`; event `KernelEvents::REQUEST` → `onRequest`.
- Config object / key: `disable_user_1.settings` / `disable_user_1` (boolean), set via `settings.php`
  `$config` override.
- No dependencies, routes, permissions, Drush commands, plugins, config schema, or submodules.
