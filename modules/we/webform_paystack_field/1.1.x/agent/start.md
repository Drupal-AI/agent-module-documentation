<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Paystack Field — agent index

**Paystack payment field/handler for Webform**. Version **1.1.0**. Core `^10||^11`.

On return, **verifies the transaction server-side via Paystack's verify API** (not the redirect params) + safe `unserialize` (allowed_classes=FALSE) — defensive positive. Keys env-backed.