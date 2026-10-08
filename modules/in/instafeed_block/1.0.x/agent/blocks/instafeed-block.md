<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Instafeed block plugin

**Class:** `Drupal\instafeed_block\Plugin\Block\InstafeedBlock`
**Plugin id:** `instafeed_block` · **Admin label:** "Instafeed Block"
**Source:** `src/Plugin/Block/InstafeedBlock.php`

A standard `BlockBase` plugin (implements `ContainerFactoryPluginInterface`, injects the `state`
service). Place it like any block, in any region. The README warns to use only **one Instafeed
block per page** — the JS targets a single hard-coded element id (`instafeed`), so multiple blocks
collide.

## Block-instance settings (`blockForm`/`blockSubmit`)

Stored in the block's own configuration (not module config), keys:

- `limit` — number input, 1–50, default 6. Posts to display.
- `filters` — multiselect of `image` / `video` / `album`. If none selected, all types show.
  Note: for `album` posts only the first media item is rendered.
- `template` — textarea, single-line HTML markup for each post, interpolated by instafeed.js.
  Default: `<div class="post"><a href="{{link}}" target="_blank"><img src="{{image}}" /><div class="caption">{{caption}}</div></a></div>`.
  Empty the field and save to restore the default. Placeholders come from instafeed.js
  (`{{link}}`, `{{image}}`, `{{caption}}`, `{{model.media_url}}`, `{{model.thumbnail_url}}`, …).
  Video example (from README):
  `<div class="instafeed video"><video poster="{{model.thumbnail_url}}" controls playsinline preload=auto><source src="{{model.media_url}}" type="video/mp4"></video></div>`
- `layout` — number 1–4, posts per row. Adds a grid CSS file
  (`instafeed_block/instafeed-block-layout-{2|3|4}`); hidden when CSS is disabled.
- `disable_css` — checkbox. When on, the module's base CSS and layout CSS are omitted (only the
  library + init JS are attached), so you supply your own styling.
- `classes` — extra CSS classes appended to the `#instafeed` div.

There are `validateLimit`/`validateLayout` helper methods in the class, but the form elements do
not wire them as `#element_validate`; range is enforced only by the `#min`/`#max` HTML attributes.

## Render path (`build()`)

1. Reads the access token from State: `instafeed_block.access_token`.
2. Chooses libraries: always `instafeed_block/instafeed.js` (external) + `instafeed_block/instafeed-block-js`;
   adds base + layout CSS unless `disable_css`.
3. Emits markup `<div id="instafeed" [class="…classes"]></div>`.
4. `#attached['drupalSettings']['instafeed_block']` = `{ accessToken, template, limit, filters }`.

`js/instafeed-block.js` (`Drupal.behaviors.instafeedBlock`) guards against double-init via a
`data-instafeed-initialized` flag, then constructs `new Instafeed({ limit: limit+20, template,
accessToken, filter: <type filter>, target: 'instafeed' })` and calls `feed.run()`. It fetches
`limit + 20` posts and client-side-filters down to `limit` because instafeed.js filters after the
API fetch. **All fetching and rendering happens in the visitor's browser.**

## Caching / dynamics

The block has no cache metadata beyond default block caching; the token and settings are baked into
the rendered `drupalSettings`. Saving the global token form calls `drupal_flush_all_caches()` to
propagate a new token.
