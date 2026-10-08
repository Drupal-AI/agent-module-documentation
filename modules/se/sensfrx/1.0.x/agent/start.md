<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SensFRX Fraud Prevention — agent index

**SensFRX fraud-detection integration** (user + Commerce screening). Version **1.0.2**. Core `^10||^11`.

Webhook routes: `/sensfrx/webhook`, `/sensfrx/transaction_webhook`. Known issue: broken without Commerce Payment (unguarded `PaymentEvents`). Depends on core `user`/`system`/`node`/`comment`.