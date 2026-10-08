<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views collapsible lists adds a Views style plugin, `collapsible_list`, that renders a view's rows as an expandable/collapsible `<ul>` — a per-row disclosure list where you pick which fields stay hidden until the row is toggled open.

---

The style extends core's HTML-list style (`HtmlList`), so a view configured with it behaves like an unordered list of rows but gains a client-side show/hide layer. In the style settings you tick a set of **Collapsible fields**; every other field stays visible as the row's always-shown "header", and the ticked fields are the detail that opens on click. The mechanism is entirely jQuery: `template_preprocess_views_view_collapsible_list()` attaches the `views_collapsible_list/collapse` library and passes the chosen fields to `drupalSettings` as `.views-field-<name>` selectors; the behavior then adds a `js-collapsible` class to those elements and `.hide()`s them on load, toggling them with jQuery `.toggle('slow')` when a per-row `<span class="collapse-expand-toggle">` is clicked. Each rendered group also gets a pair of **Collapse All / Expand All** buttons, scoped by a randomly-generated `section_class` so multiple grouped sections toggle independently. Because it is a plain style plugin it composes with everything else Views offers — filters, sorts, pagers, contextual arguments, access, and Views' own grouping (the group value renders into an `<h3>` heading). Two caveats worth stating plainly: the disclosure is **not** native `<details>`/`<summary>`, and the trigger is a non-focusable `<span>` with no `aria-expanded`, so keyboard and screen-reader operation are not provided out of the box; and hidden rows are hidden with CSS/JS only — the content is fully rendered in the DOM, queried, and findable by browser in-page search. Version **8.x-1.6**, core `^9 || ^10 || ^11`, depends on core `views`.

---

- Build an FAQ page from a view where each answer is hidden until the question is clicked.
- Turn any fields-based view into an accordion without a custom template.
- Show a short row header with detail fields that expand on demand.
- Collapse long body/description fields in a content listing to shorten the page.
- Present a policy or terms document section-by-section from taxonomy or nodes.
- Build a knowledge-base or documentation index with expandable entries.
- Group release notes by version (via Views grouping) with per-section Expand/Collapse All.
- Show staff or team biographies with a hidden longer bio.
- Present product specifications as a collapsible spec sheet.
- Reduce scrolling on mobile by hiding secondary fields behind a toggle.
- Give editors a filterable FAQ by combining exposed filters with the collapsible style.
- Let users expand every row at once with the per-group Expand All button.
- Collapse a long resource list to just its titles.
- Show a support-ticket listing with hidden ticket details.
- Present a programme or event schedule with expandable session details.
- Build a glossary where each term's definition is hidden until clicked.
- Show search-result rows with collapsed snippet/summary detail.
- Pick multiple detail fields per row to reveal together in one toggle.
- Combine with Views pager so only a page of collapsible rows loads at a time.
- Keep a listing tidy on initial load while still exposing full detail on interaction.
