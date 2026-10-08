<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Billwerk Subscriptions connects Drupal user accounts to the Billwerk (reepay) subscription-management platform, keeping subscription state in sync and mapping active plans onto Drupal roles.

---

The module talks to the Billwerk REST API through an `Api` service (with an `Environment`/`SettingsHelper` for base URL + API key, a `CacheHelper`, and a `LogHelper`). A `BillwerkRolesManager` grants/revokes roles based on a user's Billwerk contract state, a `Subscriber`/`BillwerkDataObjectFactory` model the Billwerk data objects, and an `EmbedHelper` supports embedding Billwerk self-service. Three routes are exposed: an admin settings form (`administer billwerk_subscriptions configuration`, marked restrict-access); a logged-in per-user "Refresh subscription" form (`/user/{user}/subscription/refresh`) gated by a custom access check; and an inbound **webhook listener** at `/billwerk-subscriptions/webhook-listener/{secret}`. The webhook route uses `_access: 'TRUE'` because it is public by design, but the controller authenticates the caller by comparing the `{secret}` path segment against the configured shared secret with a strict `===` check and then re-fetches the authoritative subscription details from the Billwerk API rather than trusting the request body — a vendor-recommended pattern. Permissions also cover self-service management of own vs any contract and the "fetch & assign contract ids" action.

Setup: enter the Billwerk API credentials and environment in the settings form, configure the plan→role mapping, register the webhook URL (including the secret) in the Billwerk dashboard, and grant the self-service permissions to the appropriate roles. Because roles are driven by external subscription state, treat the API key and webhook secret as sensitive.

---

- Connect Drupal user accounts to Billwerk (reepay) subscription contracts.
- Enter the Billwerk API key and environment in the settings form.
- Map Billwerk subscription plans to Drupal roles.
- Automatically grant roles when a contract becomes active.
- Automatically revoke roles when a contract lapses.
- Receive Billwerk webhooks at the secret-protected listener route.
- Let logged-in users refresh their own subscription from their profile.
- Manually trigger a refresh of a user's subscriptions via an action.
- Fetch and assign Billwerk Contract IDs by matching ExternalId to UID.
- Allow self-service management of a user's own contract.
- Allow privileged staff to manage any user's contract.
- Embed the Billwerk self-service UI on the user profile.
- Debug outbound Guzzle calls with the suggested http_client_logger.
- Track Billwerk-related account changes with the suggested entity_log.
- Register the webhook URL (with secret) in the Billwerk dashboard.
- Re-fetch authoritative subscription data instead of trusting webhook bodies.
- Cache Billwerk API responses via the module's cache helper.
- Restrict settings access with the restrict-access admin permission.