<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cloudinary (cloudinary) — agent index

Integrates the **Cloudinary** media CDN/transformation service. Version **dev**. Submodules: stream
wrapper, storage (+DB), media-library widget, SDK, source-migrate, video.

**Creds/data:** Cloudinary API key + secret (keep out of plain config); media **resides on
Cloudinary** (leaves your infra — data-location decision). Ensure non-public media isn't made
publicly transformable.