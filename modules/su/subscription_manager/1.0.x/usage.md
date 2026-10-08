<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Subscription Manager stores local Subscription and Subscription Plan config/content entities that mirror a subscription held in a remote billing service (e.g. Chargebee, Stripe), and routes users to that provider's hosted portal/checkout through pluggable connector plugins.

---

The problem it solves is giving a Drupal site a consistent "My Membership / Manage Billing" surface without owning payment logic: the actual billing lives with the remote provider, and a `SubscriptionManagerConnector` plugin (annotation `@SubscriptionManagerConnector`, managed by `SubscriptionManagerConnectorManager`) implements `redirectToPortal()` and `redirectToSubscribe()`. The controller (`src/Controller/SubscriptionManagerController.php`) exposes `/user/my-subscriptions`, `/user/{user}/manage-subscription`, `/subscription-manager/subscribe`, and three JSON GET endpoints (`/subscription-manager/api/my-subscription|portal-url|subscribe-url`). A Drush command set and Views field plugins (`SubscriptionRemoteStatus`, `SubscriptionWillRenew`) round out the surface.

Security posture is strong and clearly hardened. Every route is permission-gated (`administer subscription manager`, `administer subscriptions`, `manage own subscriptions`) and the self-service routes also require `_user_is_logged_in`. The `manage-subscription` route enforces ownership in a `_custom_access` callback AND re-checks it inside the controller (defense-in-depth) so an authenticated user cannot open another user's billing portal — the code comments explicitly reference the fixed IDOR (`gg-ted1`). The `PostPurchaseTokenService` mints HMAC-SHA256 tokens bound to an order id with an expiry, verified with `hash_equals`, and the secret is derived from the site private key plus a per-purpose salt plus the hash salt — this closes a guessable-`order_id` auto-login hole (`gg-6kwq`) that would otherwise live in connector modules. Typical setup: enable the module, install a connector module, set the default connector on the admin form, create plans, and grant `manage own subscriptions`.
---
- Install a connector module and set it as the default connector.
- Let members open a hosted billing portal via `/user/my-subscriptions`.
- Grant `manage own subscriptions` so users can self-manage billing.
- Give support staff `administer subscriptions` to manage any user's plan.
- Create Subscription Plan entities describing available tiers.
- Attach a local Subscription entity to a user for a remote contract.
- Redirect a new buyer to the provider's checkout via the subscribe route.
- Fetch the current user's subscription as JSON from the API endpoint.
- Fetch the provider portal URL as JSON for a decoupled front end.
- Fetch the subscribe URL as JSON for a headless upgrade button.
- Show a dynamic "Upgrade" vs "Join" subscribe page title.
- Add a "will renew" column to a Views listing of subscriptions.
- Add a remote-status column to a Views listing of subscriptions.
- Configure the redirect target route for the my-subscriptions link.
- Fall back to the default connector when a stored connector is uninstalled.
- Mint a signed, expiring post-purchase auto-login token for an order id.
- Verify a post-purchase token before auto-logging in an anonymous buyer.
- Sync remote subscription status on login (deferred) or via cron.
- Run Drush commands to inspect or reconcile subscriptions.
- Write a custom connector plugin for a new billing provider.
- Use the subscription access control handler to gate entity operations.
- Localize the "Manage Billing" / "Join" menu link title per user state.
