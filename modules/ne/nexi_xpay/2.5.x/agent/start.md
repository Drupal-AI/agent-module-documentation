<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Nexi XPay — agent index

**Nexi XPay payment gateway** (transaction entity + plugin system). Version **2.5.4**. Core `^11`.

Notify `/nexi-xpay/notify/{txn}/{token}` gated by a 256-bit per-transaction token verified with `hash_equals()` (forged notifies rejected — positive). Credentials env-backed. Perms: `administer nexi xpay`, `view nexi xpay transactions`. Depends on core `field`/`options`/`system`/`user`.