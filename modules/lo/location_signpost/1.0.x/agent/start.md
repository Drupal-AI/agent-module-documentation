<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Location Signpost — agent index

**Signposts visitors to local-area services by address/postcode** via the Ordnance Survey Places API + postcodes.io.
Depends on core `block`, `node`, `link`. Provides permissions. Version **1.0.0-alpha2**. Core `^10||^11`.

Integration/content — sends **address/postcode (location PII) to external APIs** (disclose); **OS Places API key**
as a secret (env/Key, HTTPS). No access role beyond permission.
