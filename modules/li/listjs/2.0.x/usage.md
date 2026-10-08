<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
List.js integrates the [List.js](https://listjs.com) library to add instant client-side search, sort and filter to an already-rendered HTML list. The module ships the `listjs` theme hook (build a filterable/sortable list from a render array) plus a `Drupal.behaviors.listjs` behavior that reads `drupalSettings.listJs.valueNames`; the `listjs_views` submodule adds a **Listjs** Views display style. The List.js library itself is an external dependency you install locally into `/libraries/listjs`.

---

The whole module is a thin bridge between Drupal render output and the vanilla-JS List.js library, and the mechanism is worth understanding because it dictates when the module works. Two entry points reach the same JS behavior. The `#theme => 'listjs'` render element (see `template_preprocess_listjs()` and `templates/listjs.html.twig`) takes `#items`, an `#list_id`, a search `#placeholder_text`, and `#value_names` — an associative array keyed by the CSS class present on each item's value, each mapping to `sort` (bool) and optional `sort_text`. The submodule's Views style does the same from a view: on the style-options form you tick which fields are **Filterable** and **Sortable** and give each a sort-button label, and `template_preprocess_views_view_listjs()` turns each chosen field into a value name using the field's element class (falling back to `views-field-<id>`). Either path attaches the value-name map to `drupalSettings.listJs.valueNames[list_id]` and the `listjs/listjs-init` library; on the page, `Drupal.behaviors.listjs` iterates each list id, calls `new List(listId, { valueNames: Object.keys(value) })` once (guarded by `core/once`), and wires List.js events to jQuery document triggers (`listJsUpdated`, `listJsSearchStart`, `listJsSearchComplete`, `listJsFilterStart/Complete`, `listJsSortStart/Complete`). The rendered markup is the List.js contract: a container with the search `<input class="search">`, sort buttons `<input class="sort" data-sort="…">`, and a `<ul class="list">` of items whose value cells carry the value-name classes — List.js reads those class-matched cells' text to search/sort. Because config values reach the browser as JSON-encoded `drupalSettings` and all markup is Twig-autoescaped, there is no injection surface here. The design limit is the important thing: List.js searches only the DOM, so this works only when the **entire** set is on the page — anything paged, lazy-loaded or truncated is invisible to the filter, and a search box that silently searches page one of nine is worse than no search box. So send the whole list or use a server-side filter; that in turn bounds the size, since a page carrying thousands of rows is heavy regardless of how fast the filtering is. Two accessibility notes: the filter input changes results with no live-region announcement, so screen-reader users get no feedback unless you add one; and filtered-out rows remain in the DOM (List.js hides them), so browser find-in-page and assistive tech may still reach them. Version **2.0.1**, core `^9 || ^10 || ^11`, GPL-2.0-or-later; the library is loaded locally (no CDN in the shipped library definition) and `hook_requirements()` warns at runtime if `/libraries/listjs` is missing.

---

- Add instant, no-reload search to a staff or team directory that fits on one page.
- Filter a document or downloads list as the visitor types.
- Turn a small View into a client-side searchable/sortable list with the `listjs_views` display style.
- Sort a table of locations or publications client-side by a chosen column.
- Search a glossary or FAQ list instantly in the browser.
- Build a filterable list from a controller with `#theme => 'listjs'` and a `#value_names` map.
- Provide the List.js library to your own custom module or theme (the module registers it as `listjs/listjs`).
- Add a quick "filter above the list" box to a landing page's curated set.
- Sort a comparison or feature table without a round trip.
- Search a small product or resource catalogue held entirely on the page.
- Give editors a Views style where they pick which fields are searchable and which get sort buttons.
- Hook into `listJsSearchComplete` / `listJsUpdated` to update a result count or empty-state message.
- Replace an exposed Views filter for a small dataset, avoiding a request per keystroke.
- Add client-side sorting toggles (ascending/descending) to an existing rendered list.
- Filter a member/partner listing on a page that already loads the full set.
- Add a search input to a curated block of links or cards rendered via the theme hook.
- Sort a list of events or sessions by title client-side.
- Search a table of API endpoints or settings shown in full on a docs page.
- Provide instant filtering for a taxonomy-term listing that is small and fully rendered.
- Wire custom JS to List.js lifecycle events without re-instantiating List.js yourself.
