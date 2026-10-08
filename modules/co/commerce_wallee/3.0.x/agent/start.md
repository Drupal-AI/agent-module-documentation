<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Wallee — agent index

A **Wallee payment gateway for Drupal Commerce** (offsite redirect; bundled `wstack` SDK/webhook submodule).
Depends on `commerce`, `commerce_payment`. Version **3.0.x** (dev). Core `^10.5||^11`.

E-commerce/payment — webhook follows the **authoritative pattern**: reads only entity/space id, matches the
gateway, **re-fetches state from Wallee via the SDK** (not the payload status), acts only on local entities (no
status spoofing). Notes: webhook is public+unsigned (safe via re-fetch) with a `sleep(20)` — rate-limit it;
credentials as secrets, HTTPS.
