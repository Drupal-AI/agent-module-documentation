<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Freedom Commerce (freedom) — agent index

**Disables Drupal Commerce's promotional Inbox: replaces the fetcher service with a no-op and hides the inbox UI surfaces.**

- **Version:** 1.0.x (project `freedom`; module machine name `freedom_commerce`)
- **Core:** ^10 || ^11 — depends on Drupal Commerce
- **Service override:** `commerce.inbox_message_fetcher` → `NullInboxMessageFetcher` (`fetch()`/`fetchNewStoreMessages()` are empty).
- **Hooks (.module):** `hook_menu_local_actions_alter()` (drop inbox action), `hook_module_implements_alter()` (unset Commerce `toolbar`), `hook_commerce_dashboard_page_build_alter()` (unset `inbox`).
- **Config:** none — enabling it is the entire setup.
- **Security:** no routes/forms/permissions; it only *removes* a fetch and hides UI, reducing outbound calls. No security findings.