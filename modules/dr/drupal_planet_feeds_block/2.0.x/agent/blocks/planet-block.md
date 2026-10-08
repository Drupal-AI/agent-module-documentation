<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Planet Drupal" feed block

## Install & enable

```bash
composer require drupal/drupal_planet_feeds_block
drush en drupal_planet_feeds_block -y
```

Depends only on core **`views`** (Drupal enables it automatically). No composer/PHP library
requirements, no permissions of its own, no Drush commands, no submodules, no settings page.

## The plugin

`src/Plugin/Block/DrupalPlanetFeedsBlock.php` — class `DrupalPlanetFeedsBlock` extends core
`BlockBase`:

```php
/**
 * @Block(
 *  id = "drupal_planet_feeds_block",
 *  admin_label = @Translation("Planet Drupal"),
 * )
 */
```

There is no `access()` override, so the block uses core's default block visibility (place it and
control exposure with standard block visibility conditions).

## Configuration (per block instance)

Settings live on the **block placement form** (`blockForm()`), not on any admin config page, and
are stored in the block's own `settings` configuration by `blockSubmit()`:

| Setting key | Type | Meaning |
|---|---|---|
| `number_of_feeds_to_display` | `number` (`#min => 1`, `#max => 30`) | How many feed `<item>` entries to render. |
| `html_tag_to_render` | `select` | HTML tag wrapping each rendered link. Options come from `\Drupal::config('views.settings')->get('field_rewrite_elements')` (the same tag list Views uses for field rewriting), plus an empty " - Select -" option. Empty → defaults to `<h4>`. |

The `views` dependency exists solely to provide that `field_rewrite_elements` option list.

## How the feed is fetched and rendered

`build()`:

1. Reads `$this->configuration['number_of_feeds_to_display']` into `$number`.
2. Fetches the feed with `simplexml_load_file('https://www.drupal.org/planet/rss.xml')` — the URL
   is **hardcoded** (not configurable) and fetched over **HTTPS**.
3. Iterates `$xml->channel->item`; a counter skips items past `$number` (so the first `$number`
   items are shown in feed order).
4. For each item, casts the entry to an array and builds a link:
   `Url::fromUri($entry['link'])` → `Link::fromTextAndUrl($entry['title'], $url)->toString()`,
   then `$link->getGeneratedLink()`.
5. Wraps the generated link: default `<h4>…</h4>`, or `<{tag}>…</{tag}>` when
   `html_tag_to_render` is non-empty. Each item is a `#type => markup` render element.
6. Appends `$build['drupal_planet_feed_more']` — a `#type => more_link` to
   `https://www.drupal.org/planet`.
7. Sets `$build['#cache']['max-age'] = 0` — the block is **never cached**, so the feed is
   refetched on every uncached page render.

Only the item **title** (link text) and **link** (href) are used; item descriptions/bodies are
not rendered. Link text is produced through core's `Link`/`LinkGenerator`, and the href through
core's URL assembler.

## How to place it

```
Structure → Block layout (/admin/structure/block)
  → Place block in a region
  → filter by "Planet Drupal"
  → set Title, Number of feeds to display, HTML tag, Visibility
  → Save block
```

## Operational notes

- **No caching (`max-age = 0`)**: every uncached render performs a synchronous network fetch of
  the feed, so the block's render time tracks drupal.org availability/latency. There is no
  timeout, retry, or error handling around `simplexml_load_file`; if the feed is unreachable or
  malformed the block renders empty (only the "more" link).
- **Fixed source**: the feed URL cannot be changed via the UI or config; it always points at the
  official Drupal Planet feed.
- **Count bounds**: the item count is constrained to 1-30 by the number field; the feed itself
  determines how many items are actually available.
