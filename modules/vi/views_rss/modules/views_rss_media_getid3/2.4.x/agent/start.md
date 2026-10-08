<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views RSS: Media getID3 — agent index

Adds **no new RSS elements**. It decorates `views_rss_media`'s `media:content` and
`media:thumbnail` elements (via `hook_views_rss_item_elements_alter()`) with real audio/video
metadata attributes — framerate, bitrate, resolution, sample rate, channels, duration — read
from the actual media file using the `james-heinrich/getid3` PHP library. **Requires that
library to be composer-required separately**; it ships only as a `require-dev` entry in the
parent project's `composer.json`, so production use needs
`composer require "james-heinrich/getid3:^2.0@beta"` (see the module's own `README.md`).

- **What attributes it adds, to which elements, and the library dependency** →
  [extend/getid3-attributes.md](extend/getid3-attributes.md)

Key facts: depends on `views_rss_media` — see its
[configure/media-elements.md](../../../views_rss_media/2.4.x/agent/configure/media-elements.md)
for the base `media:content`/`media:thumbnail` definitions this module extends. No config keys
of its own to inspect on a View — its effect is visible only in rendered feed output (or by
checking `hook_views_rss_item_elements_alter` ran, e.g. via
`views_rss_get('item_elements')['views_rss_media']['media:content']['preprocess functions']`).
