<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Redsys Button to Drupal — agent index

Provides a **Redsys payment-button form** (redirect to the Redsys gateway; `commerce_redsys_button` submodule
for Commerce). Config at `redsys_button.redsys_config_form`. Version **1.0.2**. Core `^9||^10||^11`.

**Security (correct):** signs requests with **HMAC-SHA256** (Redsys' standard scheme) + a Validators
component. Store the merchant secret key as a **secret**; HTTPS; ensure the **notification/return is
signature-validated** (reject forged "paid" callbacks) — confirm in config.
