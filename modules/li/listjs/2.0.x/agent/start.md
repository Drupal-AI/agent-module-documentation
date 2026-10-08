<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# List.js (listjs) — agent index

Integrates the **List.js** vanilla-JS library for instant **client-side** search, sort and filter on
an already-rendered list. Version **2.0.1**, core `^9 || ^10 || ^11`, GPL-2.0-or-later, package
*Search*. No admin config route, no permissions, no Drush.

## What it actually provides

- **A `listjs` theme hook** (`listjs.module`, `templates/listjs.html.twig`) — render a filterable /
  sortable list from `#items`, `#list_id`, `#placeholder_text`, `#value_names`. See
  [`agent/api/theme-hook.md`](api/theme-hook.md).
- **A `Drupal.behaviors.listjs` behavior** (`js/listjs-init.js`) that reads
  `drupalSettings.listJs.valueNames`, calls `new List(listId, {valueNames})` once per list, and
  re-broadcasts List.js events as jQuery document triggers. See [`agent/api/theme-hook.md`](api/theme-hook.md).
- **The `listjs/listjs` library** — the List.js JS itself, so custom modules/themes can depend on it.
- **`listjs_views` submodule** — a **Listjs** Views display style where you pick per-field
  *Filterable* / *Sortable* and a sort-button label. See [`agent/views/style.md`](views/style.md).

## Mechanism in one line

Both entry points attach a value-name map (class → `{sort, sort_text}`) to
`drupalSettings.listJs.valueNames[list_id]` plus the `listjs/listjs-init` library; the behavior
instantiates List.js against the container `#list_id`, which reads/filters/sorts the text of DOM
cells matching those value-name classes. Search input is `.search`, sort buttons are
`.sort[data-sort=…]`, the item container is `<ul class="list">`.

## Install note

The List.js library is an **external dependency loaded locally** from `/libraries/listjs/dist/list.min.js`
(no CDN in the shipped definition). Install via `composer require bower-asset/listjs` or drop it in the
`libraries/` directory. `hook_requirements()` shows a runtime warning if it is missing.

## The design limit (get this right)

Client-side filtering searches the **DOM**, so it works **only when the entire set is on the page**.
Anything paged, lazy-loaded or truncated is invisible to the filter — a search box that silently
searches page one of nine is worse than no search box. **Send the whole list, or use a server-side
filter.** That bounds the size (a page of thousands of rows is heavy however fast the filtering is).

Accessibility: the filter input has **no live-region announcement** of result counts (add one), and
**filtered-out rows stay in the DOM** (List.js hides them), so find-in-page / assistive tech may
still reach them.

## Security

No routes, permissions, forms taking untrusted input, or SQL. Config values reach JS as
JSON-encoded `drupalSettings` and all markup is Twig-autoescaped — no injection surface. Clean.
