<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Displays the latest posts from the Drupal Planet RSS feed as a placeable Drupal block.

---

Drupal Planet Feeds Block ships one block plugin ("Planet Drupal", id `drupal_planet_feeds_block`) that, each time it renders, fetches the official Drupal Planet feed from `https://www.drupal.org/planet/rss.xml`, takes the first N `<item>` entries (N is a per-block setting, 1-30), and renders each item's title as a link to the original post, wrapped in an HTML tag you choose (default `<h4>`). A "more" link to `https://www.drupal.org/planet` is appended. The feed URL is fixed (not configurable), there is no admin settings page, and the two options live on the block-placement form. The module depends on core Views solely to reuse its `field_rewrite_elements` tag list for the wrapper-tag select. Render caching is disabled (`max-age = 0`), so the feed is refetched on every uncached page render — expect the block's latency to track drupal.org's availability.

---

- Add a "latest Drupal community news" block to a sidebar or footer without building a feed importer.
- Surface recent Drupal Planet blog posts on a homepage or landing page.
- Show community activity on an intranet or team dashboard for Drupal developers.
- Give a documentation or agency site a live feed of ecosystem news.
- Place the block once and let it stay current without editorial upkeep.
- Limit the block to the 3-5 most recent posts for a compact sidebar widget.
- Show up to 30 recent posts for a dedicated "Drupal news" page region.
- Wrap each headline in `<h4>` (default) for a scannable list of headings.
- Choose a different wrapper tag (e.g. `<div>`, `<p>`, `<span>`) from the Views field-rewrite tag list to match your theme.
- Restrict the block to specific pages, roles, or content types using core block visibility conditions.
- Give the block a custom title (e.g. "From the Drupal community") via the standard block title field.
- Provide new team members a rolling feed of current Drupal topics.
- Add community context beside your own blog or news listing.
- Combine with core block placement in any region exposed by your theme.
- Use as a lightweight, dependency-light alternative to a full feed-import (Aggregator/Feeds) pipeline when you only need to display headlines.
- Demo or teach Drupal block plugins with a small, self-contained real-world example.
- Populate a footer "stay informed" column linking out to drupal.org/planet.
- Offer editors a zero-configuration widget they cannot misconfigure (only count and wrapper tag are exposed).
- Include the latest planet headlines in a maintenance or "coming soon" page.
- Add a curated-looking news strip to a Drupal agency marketing site.
