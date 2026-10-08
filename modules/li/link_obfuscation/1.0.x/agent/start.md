<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Link obfuscation — agent index

Obfuscates **links (esp. `mailto:` email)** so scrapers/bots can't easily harvest them (browser renders a
working link, often via JS decoding). Version **1.0.0-beta7**. Core `^8.8||^9||^10||^11`.

**Deterrent, not real protection** — determined harvesters (JS-capable) can still recover addresses; JS
decoding affects no-JS/accessibility. Light anti-harvesting measure; no access role.
