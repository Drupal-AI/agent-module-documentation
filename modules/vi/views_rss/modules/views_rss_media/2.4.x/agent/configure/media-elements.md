<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MRSS elements this submodule registers

All 6 elements are **item** elements, namespace `media` (URI `http://search.yahoo.com/mrss/`),
module key `views_rss_media`. Config path in `views.view.<name>`:
`display.<id>.display_options.row.options.item.media.views_rss_media.<name>`, value = a View
field machine name.

| Element | Preprocess (`views_rss_media.inc`) | Notes |
|---|---|---|
| `media:content` | `views_rss_media_preprocess_item_content()` | Reads a file/image field's raw value; if the field renders through an image style, resolves the style's derivative URI (creating it on disk first if missing, so `filesize()` succeeds) and sets `url`, `type`, `fileSize`, `medium` (`audio`/`video`/`image`, derived from the MIME type's first segment) attributes. Falls back to a bare `url` attribute for non-file rendered markup. |
| `media:title` | `views_rss_htmlspecialchars` then `views_rss_media_preprocess_item_text()` | Sets `type="plain"` or `type="html"` based on whether the value contains markup after decoding. |
| `media:description` | Same as `media:title` | Same `type` attribute logic. |
| `media:keywords` | none | Plain comma-delimited text pass-through. |
| `media:thumbnail` | `views_rss_media_preprocess_item_thumbnail()` | File/image fields: same image-style resolution as `media:content` (`url` only, no size attrs). Media-entity fields: renders the field and regex-extracts `src`/`width`/`height` from the resulting `<img>` markup. Converts a root-relative URL to absolute. Element is **omitted entirely** if no URL was resolved. |
| `media:category` | `views_rss_media_preprocess_item_category()` | Builds a slash-delimited parent/child taxonomy path (like `views_rss_core`'s item `<category>`) as the element value, plus `label` (term name) and `scheme` (term canonical URL) attributes. |

`media:content` and `media:thumbnail` are exactly the two elements `views_rss_media_getid3`
appends extra preprocess functions to (via `hook_views_rss_item_elements_alter()`) to add
`framerate`/`bitrate`/`width`/`height`/`samplingrate`/`channels`/`duration` attributes read
from the actual media file.

See the parent's [hooks/element-hooks.md](../../../../../2.4.x/agent/hooks/element-hooks.md)
for what `preprocess functions` means generically, and this module's sibling
`views_rss_media_getid3` for the technical-metadata extension.
