<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a JSON Feed in Views

All configuration happens inside a View (`/admin/structure/views`). There is no module settings page.

## Add the display

Edit/create a View → **Add** a display of type **JSON Feed**. It must have a **Path**. Optionally set
its *Link display* / *Attach to* another display (e.g. the View's Page) so an `alternate` link and a
feed icon are added to that page. The display auto-selects the JSON Feed **Format**
(`json_feed_serializer`) and **Row** (`json_feed_fields`).

Requirements (enforced by the plugins' `validate()`):
- The View must have a **title**, or enable *Use the site name for the title* (`sitename_title`).
- Row: `id` and `url` attributes must be mapped.
- Row: at least one of `content_html` or `content_text` must be mapped.

## Format (style) options — `json_feed_serializer`

Stored under `views.style.json_feed_serializer` (schema key: `description`) plus author/expired:
- **JSON Feed description** (`description`, ≤1024 chars) — feed-level description; supports token
  substitution from the first row.
- **Author** — feed author `name`, `url`, `avatar` (static text values).
- **Feed Expired** (`expired`) — sets the feed's `expired` attribute for feeds that will not update.
- `home_page_url` is derived from the display's *Link display* (falls back to the site front page /
  base URL); set Link Display to your main Page display to populate it.

Top-level output keys assembled in `render()`: `version` (`https://jsonfeed.org/version/1`), `title`,
`description`, `home_page_url`, `feed_url`, `favicon`, `author`, `next_url` (when more pages exist),
`items`, `expired`. Empty values are stripped.

## Row options — `json_feed_fields`

Each option is a select of the View's configured fields (add the fields to the View first). Schema
`views.row.json_feed_fields`:

| Attribute | Option key | Notes |
|---|---|---|
| id | `id_field` | **required**; unique, stable item id. |
| url | `url_field` | **required**; resolved to absolute URL. |
| external_url | `external_url_field` | absolute URL. |
| title | `title_field` | plain text (`strip_tags`). |
| content_html | `content_html_field` | the only attribute that keeps HTML. |
| content_text | `content_text_field` | plain text. |
| summary | `summary_field` | plain text. |
| image | `image_field` | absolute URL. |
| banner_image | `banner_image_field` | absolute URL. |
| date_published | `date_published_field` | format as RFC 3339 `Y-m-d\TH:i:sP`. |
| date_modified | `date_modified_field` | RFC 3339. |
| tags | `tags_field` | comma-separated → array of trimmed tags. |
| author.name / url / avatar | `author_name_field` / `author_url_field` / `author_avatar_field` | per-item author. |

Empty per-item attributes are removed via `array_filter`.

## Notes

- Live preview wraps the JSON in a `<pre>` block; the real path returns
  `Content-Type: application/json`.
- Date fields should be configured (in the View field settings) to output RFC 3339; the module does
  not reformat dates.
