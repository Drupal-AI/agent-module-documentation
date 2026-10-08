<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Meta Pixel — agent index

**Meta (Facebook) Pixel + Conversions API (CAPI)** tracking — unified browser/server event collection
with automatic **deduplication**. `meta_pixel_commerce` submodule for e-commerce events. Provides
permissions. Version **1.0.0-alpha2**. Core `^10||^11`.

**Privacy/consent:** sends user/event data to Meta (CAPI includes server-side identifiers) — require
consent, integrate cookie-consent, disclose tracking, store the CAPI token as a secret. No content-access
role.
