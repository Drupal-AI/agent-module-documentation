<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Table of contents block

## `toc` block — `TocBlock` (`src/Plugin/Block/TocBlock.php`)
A client-side in-page table of contents. Placed via core Block UI. `defaultConfiguration()` keys: `max_heading_level`, `wrapper`, `required_class`, `title_attribute`, `offset`, `list_class`, `link_class`.

`blockForm()` exposes:
- `max_heading_level` (number) — deepest heading level shown; minimum level is fixed at 2 (`startLevel: 2` in JS).
- `wrapper` (textfield) — jQuery selector of the region to scan for headings.
- `only_allowed` (checkbox) — when set, only headings carrying a `data-toc-show` attribute are included.
- `list_class` / `link_class` (textfields) — CSS classes for the generated `<ul>` and links.

`blockSubmit()` persists those (plus `title_attribute`). `build()` configures the injected `TocBuilder` fluently and returns its render array.

## `TocBuilder` (`src/TocBuilder.php`, service `navigation_blocks.toc_builder`)
Plain fluent builder (no injected dependencies). Setters: `setMaxHeadingLevel()`, `setWrapper()`, `setOnlyAllowed(bool)`, `setListClass()`, `setLinkClass()`. `build()` returns a single `nav` `html_tag` element with classes `toc-navigation scrollspy-menu js-toc`, attaches library `navigation_blocks/toc`, and passes the settings under `drupalSettings.navigation_blocks.toc` (`max_heading_level`, `wrapper`, `only_allowed`, `list_class`, `link_class`).

## JavaScript (`navigation_blocks.libraries.yml` → `toc`)
- `js/plugins/bootstrap-toc.js` — vendored TOC generator (exposes global `Toc`).
- `js/behaviors/navigation_blocks.toc.behavior.js` — behavior `tocCrawlMenuTitles`; on each `.js-toc` element reads `drupalSettings.navigation_blocks.toc` and calls `Toc.init({$nav, $scope, maxLevel, startLevel:2, onlyAllowed, listClass, linkClass})`. Deps: `core/jquery`, `core/once`, `core/drupalSettings`.

The list is built entirely in the browser from the rendered page's headings; nothing is stored server-side.

## CKEditor 4 button — `HeadingTocControl` (`src/Plugin/CKEditorPlugin/HeadingTocControl.php`)
`@CKEditorPlugin(id = "headingtoccontrol")` adding a "Table of Contents Control" toolbar button (`js/plugins/headingtoccontrol/plugin.js` + dialog) so editors can tag headings (e.g. with `data-toc-show`). Extends `Drupal\ckeditor\CKEditorPluginBase` — this is the **CKEditor 4** plugin API, which is removed from Drupal core 10+; on a default D10/D11 site (no legacy `ckeditor` module) this button is inert while the block itself still works.

## Operating notes
- Set `wrapper` to the content region selector (e.g. the article body wrapper) so the TOC does not pick up site-chrome headings.
- Values (`list_class`, `link_class`, `wrapper`) are set by block administrators and consumed by the JS as selectors/class names.
