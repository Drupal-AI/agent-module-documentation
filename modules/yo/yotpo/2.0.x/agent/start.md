<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Yotpo — agent index

A **client to connect Drupal with the Yotpo reviews/marketing API** (fetch/push reviews & data — typically a
Commerce store). Config at `yotpo.settings` (API key). Version **2.0.2**. Core `^10.2||^11`.

Integration — calls `https://api.yotpo.com` over **HTTPS** (Guzzle, TLS verification on). Handle the **API
key** as a secret (Key module / env). No access role.
