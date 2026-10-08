<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Anti-Duplicates warns node authors about likely duplicate content by live-searching existing node titles as they type in the title field, and can optionally block form submission until the author confirms the content is unique.

---

Anti-Duplicates hooks into every node add/edit form (`hook_form_node_form_alter`) and attaches an AJAX callback to the title field that fires on configurable triggers — a debounced keyup, a blur, or both. As the author types, it runs an entity query against existing nodes of the same content type and lists matching titles (as links) up to a configurable result limit, plus a total-count message, so the author can spot content they may be re-creating. Matching uses one of three configurable search modes: a wildcard sequence of the keywords, the exact title as a substring, or an OR of any single word from the title. The module optionally disables automatic form submission (via `drupalSettings` + its JS library) until the author clicks a "Not a duplicate" link, and the results panel can be placed in the right sidebar or directly under the title. It is a soft, author-facing content-integrity aid — it never hard-enforces uniqueness at save time and adds no database constraint.

Configuration lives at `admin/config/anti-duplicates` (route `anti_duplicates.admin_page`, permission `administer anti_duplicates`), organized into three groups — Search, Behavior, and Display: choose which content types are checked, the title-matching mode, the maximum number of results, the search triggers and debounce delay, whether to require a "Not a duplicate" confirmation before saving, the panel placement, the introduction message, and the result-count message. Both messages are text-format fields and are translatable via the Translate tab (Configuration Translation). The only dependency is core `node`.

---

- Warn content authors when a node title matches existing content on your site.
- Live-search existing titles as the author types (debounced-keyup AJAX).
- Trigger the search when the author leaves the title field (blur), or on both blur and keyup.
- Tune how long to wait after the last keystroke before searching (debounce delay, in ms).
- Reduce accidental duplicate pages from double-submits or re-entry.
- List matching nodes as clickable links up to a configurable result limit (0 = list all).
- Show a total-count message (with a `@count` placeholder) below the results.
- Require authors to click "Not a duplicate" before the form can submit.
- Restrict duplicate checking to specific content types (e.g. only article + page).
- Check all content types by leaving every checkbox unchecked (no type restriction).
- Match on a wildcard sequence of the title keywords (search type 0).
- Match on the exact title as a substring (search type 1).
- Match on any single word from the title (search type 2, the default).
- Place the results panel in the right sidebar of the node form.
- Place the results panel directly under the title field instead.
- Only show the results panel when one or more duplicates are found.
- Customize the introduction message shown above the results (text-format field).
- Translate the introduction and count messages via the Configuration Translation Translate tab.
- Exclude the node currently being edited from its own duplicate results.
- Help editorial teams avoid publishing near-identical listings or articles.
- Catch re-imported or re-entered content during manual data entry.
- Nudge authors toward reusing an existing page rather than creating a new one.
- Provide a lightweight, save-time-free uniqueness hint (no DB constraint added).
- Gate the settings form behind a dedicated `administer anti_duplicates` permission.
- Integrate with node forms only, leaving other entity types untouched.
