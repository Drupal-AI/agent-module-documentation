<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# NoFraud — agent index

**Integrates the NoFraud fraud-screening service** with Drupal Commerce (scores orders for fraud). Depends on
`commerce_payment`. Version **1.0.10**. Core `^9||^10||^11`.

E-commerce/security — sends **order/customer/payment PII to the NoFraud API** (egress — disclose); **API key** as
a secret (env/Key, HTTPS). No access role.
