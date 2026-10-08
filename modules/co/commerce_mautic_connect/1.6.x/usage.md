<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Mautic Connect syncs Commerce data to Mautic for marketing automation.

---

Commerce Mautic Connect bridges Drupal Commerce and Mautic (open-source marketing automation), pushing commerce events and data — abandoned carts, expiring cart-recovery links, coupon tags, customer-identity details, and RFM (recency/frequency/monetary) segmentation — to Mautic so marketers can automate campaigns based on shopping behaviour.

It sends customer/cart data to Mautic via the advanced_mautic_integration module; review data-flow/privacy. This module stores no Mautic credentials of its own — the Mautic base URL and API auth live in advanced_mautic_integration. Depends on Commerce `commerce_cart` and `advanced_mautic_integration`; optional `commerce_exchanger` for multi-currency metrics; supports Drupal 10 and 11.

---

- Connect Commerce to Mautic.
- Automate marketing campaigns.
- Track abandoned carts in real time.
- Send expiring, copy-only cart-recovery links.
- Recover carts across devices.
- Compute RFM segmentation.
- Tag contacts by coupon used.
- Sync billing name/phone/country to Mautic.
- Push commerce events to Mautic.
- Send customer/cart data to Mautic.
- Review data-flow/privacy.
- Depend on Commerce `commerce_cart`.
- Depend on `advanced_mautic_integration`.
- Support Drupal 10 and 11.
- Segment by shopping behaviour.
- Preview the cart email template before sending.
- Integrate marketing automation.
- Sync commerce data.
- Support campaign targeting.
- Bridge Commerce and Mautic.
- Suspend the sync during GDPR/migration operations.
- Extend with custom MauticFeature plugins.
