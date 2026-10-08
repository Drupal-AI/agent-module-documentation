<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Social Share (simple_social_share) — agent index

A configurable **block** that renders social-media share buttons + an optional Copy Link button for
the current page. Nine platforms (Facebook, Twitter/X, LinkedIn, WhatsApp, Telegram, Pinterest,
Reddit, Tumblr, Email). Core `^10 | ^11`, license GPL-2.0-or-later, version 1.0.6, package `Custom`.

- **Dependencies:** core `block`, `config` only. No composer requirements. No permissions, no config
  schema, no Drush, no services.
- **Provides:** one block plugin, two redirect routes, one theme hook + template, an SVG icon set,
  one CSS/JS asset library.

## Solution docs

- **The share block — config form, build logic, template, JS, styling** →
  [blocks/share-block.md](blocks/share-block.md)
- **The short-link redirect routes (`/n/{node}`, `/t/{taxonomy_term}`)** →
  [routes/short-links.md](routes/short-links.md)

## What it actually is (from source)

- **Block:** `SimpleSocialShareBlock` (id `simple_social_share_block`, admin label *"Simple Social
  Share Block"*, category *"Social"*) in `src/Plugin/Block/SimpleSocialShareBlock.php`, extends
  `BlockBase`, implements `ContainerFactoryPluginInterface`. Injects `current_route_match`,
  `title_resolver`, `request_stack`. Per-instance config: `platforms-<key>` booleans + `show_copy_link`.
- **Routes** (`simple_social_share.routing.yml`): `simple_social_share.node_short_link` `/n/{node}` and
  `simple_social_share.taxonomy_term_short_link` `/t/{taxonomy_term}`, both `_permission: access content`,
  handled by `ShortLinkController::redirectNode` / `redirectTaxonomyTerm` (302 → entity canonical).
- **Theme:** `simple_social_share_theme()` in `.module` registers `simple_social_share_block`
  (variables `share_urls`, `current_url`, `show_copy_link`) → `templates/simple-social-share-block.html.twig`.
- **Icons:** `templates/icons/<platform>.svg.twig` (facebook, twitter, linkedin, whatsapp, telegram,
  pinterest, reddit, tumblr, email), inline-included by the block template.
- **Library:** `simple_social_share/social_share` (`simple_social_share.libraries.yml`) → `css/social-share.css`,
  `js/social-share.js`; depends on `core/drupal`, `core/once`.
- No install file, no config/install, no config/schema, no permissions file.
