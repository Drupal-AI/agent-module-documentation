<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views RSS: Media (MRSS) Elements adds Yahoo Media RSS elements (`media:content`, `media:thumbnail`, `media:category`, ...) so a View's Feed display can publish podcast- and video-feed-compatible enclosures.

---

This submodule implements `hook_views_rss_namespaces()` (declaring the `media` namespace, `http://search.yahoo.com/mrss/`) and `hook_views_rss_item_elements()`, returning six MRSS item elements: `media:content`, `media:title`, `media:description`, `media:keywords`, `media:thumbnail`, `media:category`. The three richest elements have dedicated preprocess functions in `views_rss_media.inc`: `media:content` inspects a file or image field's raw value, resolves an image-style derivative if the source field uses one, and sets `url`/`type`/`fileSize`/`medium` attributes (creating the derivative on disk first if it doesn't exist yet, so `filesize()` succeeds); `media:thumbnail` does the same for a representative image, also handling rendered Media-entity output by regex-extracting the `src`/`width`/`height` from its markup; `media:category` builds a slash-delimited taxonomy hierarchy path (like `views_rss_core`'s `<category>`) plus `scheme`/`label` attributes. `media:title`/`media:description` get a `type="plain"`/`type="html"` attribute auto-detected from whether the value contains markup. This submodule is the base that `views_rss_media_getid3` extends (via `hook_views_rss_item_elements_alter()`) to add real audio/video technical metadata to `media:content`/`media:thumbnail`.

---

- Publish a podcast RSS feed with `media:content` enclosures (audio/video files, correct MIME type).
- Publish a video feed compatible with Media RSS-aware players and aggregators.
- Add `media:thumbnail` so podcast apps and video players show episode/clip artwork.
- Auto-generate an image-style derivative for a thumbnail/content element and get its real file size.
- Add `media:title`/`media:description` per item, separate from the RSS `<title>`/`<description>`.
- Auto-detect whether a media title/description contains HTML and set its `type` attribute accordingly.
- Add `media:keywords` (comma-delimited) for MRSS-aware search/indexing of media content.
- Add `media:category` from a taxonomy field, with a hierarchical path and scheme/label attributes.
- Serve a Media RSS feed for a video field on a content type without additional custom code.
- Combine with `views_rss_core` so an item carries both native RSS and MRSS element sets.
- Extract a thumbnail URL/dimensions from a rendered Media-entity field automatically.
- Publish a feed importable by Media RSS consumers such as podcast directories and video platforms.
- Provide the MRSS foundation that `views_rss_media_getid3` enriches with real audio/video metadata.
- Get the `media` namespace declared on `<rss>` automatically whenever a `media:*` element is used.
- Attach `medium` (audio/video/image) as an attribute derived from the file's MIME type.
