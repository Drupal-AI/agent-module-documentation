<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TMGMT Lara Translate — agent index

A **Lara Translate provider plugin for TMGMT** (machine translation via the Lara service). Depends on `key`,
`sm`, `tmgmt`, `tmgmt_content`. Provides permissions. Version **2.0.0-beta4**. Core `^10||^11`.

Multilingual/integration — **sends content to the external Lara service** (egress — confirm acceptable);
credential stored via the **Key** module (secret provider, HTTPS). No access role beyond permissions.
