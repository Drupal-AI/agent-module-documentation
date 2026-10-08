<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Integrate the SensFRX fraud-detection service to screen users and orders.

---

SensFRX Fraud Prevention integrates advanced fraud detection and prevention into Drupal — screening user events (login, registration, comments) and Commerce orders/payments against the SensFRX SaaS to flag or block fraudulent activity, with an admin dashboard and webhooks for allow/deny decisions.

**Known issue (as shipped, 1.0.2):** `getSubscribedEvents()` references `PaymentEvents::` unconditionally, so on a site without Commerce Payment it fatals and the module's routes fail to register. Webhook callback routes: `/sensfrx/webhook` and `/sensfrx/transaction_webhook`. The SensFRX API credentials are admin-configured; store securely (env-backed). Depends on core `user`, `system`, `node`, and `comment`; supports Drupal 10 and 11.

---

- Integrate SensFRX fraud detection.
- Screen users and orders.
- Flag/block fraudulent activity.
- Provide an admin dashboard.
- Depend on core `user`/`system`/`node`/`comment`.
- Store credentials securely.
- Handle fraud prevention.
- Support Drupal 10 and 11.
- Support Drupal.
- Support Drupal.
- Support Drupal.
