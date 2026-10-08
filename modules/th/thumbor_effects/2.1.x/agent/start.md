<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Thumbor Effects — agent index

Adds **Thumbor smart-imaging effects** (smart/content-aware crop, filters) to Drupal **image styles** —
derivatives generated via the Thumbor server. Depends on core `image`. Config at
`thumbor_effects.settings_form`; provides permissions. Version **2.1.0**. Core `^9.3||^10||^11`.

**Security:** store the Thumbor **security key** as a secret (Thumbor URLs are HMAC-signed — a leaked
key lets attackers forge transformation URLs). Configure server URL + key.
