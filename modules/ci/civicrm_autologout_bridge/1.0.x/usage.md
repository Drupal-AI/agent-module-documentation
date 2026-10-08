<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CiviCRM Autologout Bridge fixes premature session timeouts for users working in CiviCRM under the Automated Logout module.

The Automated Logout (`autologout`) module resets its idle timer from Drupal page requests plus JS-detected `mousemove`/`keyup`/`formUpdated` events on `document.body`. CiviCRM's AJAX-heavy screens generate plenty of real activity that never triggers a full Drupal page load, and three specific interaction types never reach autologout's own listeners: CiviCRM AJAX content reattachment (popups, inline edits, menu-driven content swaps), page scrolling (the `scroll` event doesn't bubble), and touch input (`touchstart` doesn't always emit `mousemove`). Users doing genuine work in CiviCRM therefore get counted as idle and logged out mid-task. This module fills exactly those three gaps and nothing else. It implements `hook_page_attachments()` to attach a lightweight JS behaviour (`civicrm_autologout_bridge/bridge`) on CiviCRM pages for authenticated users only; the JS dispatches autologout's own `preventAutologout` event on `document.body` (debounced to once per 5 seconds) so autologout's existing AJAX/keep-alive cycle — including its server-rendered CSRF token and cross-tab cookie sync — resets the timer. CiviCRM pages are detected by a `civicrm.*` route name or a path of `/civicrm` or `/civicrm/...`. Anonymous users are skipped and cache contexts (`user.roles:authenticated`, `route`, `url.path`) are declared so the attachment caches correctly.

There is no configuration UI, route, permission, service, entity or config object. Enable it alongside Automated Logout and CiviCRM and it works. It only adds a keep-alive signal on genuine interaction; it does not extend, disable or change the logout timeout, which stays governed entirely by the Automated Logout module. The only tunable is the `SIGNAL_INTERVAL` constant inside the JS file.
---
Enable it alongside Automated Logout + CiviCRM; genuine CiviCRM AJAX/scroll/touch interaction then keeps the Drupal session alive automatically, with no configuration.
---
- Stop CiviCRM users being logged out during long AJAX-heavy tasks
- Keep the session alive while a staff member edits a CiviCRM contact record
- Count CiviCRM AJAX navigation (popups, inline edits, menu content swaps) as activity
- Register page scrolling as activity even when the mouse doesn't move
- Register touch input on mobile/tablet CiviCRM screens as activity
- Bridge CiviCRM interaction into Automated Logout's `preventAutologout` timer reset
- Apply the keep-alive only on CiviCRM routes (`civicrm.*`) or `/civicrm` paths
- Limit the behaviour to authenticated users (anonymous users are skipped)
- Preserve correct render caching via declared cache contexts
- Avoid changing the global logout timeout while fixing CiviCRM-specific timeouts
- Improve UX for staff doing bulk CiviCRM data entry or long contact reviews
- Reduce lost work from unexpected logouts during CiviCRM workflows
- Keep non-CiviCRM pages on standard autologout behaviour
- Deploy without any configuration, permission assignment or content-type change
- Rely on autologout's own cross-tab cookie sync so activity in a CiviCRM tab keeps a Drupal tab alive
- Debounce activity signals (default 5s) to avoid excessive keep-alive traffic
- Tune the debounce by editing the `SIGNAL_INTERVAL` constant in the JS file
- Pair with Automated Logout's existing idle-warning dialog and redirect
- Add CiviCRM support to an existing autologout deployment with a single lightweight module
