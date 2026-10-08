<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Share block — `simple_social_share_block`

`src/Plugin/Block/SimpleSocialShareBlock.php`. One block plugin, no separate settings page — all
options live on the block instance form.

## Install & place

1. `drush en simple_social_share -y` (deps: core `block`, `config`).
2. Structure → Block layout → place **"Simple Social Share Block"** (category *Social*) in a region.
   Use core block visibility (path/content type/role/language) to scope where it shows.
3. In the block form, tick the platforms to display and toggle **Show Copy Link Button**.

## Configuration (per block instance)

Set in `blockForm()`, saved in `blockSubmit()`, read via `getConfiguration()`:

- `platforms-<key>` — one boolean per platform key: `facebook`, `twitter`, `linkedin`, `whatsapp`,
  `telegram`, `pinterest`, `reddit`, `tumblr`, `email` (constant `AVAILABLE_PLATFORMS`). A platform's
  button renders only when its flag is TRUE.
- `show_copy_link` — boolean, defaults TRUE (`$config['show_copy_link'] ?? TRUE`). Shows the Copy Link
  button.

There is **no `defaultConfiguration()`** override and **no config schema file**; values are stored in
the block's own config entity under core's generic block settings schema.

## Build logic (`build()`)

1. Resolve the shared URL from the current route:
   - `entity.node.canonical` → `Url::fromRoute('simple_social_share.node_short_link', ['node' => id])`
     absolute (a `/n/{id}` short link).
   - `entity.taxonomy_term.canonical` → `simple_social_share.taxonomy_term_short_link` (`/t/{id}`).
   - anything else → `Url::fromRoute('<current>')` absolute (the current page URL).
2. Resolve the page title via `title_resolver->getTitle(request, routeObject)`, cast to string.
3. For each enabled platform, build a share URL with every dynamic part `urlencode()`d — e.g.
   Facebook `sharer.php?u=<url>`, Twitter `intent/tweet?url=<url>&text=<title>`, WhatsApp `wa.me/?text=<url>`,
   Email `mailto:?subject=<title>&body=<url>`, and analogous for LinkedIn, Telegram, Pinterest, Reddit,
   Tumblr.
4. Returns `#theme => 'simple_social_share_block'` with `#share_urls`, `#current_url`, `#show_copy_link`,
   and `#attached` library `simple_social_share/social_share`.

Note: `build()` has no explicit cache metadata; output varies per route via the default block/route
cache contexts.

## Template & assets

- `templates/simple-social-share-block.html.twig`: loops `share_urls` → `<a>` per platform that opens the
  share URL in an 800×400 popup (`window.open`, `rel="noopener"`), including
  `@simple_social_share/templates/icons/<platform>.svg.twig` (`ignore missing`). When `show_copy_link`,
  renders a `<button class="copy-link" data-url="{{ current_url }}">`.
- `js/social-share.js`: `Drupal.behaviors.simpleSocialShare` uses `once('simple-social-share', '.copy-link')`;
  on click copies `dataset.url` to the clipboard (temp input + `document.execCommand('copy')`), adds a
  `copied` class for 2s, and calls `Drupal.announce('Link copied to clipboard')`.
- `css/social-share.css`: button styling. Override icons by overriding the per-platform SVG templates;
  override markup by overriding the block template in a theme.

## Extending / theming

- Add/replace an icon: override `templates/icons/<platform>.svg.twig`.
- Change layout: override `simple-social-share-block.html.twig`.
- Restyle: override/extend `css/social-share.css` or the `simple_social_share/social_share` library.
- The platform list is a hard-coded PHP constant; adding a new network requires patching
  `AVAILABLE_PLATFORMS` and the `build()` switch.
