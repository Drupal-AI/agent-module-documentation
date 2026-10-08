<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Implementation & operation

## Install / enable
Requires `autologout` and `civicrm` (both hard deps in `civicrm_autologout_bridge.info.yml`). No composer.json ships with the module. Enable with `drush en civicrm_autologout_bridge` then `drush cr`. No configuration, permissions, or content changes result.

## Server side — `civicrm_autologout_bridge.module`
Single hook: `civicrm_autologout_bridge_page_attachments(array &$attachments)`.

1. Always appends cache contexts to `$attachments['#cache']['contexts']`: `user.roles:authenticated`, `route`, `url.path` (so the attach decision is cached per those axes).
2. Returns early if `\Drupal::currentUser()->isAnonymous()` — anonymous users never get the library.
3. CiviCRM detection: `TRUE` if `\Drupal::routeMatch()->getRouteName()` starts with `civicrm.`; else fallback checks `\Drupal::request()->getPathInfo()` equals `/civicrm` or starts with `/civicrm/`.
4. If CiviCRM, appends library `civicrm_autologout_bridge/bridge` to `$attachments['#attached']['library']`.

That is the entire server-side surface — no routes, controllers, forms, services, or endpoints.

## Library — `civicrm_autologout_bridge.libraries.yml`
`bridge`: loads `js/civicrm_autologout_bridge.js`; depends on `core/drupal`, `core/once`, `autologout/drupal.autologout`.

## Client side — `js/civicrm_autologout_bridge.js`
`Drupal.behaviors.civicrmAutologoutBridge.attach(context)`:
- One-shot via `once('civicrm-autologout-bridge', 'body')`: adds passive listeners for `scroll` and `touchstart` on `document`, both calling `signalActivity()`.
- On each behaviour reattach where `context` is inside `#crm-container`/`.crm-container` (a CiviCRM AJAX update), calls `signalActivity()`.

`signalActivity()`: rate-limited by `SIGNAL_INTERVAL = 5000` ms via a `lastSignal` timestamp; when allowed, dispatches `new Event('preventAutologout')` on `document.body`. That event is autologout's own activity flag; autologout keeps the flag set ~30 s and runs its existing keep-alive AJAX (with its server CSRF token and cross-tab cookie sync). This module contributes only the client-side signal — it does not itself talk to the server or alter timeout values.

Deliberately NOT bound: `mousemove` / `keyup` / `formUpdated` — autologout already listens for those on `document.body` and they bubble up from CiviCRM content.

## Operate / verify / tune
- Verify: on a CiviCRM page, in DevTools run `document.body.addEventListener('preventAutologout', () => console.log('signalled'))`, then scroll or trigger a CiviCRM AJAX action — expect `signalled` within 5 s. Mouse/keyboard won't fire it via the bridge (handled by autologout directly).
- Timeout duration, warning dialog, and cross-tab behaviour are all configured in the Automated Logout module, not here.
- Tune the throttle by editing the `SIGNAL_INTERVAL` constant in the JS file (the only tunable); then `drush cr`.
