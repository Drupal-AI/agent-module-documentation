<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON Feed extends Views with a JSON Feed display, style, and row plugin so a View can be published as a [JSON Feed 1.0](https://jsonfeed.org/) endpoint — a modern, machine-readable alternative or supplement to RSS/Atom.

---

The module adds three Views plugins: a **display** `json_feed` (`JsonFeed`, extends core's Feed
display) that outputs a JSON response at a configurable path and can attach to another display; a
**style** `json_feed_serializer` (`JsonFeedSerializer`) that assembles the top-level JSON Feed object
(`version`, `title`, `description`, `home_page_url`, `feed_url`, `favicon`, `author`, `next_url`,
`expired`, `items`); and a **row** `json_feed_fields` (`JsonFeedFields`) that maps View fields to
per-item attributes. The row form maps fields to `id`, `url`, `external_url`, `title`,
`content_html`, `content_text`, `summary`, `image`, `banner_image`, `date_published`,
`date_modified`, `tags`, and item `author` name/url/avatar; `id` and `url` are required and at least
one of `content_html`/`content_text` must be set (enforced in `validate()`). Values are largely
`strip_tags()`-cleaned before JSON encoding, except `content_html` which the JSON Feed spec allows to
contain HTML; URL fields are resolved to absolute URLs. The feed must have a title (or opt into using
the site name via `sitename_title`). Paging is supported — when there are more results the feed's
`next_url` points to the next page. When attached to a page display, the module adds an `alternate`
`<link>` and a feed icon (theme hook `json_feed_icon`, CSS library `json_feed/json-feed`) to that
page. Requires the core Views module.

---

- Publish a View of content as a JSON Feed endpoint for feed readers and apps.
- Offer a modern alternative to RSS/Atom using the JSON Feed 1.0 format.
- Expose a blog or news section as `content_html` items with titles and permalinks.
- Provide a lightweight JSON data feed for a decoupled/JavaScript front end to consume.
- Map any Views field to the JSON Feed `id`, `url`, and content attributes.
- Include per-item author name, URL, and avatar in the feed.
- Add `image` and `banner_image` URLs so readers can show previews.
- Include `date_published` / `date_modified` timestamps (RFC 3339) per item.
- Attach the JSON feed to an existing Views page so an `alternate` link tag is added automatically.
- Add a clickable feed icon to the page the feed is attached to.
- Paginate large feeds and let readers follow `next_url` to subsequent pages.
- Set a feed-level description and author from the style plugin settings.
- Use the site name (and slogan) as the feed title via the `sitename_title` option.
- Mark a temporary feed as `expired` when it will no longer update.
- Add `external_url` items that point to content hosted elsewhere.
- Provide `content_text` plain-text items where HTML is not wanted.
- Tag items with a comma-separated `tags` field for reader categorization.
- Syndicate content to services and aggregators that consume JSON Feed.
- Serve a feed at a custom path independent of the View's page path.
- Keep feed output cache-aware via Views' render pipeline and cache metadata.
