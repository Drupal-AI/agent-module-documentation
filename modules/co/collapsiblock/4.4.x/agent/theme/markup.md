# Markup, library and theme contract

## Library `collapsiblock/core`

Declared in `collapsiblock.libraries.yml`; attached on every page by
`collapsiblock_page_attachments_alter()`. Assets: `theme/dist/collapsiblock.css` and
`theme/dist/collapsiblock.js` (loaded as an ES `module`). Dependencies: `core/drupal`,
`core/drupalSettings`, `js_cookie/js-cookie`, `core/once`. The bundled slide animation uses the
`slide-element` library (no jQuery).

## How the wrapper markup is produced

For a block whose effective action is not `1`, `collapsiblock_block_view_alter()` (or the Layout
Builder event subscriber) sets `$build['#collapsiblock']['prefix'|'suffix']`:

```
<div id="collapsiblock-wrapper-<block-id>" class="collapsiblockTitle" data-collapsiblock-action="<action>"> … </div>
```

`collapsiblock_preprocess_block()` then moves that prefix/suffix into the block template's
`title_prefix` / `title_suffix` render arrays, so the wrapper surrounds the block title.

### Theme contract (troubleshooting)

The block template **must** render `{{ title_prefix }}` and `{{ title_suffix }}` around the
clickable (non-collapsing) title region. Everything after the `.collapsiblockTitle` element (its
next sibling, skipping contextual-link wrappers) is treated as the collapsible body. If a theme
omits `title_prefix`/`title_suffix`, or the block has no sibling body element, collapsing will not
work. If the title element has no visible children (or only `.visually-hidden` ones), the JS skips
it.

## JS behavior (`theme/src/js/collapsiblock.js`)

`Drupal.behaviors.collapsiblock`, guarded by `once('collapsiblock', …)`, reads
`data-collapsiblock-action` on each `.collapsiblockTitle`:

- Wraps the title text in a `<button aria-controls="collapse-<id>-content">` and maintains
  `aria-expanded`. The body element gets class `collapsiblockContent` and id `collapse-<id>-content`.
- Toggle adds/removes `collapsiblockTitleCollapsed` / `collapsiblockContentCollapsed` and slides with
  `slide-element` `up()`/`down()` at `slide_speed` ms.
- Actions `2` and `3` persist per-block state in a cookie (`useCookie`); `4` (always collapsed) and
  `5` (always expanded) do not persist.

### Cookie

Single cookie named `collapsiblock`, a JSON map of `{ <block-id>: 0|1 }` (`0` = collapsed,
`1` = expanded), path = site base URL. Expiry from `cookie_lifetime` (days); when `cookie_lifetime`
is falsy the cookie is a session cookie, and a negative value means no cookie is written at all.

### Initial-state escape hatches

A block that would collapse on load stays open when:
- Its body contains active-trail links (`a.is-active:not(.pager__link)`) **and** global
  `active_pages` is FALSE — keeps menu blocks with the current page open.
- Its body (or a descendant) carries the class `collapsiblock-force-open` — add this to content that
  must stay visible (e.g. a form just updated via AJAX).

### Dark-mode color switcher

When `switcher_enabled` is on and `switcher_class` is set, the button gains
`collapsiblock-color-switcher` if that class is present on `<html>` or `<body>` (used to recolor the
collapse arrow for dark themes). CSS in `theme/dist/collapsiblock.css` supplies the arrow icons
(`theme/images/*.svg`).
