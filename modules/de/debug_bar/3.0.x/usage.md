<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Debug Bar is a lightweight floating toolbar that shows per-request debug and performance information on the front end for users who hold its view permission.

---

Debug Bar injects a small toggleable bar into every non-redirect, non-AJAX HTML response for users with the `view debug bar` permission. It reports execution time, peak memory usage, database query count and cache status for the current request, plus the Drupal and PHP versions, the last cron run and the current Git branch, alongside quick links to the front page, status report, log overview and the current user's profile / login / logout. The metrics are collected by an HTTP middleware (`debug_bar.middleware`, priority 1001) that starts a query logger and interpolates placeholder tokens after the response is built, and the bar markup itself is assembled by a kernel event subscriber and `DebugBarBuilder` so it stays correct even when the page is served from cache. Users who also hold `administer site configuration` get extra items — the PHP version link, and one-click "Run cron" and "Clear caches" actions that fire through CSRF-token-protected query links. The toolbar position (one of four corners) is configured at `/admin/config/development/debug-bar` under the `administer debug bar` permission, and other modules can add their own items via `hook_debug_bar_items_alter()`.

---

- Show a floating debug toolbar on the front end for developers.
- Display the request execution time in milliseconds.
- Display peak memory usage for the request in MB.
- Show the number of database queries run for the page.
- Show the page cache status (anonymous `X-Drupal-Cache` or dynamic-cache header).
- Show the running Drupal core version with a link to the status report.
- Show the running PHP version with a link to the PHP info page (admins).
- Show the current Git branch of the checkout.
- Show when cron last ran, formatted as an interval.
- Run cron with one click from the bar (site-config admins).
- Clear all Drupal caches with one click from the bar (site-config admins).
- Jump to the recent log messages (dblog) overview.
- Jump to the front page, current user profile, login or logout.
- Choose which screen corner the bar docks to (top/bottom, left/right).
- Restrict who sees the bar with the `view debug bar` permission.
- Restrict who configures the bar with the `administer debug bar` permission.
- Keep timing/memory metrics accurate on cached pages via middleware token interpolation.
- Add custom items to the bar from another module with `hook_debug_bar_items_alter()`.
- Give each custom item an icon, weight, URL, title tooltip and access flag.
- Provide a quick per-request performance sanity check during development.
- Verify whether a given page is being served from page or dynamic cache.
- Confirm cron is running on schedule without visiting the status report.
- Hide the bar behind a toggle button so it stays out of the way until needed.
- Keep the toolbar off anonymous/general production traffic by not granting the view permission.
