<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Gutenberg Bootstrap Blocks (gutenberg_bs_blocks) — agent index

Registers three **static** Gutenberg blocks — `bootstrap/container`, `bootstrap/row`, `bootstrap/column` —
that emit Bootstrap grid markup (`container`/`container-fluid`, `row`, `col*`). The blocks are defined
entirely in **client-side JavaScript** (`wp.blocks.registerBlockType`) shipped as compiled bundles under
`build/js/`; each block's `save` function produces the final `<div class="…"><InnerBlocks.Content/></div>`
markup **in the browser**, which Gutenberg stores in the node body. There is **no PHP render/dynamic-block
callback** — the module renders nothing server-side. A `bootstrap` block category is registered at runtime
(`libraries/js/category.es6.js`) so the blocks group together in the inserter.

The only PHP in the module is `gutenberg_bs_blocks_help()` (`hook_help`). Everything else is asset wiring:
`gutenberg_bs_blocks.gutenberg.yml` tells the **Gutenberg** module which libraries to inject into the editor
(`libraries-edit`) and the front-end node view (`libraries-view`); `gutenberg_bs_blocks.libraries.yml` defines
those libraries against the built JS/CSS. Requires the site's front theme to already provide Bootstrap ≥ 4.5.

- Depends on: `gutenberg:gutenberg` (the Gutenberg editor module). No other module deps.
- Core: `^8 || ^9 || ^10 || ^11`. Package: `Gutenberg Blocks`. Version `1.0.0-rc3` (release candidate).
- **No** settings page / `configure` route, **no** permissions, **no** services, **no** routes (except the
  auto `help.page.*` route), **no** drush, **no** config schema, **no** Drupal plugin types.
- Ships source ES6+SCSS under `libraries/` compiled by webpack/babel into `build/js/*.js` + `build/css/*.css`.

## What you'd do → where

- **Understand / change the three blocks (machine names, attributes, saved classes, variations, transforms)** →
  [plugins/blocks.md](plugins/blocks.md)
- **Understand how the assets reach the editor & front-end, or add a new block / rebuild the bundles** →
  [api/integration.md](api/integration.md)

## Key facts (real machine names)

- Block types (registered client-side): `bootstrap/container`, `bootstrap/row`, `bootstrap/column`
  (`column` declares `parent: ["bootstrap/row"]`). All are **static** blocks (`save` returns markup).
- Block category: slug `bootstrap`, title "Bootstrap" (registered via `wp.data.dispatch("core/blocks").setCategories`).
- Container attributes: `align` (string, default `"wide"`). Row attributes: `horizontalAlignment`,
  `verticalAlignment` (strings). Column attributes: `alignment`, `size{Xs,Sm,Md,Lg,Xl}`,
  `order{Xs…Xl}`, `offset{Xs…Xl}` (numbers). All blocks set `supports.html = false`, `supports.className = false`.
- Row variations: `two-columns-equal` (50/50, default), `two-columns-one-third-two-thirds` (30/70),
  `two-columns-two-thirds-one-third` (70/30), `three-columns-equal` (33/33/33), `three-columns-wider-center` (25/50/25).
- Container transforms: from `core/group`, and multi-block "group" conversion into `bootstrap/container`.
- Libraries (`gutenberg_bs_blocks.libraries.yml`): `bootstrap`, `block-edit`, `block-view`,
  `container-block-edit`, `container-block-view`, `row-block-edit`, `column-block-edit`.
  Editor libs depend on `gutenberg/edit-node`.
- Gutenberg wiring (`gutenberg_bs_blocks.gutenberg.yml`): `libraries-edit` (bootstrap + block-edit +
  container/row/column-block-edit) on node edit; `libraries-view` (block-view + container-block-view) on node view.
- Hook: `gutenberg_bs_blocks_help()` — `hook_help`, route `help.page.gutenberg_bs_blocks`. No other hooks.
- Build inputs: `libraries/js/*.es6.js`, `libraries/sass/*.scss` → `webpack.config.js` (`.babelrc`) → `build/`.
