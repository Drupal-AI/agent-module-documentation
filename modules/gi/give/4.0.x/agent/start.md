<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Give — agent index

Accept **donations via Stripe / cheque / bank transfer** (donation forms + records; `give_civicrm` submodule).
Depends on core `field`; provides permissions. Config at `give.settings`. Version **4.0.x** (dev). Core
`^9||^10||^11||^12`.

**Security:** store Stripe keys as **secrets**; HTTPS; if using Stripe webhooks, **verify the Stripe-Signature**
(reject forged "succeeded" events); donor records are PII — gate access, handle per privacy.
