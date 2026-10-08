<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Core elements this submodule registers

All elements below live under namespace `core`, module key `views_rss_core`. Config path in
`views.view.<name>`: `display.<id>.display_options.style.options.channel.core.views_rss_core.<element>`
(channel) or `...row.options.item.core.views_rss_core.<element>` (item — value is a View field
machine name, since item elements are sourced *from* fields, unlike channel elements which are
literal/text values entered on the form).

## Channel elements (`views_rss_core_views_rss_channel_elements()`)

| Element | Configurable | Notes |
|---|---|---|
| `title` | No (from View title) | |
| `description` | Yes (textarea) | Falls back to `system.site` slogan if blank. |
| `link` | No | Always the site front page, not the feed URL. |
| `atom:link` | No | Self-referencing link, added automatically. |
| `language` | Yes | Defaults to current site language if blank. |
| `category` | Yes | Comma-separated → multiple `<category>` tags. |
| `image` | Yes | Path to a GIF/JPEG/PNG, max 144x400px (validated). |
| `copyright`, `managingEditor`, `webMaster`, `generator`, `docs`, `cloud` | Yes | Plain text / URL fields. |
| `ttl`, `skipHours`, `skipDays` | Yes | `skipHours`/`skipDays` are comma-separated → multiple `<hour>`/`<day>` sub-tags. |
| `pubDate`, `lastBuildDate` | No | Auto-derived from the most recent item date in the result. |

## Item elements (`views_rss_core_views_rss_item_elements()`)

| Element | Notes |
|---|---|
| `title` | RSS-required (title or description). |
| `link` | RSS-required companion; runs a CDN-path-fixup preprocessor. |
| `description` | The other RSS-required option. |
| `author` | Strips a trailing "Role..." suffix and "Author" text from an authored-by-style field. |
| `category` | From a taxonomy-reference field: builds `parent/child` hierarchy paths + `domain` attribute; also works with a raw "Content: All taxonomy terms" field. |
| `comments` | Plain URL, e.g. to a node's comment page. |
| `enclosure` | From a file/image field (or `video_embed_field` value if that module is present): sets `url`, `length`, `type` attributes; creates an image-style derivative on the fly if needed to get its file size. |
| `guid` | Sets `isPermaLink="true"` automatically when the value is an absolute URL and a `link` element is also present. |
| `pubDate` | RFC-822 formatted; strips any `<time>` wrapper tags core adds. |
| `source` | Not configurable — filled from the View's title + current request URL. |
| `content:encoded` | CDATA-wrapped; declares the `content` namespace via `hook_views_rss_namespaces()` together with `atom`. |

## Other hooks implemented

- `hook_views_rss_date_sources()` — table/field pairs (`node_field_data.changed`,
  `comment_field_data.changed`, `file_managed.changed`, `users_field_data.changed`, ...) used to
  derive `<lastBuildDate>` via a `hook_views_query_alter()` that only fires when the View's
  style plugin id is `rss_fields`.
- `hook_views_rss_options_form_validate()` — validates the `image` element's URL/dimensions and
  the `docs` element's URL.

See the parent's [hooks/element-hooks.md](../../../../../2.4.x/agent/hooks/element-hooks.md) for
what these definition array keys (`preprocess functions`, `configurable`, `cdata`, ...) mean
generically.
