<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
RSS Embed Field turns a Link field into an embedded feed: editors enter a feed URL and the node displays the latest items from that RSS/Atom source.

---

It adds a field widget and formatter (both id `rss_embed_field`) for `link` fields. On save, the widget validates the entered URL by fetching it server-side through the `rss_embed_field.fetcher` service (a Guzzle client, results cached 24h to a temp file) and parsing it with Laminas Feed Reader; invalid feeds raise a form error. The formatter re-fetches (from cache) and renders up to N items, sanitising each item's title/description with `strip_tags` or `Xss::filter` (configurable 'Remove HTML').

---

- Show the latest posts from an external blog on a node.
- Embed a partner or news RSS feed inside content.
- Let editors pick the feed per node via a link field.
- Cap the number of displayed feed items in the formatter.
- Strip or XSS-filter feed HTML before display.
- Cache feed fetches for a day to reduce outbound requests.
- Validate the feed URL at edit time via Laminas Feed Reader.
- Render feed titles, descriptions and links via a Twig template.
- Aggregate a curated feed onto a landing page.
- Reuse core's link field as the feed source.
- Display a company's own RSS output within the site.
- Toggle 'show title' for the feed channel heading.
- Provide a lightweight alternative to full feed aggregation.
- Surface syndicated content without custom fetching code.
- Fall back gracefully when a feed is unreachable or broken.
