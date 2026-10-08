<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Freedom Commerce removes Drupal Commerce's promotional "Inbox" messaging: it hides the inbox UI and replaces the message fetcher service with a no-op so no marketing messages are retrieved.
---
The module overrides the `commerce.inbox_message_fetcher` service with `NullInboxMessageFetcher`, whose `fetch()` and `fetchNewStoreMessages()` methods do nothing, so Commerce never pulls promotional messages from its remote source. Three small alter hooks in `freedom_commerce.module` then hide the surfaces: `hook_menu_local_actions_alter()` removes the inbox-message local action, `hook_module_implements_alter()` unsets Commerce's `toolbar` hook, and `hook_commerce_dashboard_page_build_alter()` unsets the `inbox` element from the Commerce dashboard build.

It is a tiny "freedom from marketing" utility with no configuration, routes, forms, or permissions — enabling it is the entire setup. It depends on Drupal Commerce (its service override targets `InboxMessageFetcherInterface`). Note the module's machine name is `freedom_commerce` although the project/directory is `freedom`.
---
- Stop Drupal Commerce from fetching promotional inbox messages.
- Hide the Commerce inbox local action from admin menus.
- Remove the Commerce inbox panel from the Commerce dashboard.
- Suppress Commerce's toolbar inbox indicator.
- Reduce outbound requests Commerce makes for marketing content.
- Give a cleaner, marketing-free Commerce admin experience.
- Enable with no configuration required.
- Swap the inbox fetcher service for a guaranteed no-op.
- Prevent store-message notifications from appearing to admins.
- Keep merchandising staff focused without promotional distractions.
- Deploy as a policy module to standardize a quiet admin UI.
- Pair with Commerce on sites that do not want vendor messaging.
- Remove the module to restore the default Commerce inbox behaviour.
- Avoid remote message calls in air-gapped or privacy-sensitive setups.
- Ship in config as a default part of a Commerce distribution.
- Silence the dashboard inbox without patching Commerce core.
- Override only the fetcher, leaving the rest of Commerce intact.
- Use as a lightweight example of a service-override + alter-hook module.