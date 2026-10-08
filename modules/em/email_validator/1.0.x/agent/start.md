<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Email Validator (EVA) — agent index

**Validates email addresses (deliverability) via an external service** (reduce fake/undeliverable addresses).
Provides permissions. Version **3.0.0**. Core `^8.8||^9||^10||^11`.

Form-validation/anti-abuse — **sends emails to an external service** (data egress/privacy — confirm acceptable
+ disclosed); **API key** as a secret over HTTPS. No access role beyond permission.
