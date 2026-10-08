<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Landingi Landing Pages — agent index

**Import Landingi-built landing pages into Drupal**. Version **1.0.3**. Core `^10||^11`. Project `landingi`.

**SECURITY (1.0.3):** `LandingiApiClient` uses `'verify' => FALSE` (TLS verification disabled) while sending the `apiKey` → MITM can steal the key. Remove `verify => FALSE`; key env-backed.