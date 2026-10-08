<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webhook Receiver provides token-protected POST endpoints that dispatch an incoming payload to a plugin, so an external service can notify Drupal that something happened.

---

Integrations are increasingly push rather than pull: a payment provider reports a settled charge, a CI system reports a finished build, a CRM reports a changed record, a mail platform reports a bounce. Polling for those is wasteful and slow, and the alternative is an endpoint the other side calls — which every project then builds by hand as a controller with an ad-hoc secret, usually stored in configuration and exported to version control. This module makes the endpoint the framework and the handler a plugin, with `webhook_receiver_example` showing the shape and `webhook_receiver_defer` for queueing work rather than doing it in the request. Version **2.0.0** on core `^10 || ^11`. The token handling is better than most and worth knowing about: tokens are **encrypted at rest with libsodium under a key derived from the site's hash salt**, deliberately not stored in the database, and the module refuses to run with a hash salt shorter than 32 bytes rather than degrading quietly. Two caveats. The token is compared with **`!=` rather than `hash_equals()`**, which is a non-constant-time comparison of a secret on an unauthenticated, unmetered endpoint. And the module's **`info.yml` carries a different project's metadata** — it reports as *"Expose Status Report"* with the description *"Expose a Drupal site's status report via JSON"* in every module listing, which is a poor label for the module that opens your anonymous POST endpoints.

---

- Receive a payment provider's webhook.
- Handle a CI build notification.
- Accept a CRM record-changed callback.
- Process a mail platform's bounce report.
- Replace polling with a push endpoint.
- Add a webhook without a custom controller.
- Queue webhook work for later.
- Protect an endpoint with a token.
- Handle a Stripe or GitHub callback.
- Simulate a webhook for testing.
- Log incoming webhook payloads.
- Add several webhook handlers.
- Receive an inventory update.
- Trigger a cache purge from outside.
- Accept a subscription status change.
- Handle a shipping carrier's update.
- Receive a form platform's submission.
- Build a push-based integration.
