<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Vipps MobilePay Commerce — agent index

A Drupal Commerce **payment gateway for Vipps MobilePay**. Depends on `vipps_mobilepay`, `commerce_payment`.
Provides permissions. Version **1.0.0-beta1**. Core `^10.3||^11`.

E-commerce/payment — registers a Vipps webhook (SDK) + receives notifications via Commerce's
`commerce_payment.notify`; confirm status **server-side with Vipps** (SDK handles webhook auth); credentials as
secrets, HTTPS. No access role beyond permission.
