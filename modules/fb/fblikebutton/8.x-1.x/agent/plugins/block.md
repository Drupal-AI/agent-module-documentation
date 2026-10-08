<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FblikebuttonBlock — Like box block plugin

File: `src/Plugin/Block/FblikebuttonBlock.php`. `@Block(id = "fblikebutton_block", admin_label = "Facebook
Like Button")`, `extends BlockBase implements ContainerFactoryPluginInterface`. Injects `path.matcher`
(`PathMatcherInterface`) via `create()`/constructor.

Unlike the per-node button (which is driven by `fblikebutton.settings`), the block keeps its **own** config
per instance — a target URL plus a copy of the appearance options — so you can place several Like boxes with
different targets and styling.

## Configuration

`defaultConfiguration()` returns: `block_url` = global `$base_url`, `layout` = `standard`, `size` = `small`,
`action` = `like`, `colorscheme` = `light`, `language` = `en_US`, `width` = `''`.

`blockForm()` builds two `details` groups:

- **Button settings** → `block_url` textfield. Accepts an absolute URL (homepage, a Facebook page, any
  external URL) or the literal `<current>` to like the page currently being viewed.
- **Button appearance** → `layout` (standard/box_count/button_count/button), `size` (small/large), `action`
  (like/recommend), `colorscheme` (light/dark), `language` (Facebook locale textfield), `width` (textfield).

`blockSubmit()` stores `$values['settings']['block_url']` and each `$values['appearance'][…]` into
`$this->configuration`.

## build()

Produces a `#theme => 'fblikebutton'` render array, passing `#layout`, `#size`, `#action`, `#colorscheme`,
`#language`, `#width` from configuration. URL resolution:

- If `block_url !== '<current>'` → `#url = block_url` (the fixed configured URL).
- Else (`<current>`) → sets `#cache['max-age'] = 0` so the block is not cached, and resolves the URL:
  - if `pathMatcher->isFrontPage()` → `#url = $base_url` (avoids Facebook liking `/node` instead of the
    site root);
  - otherwise `#url = Url::fromRoute('<current>', [], ['absolute' => TRUE])->toString()`.

All URL values are server-generated or admin-entered configuration; none is read from request query/body.

## Placement

Place at `/admin/structure/block` (Block layout) in any region; set visibility as usual. The block renders
through the same template as the per-node button — see [../behavior/attach.md](../behavior/attach.md).
