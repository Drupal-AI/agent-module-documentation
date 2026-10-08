<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Instafeed block plugin

**Class:** `Drupal\instafeed_block\Plugin\Block\InstafeedBlock` (`src/Plugin/Block/…`)
**Plugin:** `@Block(id = "instafeed_block", admin_label = "Instafeed Block")`
Implements `ContainerFactoryPluginInterface`; injects only the core `state` service.

Place it through the Block Layout UI (or Layout Builder) like any block. There is no dedicated route
or permission — visibility/placement is governed by core block config.

## Block-instance settings (`blockForm` / `blockSubmit`)

Stored in the block's own configuration (not global config):

- `limit` — number field, 1–50, default 6. Number of posts to display. (JS fetches `limit + 20`
  then filters client-side, because instafeed.js filters after fetching.)
- `filters` — multi-select of `image` / `video` / `album`. Empty = all media types. Note: an
  `album` shows only its first image.
- `template` — textarea, single-line raw HTML markup interpolated by instafeed.js. Default:
  `<div class="post"><a href="{{link}}" target="_blank"><img src="{{image}}" /><div class="caption">{{caption}}</div></a></div>`.
  Emptying the field restores the default on save.
- `layout` — number 1–4, default 3. Posts per row; values 2/3/4 load a matching grid CSS file.
  Hidden when "Disable module CSS" is checked.
- `disable_css` — checkbox. When set, the block attaches no module CSS (base or layout).
- `classes` — textfield. Space-separated CSS classes added to the feed container div.

Two validation callbacks exist in the class (`validateLimit`, `validateLayout`) but the form uses
the number field `#min`/`#max` for bounds; the callbacks are not wired as `#element_validate`.

## Render path (`build`)

1. Reads the token from State: `instafeed_block.access_token` (empty string default).
2. Reads the six block settings (with defaults).
3. Chooses libraries: always `instafeed_block/instafeed.js` + `instafeed_block/instafeed-block-js`;
   adds `instafeed_block/instafeed-block-css` and (for layout 2/3/4) the matching
   `instafeed_block/instafeed-block-layout-N` unless `disable_css` is set.
4. Emits `#markup` = `<div id="instafeed"></div>` (adding `class="…"` from `classes` if set).
5. Attaches `drupalSettings.instafeed_block` = `{ accessToken, template, limit, filters }`.

`js/instafeed-block.js` (`Drupal.behaviors.instafeedBlock`) then constructs
`new Instafeed({ limit: limit+20, template, accessToken, filter: <type filter fn>, target: 'instafeed' })`
and calls `feed.run()`. All Instagram Graph API calls and DOM rendering happen **in the browser**;
Drupal does not fetch or cache feed content for display. A `dataset.instafeedInitialized` flag guards
against double init (so keep to one Instafeed block per page, as the block's own help text warns).
