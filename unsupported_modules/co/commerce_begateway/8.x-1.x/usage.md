<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
BeGateway Payment adds a BeGateway off-site gateway whose notifications are authenticated.

---

BeGateway Payment implements the BeGateway payment gateway for Commerce (off-site redirect) — the shopper is redirected to BeGateway to pay and the order is completed on return/notification.

Security: the notify handler (`onNotify`) uses the BeGateway SDK `Webhook` and checks `$webhook->isAuthorized()` (shop-id/secret credential verification) before acting, and the return path compares the gateway transaction amount to the order's amount — it does not blindly trust the callback. Store the shop secret key securely (env-backed). Depends on `commerce_payment` and `token`; supports Drupal 8, 9, 10, and 11.

---

- Provide a BeGateway off-site gateway.
- Redirect the shopper to BeGateway.
- Complete the order on return/notify.
- Authorize the webhook via the SDK.
- Check `$webhook->isAuthorized()` first.
- Compare transaction amount to the order.
- Not blindly trust the callback.
- Store the shop key/secret securely.
- Depend on `commerce_payment` and `token`.
- Support Drupal 8, 9, 10, and 11.
- Handle notifications.
- Verify payments.
- Process payments
- Authenticate callbacks
- Support checkout.
- Confirm securely.
- Handle BeGateway.
- Keep credentials secure
