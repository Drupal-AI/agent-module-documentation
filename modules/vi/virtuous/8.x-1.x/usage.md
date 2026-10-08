<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Integrate Drupal with the Virtuous CRM fundraising platform.

---

Virtuous provides integration between Drupal and the Virtuous CRM fundraising platform — syncing contacts and related data between Drupal and Virtuous (a nonprofit donor-management/CRM system), with webhooks for contact-created/updated events.

**Security warning (as shipped, 8.x-1.0):** the webhooks `/virtuous/webhook/contact-created` and `/contact-updated` are `_access: 'TRUE'` (anonymous) and the controller's token-authorization check is **deliberately disabled** (`// Authorization validation disabled`) — so anonymous callers can trigger contact syncs for arbitrary contact ids (API-quota abuse, id enumeration, data pollution; the sync re-fetches server-side, so no direct data injection). **Re-enable `validateWebhookAuthorization()`.** The Virtuous API key is handled via a Key entity (`key`, env-backed). Depends on core `user`, `field`, `taxonomy`, `telephone`, `datetime`, `views`, plus `key` and `field_group`; supports Drupal 11.

---

- Integrate the Virtuous CRM.
- Sync contacts to/from Virtuous.
- Handle contact webhooks.
- Serve nonprofit fundraising.
- WARNING: webhook auth is disabled.
- Re-enable the token check.
- Handle the API key via a Key entity.
- Depend on core + `key`/`field_group`.
- Support Drupal 11.
- Store credentials securely.
- Handle Virtuous.
- Manage donors.
- Support Drupal.
- Support Drupal.
- Support Drupal.
