<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Entity Calaméo — agent index

A **Media source for embedding Calaméo publications** (flipbook/document viewer). An editor supplies a
Calaméo **ID (shortcode)** or a full `calameo.com/read/…` URL; the module extracts the shortcode, fetches
publication metadata from the **Calaméo API** (`https://api.calameo.com/1.0`, `API.getBookInfos`), and renders
an `<iframe>` embed. Depends on core `media`. Version **2.0.0**. Core `^10.6 || ^11`.

Requires Calaméo **API Key + API Secret Key** (entered on the settings form at
`/admin/config/media/media_entity_calameo`, stored in `media_entity_calameo.settings` config). Without them a
runtime `hook_requirements` error is raised. Provides a `calameo` media source plugin, a `calameo_embed` field
formatter (mode / view / width / height), a Media Library add form, a `CalameoManager` service
(`media_entity_calameo.manager`), and the `administer media_entity_calameo settings` permission
(restrict access).

Media/integration — the publication is hosted by **Calaméo** and embedded (third-party); the cover thumbnail
is copied locally into `public://calameo-thumbnails/…`. Media access follows core media/file access; no access
role beyond the admin permission.
