<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Filter Term adds an admin listing page that finds nodes by vocabulary, taxonomy term, content type, node title and author.
---
The module ships a filter form (`VocabForm`) whose selections are passed as query parameters to a controller page at `/allcontent`. The controller (`DefaultController::content`) builds a database query against `taxonomy_index`, `node_field_data` and `users_field_data`, applies the chosen term / content type / title / author conditions, and renders a paged, sortable table of matching nodes with view/edit links. A second route, `/admin/config/filter_term/vocab`, exposes the same filter form to authenticated users.

Query conditions use the Drupal database API with parameterised values (no raw SQL concatenation). Note the operational/security posture: the `/allcontent` route is gated only by the core `access content` permission, and the resulting table lists nodes by direct database query WITHOUT a node-access check, so it reports both published and unpublished nodes (a `Status` column shows which). Treat the listing as visible to anyone who can access content on the site.

Setup is simply enabling the module and visiting the filter form; there is no stored configuration beyond the taxonomy/content already on the site.
---
- Enable the module to get the `/allcontent` node-finder page.
- Open `/admin/config/filter_term/vocab` to use the filter form.
- Filter published and unpublished nodes by a chosen vocabulary.
- Narrow a listing to a single taxonomy term.
- Combine a term filter with a content-type filter.
- Find a node by exact title match.
- List all nodes authored by a selected user.
- Browse every node when no filter is selected.
- Page through large result sets (3 rows per page).
- Sort the results table by title, type, author or status.
- Jump to a node's canonical view from the results table.
- Jump straight to a node's edit form from the results table.
- Audit which content of a type is published vs unpublished.
- Give editors a quick term-based content browser.
- Use the AJAX term dropdown that reloads when a vocabulary is chosen.
- Reset all filters back to the full listing.
- Redirect back to the filter page after saving a node (module alters the node form).
- Review content ownership across authors from one screen.
- Restrict who sees the page by tightening the `access content` permission implications.
