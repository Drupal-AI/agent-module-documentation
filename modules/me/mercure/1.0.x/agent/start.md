<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mercure — agent index

Integrates the **Mercure protocol** (real-time server-sent pub/sub over SSE) with Drupal (live updates/
notifications for decoupled/interactive front ends). Version **1.0.5**. Core `^9.5||^10||^11`.

**Security:** Mercure uses **JWT** to authorize publish (and private-topic subscribe) — keep the **JWT
publisher secret confidential** (store as a secret; it grants publishing to any topic), authorize subscribers
for private topics, run the hub over **HTTPS/WSS**. No Drupal access role beyond the token model.
