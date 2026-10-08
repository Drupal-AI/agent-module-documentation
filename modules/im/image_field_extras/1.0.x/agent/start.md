<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Field Extras — agent index

Adds **photo-credit** and **caption** metadata to core **image** fields. Version **1.0.1**. Core `^8 || ^9 || ^10`.

- `ImageExtraItem` field item + `image_field_extras.storage` service (`ImageExtraStorage`, uses cache.data + database).
- Depends on `image`. Editorial metadata only — no routes/permissions; field access governs it.
