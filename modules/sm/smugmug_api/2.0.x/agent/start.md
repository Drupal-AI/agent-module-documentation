<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SmugMug API — agent index

Provides **API access to SmugMug** (photo hosting) — fetch albums/photos to display/import. Config at
`smugmug_api.settings`. Version **2.0.2**. Core `^8||^9||^10||^11`.

**Security:** store SmugMug API credentials (key/OAuth) as **secrets**; HTTPS; fetched media is external
content. No access role.
