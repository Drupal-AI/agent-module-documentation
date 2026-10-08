<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming, templates, libraries, and the block base

## Theme hooks (`toc_api_theme()`)

Six hooks, each with a Twig template in `templates/` and a `template_preprocess_*` in
`toc_api.module`:

| Theme hook | Template | Renders |
|---|---|---|
| `toc_tree` | `toc-tree.html.twig` | Nested `<ul>` outline (desktop) |
| `toc_menu` | `toc-menu.html.twig` | `<select>` jump menu (mobile) |
| `toc_responsive` | `toc-responsive.html.twig` | Both: `toc_tree` (desktop) + `toc_menu` (mobile) |
| `toc_default` | `toc-default.html.twig` | Wraps `toc_tree` only |
| `toc_header` | `toc-header.html.twig` | A single rewritten heading (number + anchor) |
| `toc_back_to_top` | `toc-back-to-top.html.twig` | A "Back to top" (`#top`) link |

`TocBuilder::buildToc()` picks the hook by name: `#theme => 'toc_' . $options['template']`.
So a `toc_type` whose `template` option is `menu` renders through `toc_menu`. Variables all
receive the `toc` object; preprocessors pull `getTree()`, `getIndex()`, and `getOptions()`
off it and attach the relevant library.

## Libraries (`toc_api.libraries.yml`)

- `toc_api/toc` — base component CSS.
- `toc_api/toc.tree` — tree CSS (auto-attached by `toc_tree`).
- `toc_api/toc.menu` — menu CSS + `js/toc.menu.js` (jump-menu `onchange` navigation; auto-attached by `toc_menu`).
- `toc_api/toc.responsive` — responsive CSS (desktop tree / mobile menu breakpoint at 768px).
- `toc_api/toc_type` — `js/toc_type.js`, attached only to the toc_type **admin form** (show/hide per-header numbering).

Override any template by copying it into your theme; override CSS/JS with a library override
in your theme's `*.info.yml`.

## `TocBlockBase` — expose a TOC as a block

`Drupal\toc_api\Plugin\Block\TocBlockBase` is an **abstract** block. It is not a plugin type
you register against — it is a base class a downstream module extends to publish *its own*
current-request TOC:

- `getCurrentTocId()` — defaults to the block's plugin id; override to match the id your
  module passed to `TocManager::create()`.
- `getCurrentToc()` — `tocManager->getToc(getCurrentTocId())`.
- `build()` — renders `#theme => 'toc_' . $options['template']` with the TOC title.
- `blockAccess()` — forbidden unless the TOC exists **and** `isVisible()` **and** `isBlock()`
  (so set the toc_type `block` option `true`).
- Cache: context `route`; tag `node:<id>` for the current node/revision/preview.

Because the base only reads an already-created instance from the manager, your module must
create the TOC earlier in the request (e.g. in a `hook_node_view()` or a view/preprocess hook)
using the **same id**.
