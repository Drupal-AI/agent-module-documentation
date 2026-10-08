<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BLEND translator (tmgmt_oht) — agent index

TMGMT translator plugin for **BLEND / getBlend** (ex-One Hour Translation). Version **8.x-1.0**. Core `^9 || ^10`. Depends on tmgmt, tmgmt_file.

`OhtTranslator` (core http_client, public/secret keys in settings, default TLS). Inbound route `/tmgmt_oht_callback` is `_access: 'TRUE'` but **the controller authenticates the request**: requires `custom1 == OhtTranslator::hash(job_item_id)` where `hash = md5(Settings::getHashSalt() . id)`. Hash salt is a site secret → callback token is unforgeable by outsiders. Sound (uses md5 + `==` on a secret-derived token — acceptable).
