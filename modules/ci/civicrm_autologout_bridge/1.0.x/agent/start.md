<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CiviCRM Autologout Bridge (civicrm_autologout_bridge) — agent index

**Keep-alive bridge**: feeds CiviCRM AJAX/scroll/touch interaction into the Automated Logout idle timer so CiviCRM users aren't logged out mid-task. Client-side only — no server endpoints.

**Version:** 1.0.x (1.0.5). Core: `^10.3 || ^11`. Package: CiviCRM. License: GPL-2.0-or-later.
**Dependencies:** `autologout:autologout` and `civicrm` (hard deps). No composer requirements.

## What it provides
- `hook_page_attachments()` in `civicrm_autologout_bridge.module` — on CiviCRM pages, for authenticated users only, attaches JS library `civicrm_autologout_bridge/bridge`. CiviCRM pages = route name `civicrm.*` OR path `/civicrm` / `/civicrm/...`. Anonymous users return early. Declares cache contexts `user.roles:authenticated`, `route`, `url.path`.
- JS `js/civicrm_autologout_bridge.js` (`Drupal.behaviors.civicrmAutologoutBridge`) — binds `scroll` + `touchstart` on `document` (once, passive) and signals on every CiviCRM AJAX behaviour reattach inside `#crm-container`/`.crm-container`. Each signal dispatches autologout's own `preventAutologout` event on `document.body`, debounced by `SIGNAL_INTERVAL` (5000 ms).
- Library deps: `core/drupal`, `core/once`, `autologout/drupal.autologout`.

## What it does NOT provide
No routes, permissions, services, controllers, AJAX/REST endpoints, entities, plugins, config objects, config schema, install/update hooks, or Drush commands. No settings page (`configure: null`). The only tunable is the `SIGNAL_INTERVAL` JS constant. Mouse/keyboard activity is intentionally NOT re-bound — autologout already watches those on `document.body`.

## Solution docs
- [Implementation & operation](implementation/bridge.md) — how the attach logic + JS signal work, how to verify, how to tune.
