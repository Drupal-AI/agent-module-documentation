<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Nextcloud DAM — agent index

**Integrates a Nextcloud instance as a digital-asset-management source**. Depends on core `media`,
`entity_browser`, `social_auth_nextcloud`. Provides permissions. Version **1.0.0-alpha2**. Core `^9||^10||^11`.

Media/integration — connects to the **Nextcloud API** (egress) with **credentials/OAuth** (store as secrets —
env/Key, HTTPS); expose only audience-appropriate assets. Own permissions.
