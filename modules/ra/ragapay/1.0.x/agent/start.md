<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# RagaPay — agent orientation

Commerce off-site payment gateway + notification webhook.

- Version 1.0.x, core ^10||^11, deps commerce_payment/commerce_price. Gateway plugin `ragapay_offsite`.
- Notification route `/ragapay/notification` → `NotificationController::__invoke` parses the body and, if `order_number` is present, calls `RagaPayManager::updateOrder($order_number, $data)`, which loads the order + its ragapay payment and maps the posted `status` to a payment state (`success`→`completed`, `fail`→canceled, `waiting`→pending).
- `HashBuilder` builds the secure hash for the outbound redirect.
