<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Comparison lets visitors build a personal "compare these" list for any content entity bundle and view the selected items side by side in a table at `/compare/{id}`. Each comparison you configure generates its own view mode, add/remove link field, blocks and permission.

---

An `entity_comparison` config entity defines one comparison: label, machine name, the text of the add and remove links, a maximum number of items (`0` = unlimited), and the target entity type + bundle. Saving a new one triggers a fair amount of scaffolding in `postSave()` — it creates an entity view mode named `{bundle}_{id}`, rebuilds routes and flushes caches. From then on `hook_entity_bundle_field_info()` exposes a computed `entity_comparison_link` base field on that bundle, `hook_entity_extra_field_info()` + `hook_entity_view()` expose a `link_for_entity_comparison_{id}` display component you can position in any view mode, `hook_views_data_alter()` adds a matching Views field, and two block plugin derivatives appear: one rendering the add/remove link and one linking to the comparison page. Clicking the link hits `/entity-comparison/{entity_comparison_id}/{entity_id}`, whose controller toggles the entity in `$_SESSION['entity_comparison_{uid}']`, keyed by entity type → bundle → comparison id; it enforces the configured limit, emits a status or error message, and — for AJAX requests — returns commands that replace the link, the comparison table and any comparison blocks in place. The comparison page itself is a dynamic route per comparison (`/compare/{id-with-dashes}`) guarded by a generated permission, `use {id} entity comparison`; it loads the session list, renders each entity's fields through the auto-created view mode, and builds a table whose first column is the field label and whose remaining columns are the entities, with a "Remove from the list" row on top. `hook_entity_comparison_rows_alter()` lets you add or rewrite rows before render. State lives entirely in the session — nothing is stored per user in the database — so lists are per browser session and vanish when it ends.

---

- Let shoppers compare products side by side on a catalogue site.
- Compare technical specifications of several devices in one table.
- Build a "compare plans" page for subscription tiers modelled as nodes.
- Compare university courses, job listings or property listings.
- Limit a comparison to a maximum of 3 or 4 items to keep the table readable.
- Offer several independent comparison lists (e.g. laptops and phones) on one site.
- Place an "Add to compare" link in a teaser view mode on listing pages.
- Add the compare link as a Views field in a product listing view.
- Show a block with a link to the comparison page and the current item count.
- Choose exactly which fields appear in the comparison via the generated view mode.
- Reorder or reformat comparison rows using standard Manage display settings.
- Add a computed row (e.g. a verdict or score) with `hook_entity_comparison_rows_alter()`.
- Let visitors remove an item directly from the comparison table.
- Update the compare link over AJAX without a page reload.
- Restrict comparison to logged-in users by granting the permission per role.
- Compare taxonomy terms, media items or any other content entity bundle, not just nodes.
- Compare translated entities — the current language's translation is rendered when available.
- Give anonymous visitors a session-scoped comparison list without any user account.
- Theme the comparison table by overriding the module's theme hooks.
- Link each compared entity's label back to its canonical page from the table header.
