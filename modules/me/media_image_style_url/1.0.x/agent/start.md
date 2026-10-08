<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Image Style URL — agent index

Provides a **route to fetch a media item's image in a chosen image style** (URL for a media entity rendered
through an image style — decoupled/dynamic image links). Depends on core `image`, `media`. Provides
permissions. Version **1.0.2**. Core `^8.8||^9||^10||^11`.

Media/integration — resolves media + image style: ensure it **respects media access**; can trigger derivative
generation; its permission gates use. No broad access role beyond that.
