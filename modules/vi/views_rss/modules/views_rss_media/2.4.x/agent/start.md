<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views RSS: Media (MRSS) Elements — agent index

Adds Yahoo Media RSS elements (`media:content`, `media:thumbnail`, `media:category`,
`media:title`, `media:description`, `media:keywords`) via the parent `views_rss` module's
`hook_views_rss_*` hooks, for podcast/video-style feeds. No channel elements, no settings page
— its 6 elements appear in the row plugin's "Item elements : media" fieldset. Extended (not
replaced) by `views_rss_media_getid3`, which adds real audio/video metadata attributes to
`media:content`/`media:thumbnail` via an alter hook.

- **The 6 media:* elements, their attributes, and how thumbnails/content resolve image styles**
  → [configure/media-elements.md](configure/media-elements.md)

Key fact: elements live under namespace `media`, module key `views_rss_media`, e.g.
`row.options.item.media.views_rss_media.content` in `views.view.<name>` config. See the
parent's [hooks/element-hooks.md](../../../../2.4.x/agent/hooks/element-hooks.md) for the
underlying `hook_views_rss_*` mechanism and the alter-hook pattern
`views_rss_media_getid3` uses on top of this module.
