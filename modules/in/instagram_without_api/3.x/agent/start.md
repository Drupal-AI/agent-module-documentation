<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Instagram Without API (instagram_without_api) — agent index

Displays Instagram images by **scraping the public profile** (no API/tokens). Version **3.0.2**.

**Caveats:** inherently **fragile** (breaks when Instagram changes/blocks scraping); makes the server
fetch Instagram pages (confirm TLS verification, handle failure); scraping may violate Instagram's
ToS. Prefer the official API for anything important.