<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Audience-based personalisation driven by Mautic segments and tags.

---

Mautic Audiences provides audience-based personalisation driven by Mautic segments and tags — exposing audiences as a composable primitive: block + Layout Builder section visibility conditions, a global Views filter, Twig functions, tokens, and a JavaScript API, so content varies by the visitor's Mautic audience.

**Security note (as shipped, 1.0.0):** the public webhook `/mautic-audiences/webhook` verifies an HMAC signature with `hash_equals()` when a `webhook_secret` is set (good), but **bypasses the check (accepts the request) when no secret is configured — the default** — so anonymous requests can trigger contact-refresh work (bounded impact: it re-fetches from Mautic, no direct data injection). **Set a `webhook_secret`.** Depends on `advanced_mautic_integration`; supports Drupal 10.3+ and 11.

---

- Personalise by Mautic audience.
- Expose audiences as a primitive.
- Provide LB/block visibility conditions.
- Offer a Views filter, Twig, tokens, JS API.
- Vary content by segment/tag.
- WARNING: webhook bypasses signature check when no secret set.
- Require setting `webhook_secret`.
- Verify HMAC with `hash_equals()` when configured.
- Depend on `advanced_mautic_integration`.
- Support Drupal 10.3+ and 11.
- Aid personalisation.
- Handle Mautic audiences.
- Support Drupal.
- Support Drupal.
- Support Drupal.
