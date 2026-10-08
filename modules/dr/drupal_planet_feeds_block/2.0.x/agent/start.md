<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drupal Planet Feeds Block (drupal_planet_feeds_block) — agent index

A single **block plugin** that fetches the official Drupal Planet RSS feed
(`https://www.drupal.org/planet/rss.xml`) on every render and lists the latest item titles as
links. Package: none declared. Depends on core **`views`** (only to reuse its
`field_rewrite_elements` tag list). Core requirement `^8.8 || ^9 || ^10 || ^11`. License
GPL-2.0-or-later. Version 2.0.1.

- **The block plugin — how it fetches, renders, and is placed/configured** →
  [blocks/planet-block.md](blocks/planet-block.md)

## What it actually is

- One plugin: `DrupalPlanetFeedsBlock` (id **`drupal_planet_feeds_block`**, admin_label
  *"Planet Drupal"*), in `src/Plugin/Block/DrupalPlanetFeedsBlock.php`, extending core
  `BlockBase`. No entities, no routes, no services, **no permissions**, no config schema, no
  Drush, no submodules.
- One hook: `drupal_planet_feeds_block_help()` in `.module` (help text on
  `help.page.drupal_planet_feeds_block` only).
- The feed URL is **hardcoded** in `build()`; there is no settings form and no configurable URL.

## Mechanism (from source)

- `blockForm()` exposes two per-instance settings: `number_of_feeds_to_display`
  (`#type => number`, `#min => 1`, `#max => 30`) and `html_tag_to_render` (`#type => select`,
  options = `\Drupal::config('views.settings')->get('field_rewrite_elements')` plus a
  " - Select -" empty option). `blockSubmit()` saves both to `$this->configuration`.
- `build()` calls `simplexml_load_file('https://www.drupal.org/planet/rss.xml')`, loops
  `$xml->channel->item`, stops after `number_of_feeds_to_display` items, and for each builds a
  link with `Link::fromTextAndUrl($title, Url::fromUri($link))->toString()`. The generated link
  is wrapped in `<h4>…</h4>` by default, or in `<tag>…</tag>` when `html_tag_to_render` is set.
- Appends a `#type => more_link` to `https://www.drupal.org/planet`, and sets
  `$build['#cache']['max-age'] = 0` (no caching → refetched on every uncached render).
- Only the item **title** and **link** are used; the item description/body is not rendered.

## Install / place

```bash
composer require drupal/drupal_planet_feeds_block
drush en drupal_planet_feeds_block -y   # enables core views too
```

No settings page. Place the block at **Structure → Block layout**
(`/admin/structure/block`), filter by *Planet Drupal*, and set the item count and wrapper tag on
the placement form. See [blocks/planet-block.md](blocks/planet-block.md).
