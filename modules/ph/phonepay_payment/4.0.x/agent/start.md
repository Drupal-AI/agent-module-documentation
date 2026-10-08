<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PhonePe Payment — agent index

A **PhonePe payment gateway for Drupal Commerce** (UPI/cards). Version **4.0.1**. Core `^9||^10||^11`.

Callback route: `/phonepay_payment/callback/{order_id}` (`PaymentStatusController::callback`). Gateway settings:
merchant ID, salt key (store as a secret), salt index, mode (UAT/production), profile type.
