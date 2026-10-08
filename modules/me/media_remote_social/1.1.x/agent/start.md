<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Remote Social — agent index

Creates a **Remote social media type** for embedding **oEmbed Facebook/Instagram posts** as Drupal media.
Depends on core `media`, `key`; provides permissions. Version **1.1.0**. Core `^10||^11`.

**Security (done right):** uses the **Key module** to store the platform oEmbed access token (secret via env/
Key provider, not plain config) — configure the Key with the token. Embedded posts are remote content. No
content-access role beyond permission.
