# xntt_views — usage

Views integration for External Entities. Enabling this submodule turns every external entity type
into a Views base table, so you can list, filter, sort, and format remotely-sourced records with the
standard Views UI. A dedicated Views query plugin translates the view into queries against the remote
source through the parent module's storage clients.

---

The submodule registers a Views query plugin (`xntt_query`), a Views data provider, and a set of field
handlers — a general field handler with formatter support (`external_entity_field`), a
whole-entity renderer (`rendered_external_entity`), a language field, and view/edit/delete links plus
an operations column. Conditions and sorts are pushed to the source where the storage client supports
them and otherwise handled Drupal-side. Because remote querying can be slow for some sources (notably
REST APIs), a local index such as Search API may be a better fit for large datasets.

---

- List external entities of a type in a Views table, grid, or list.
- Add a filter that maps to a remote source field.
- Sort a view by a mapped external field.
- Render a mapped field with any Drupal field formatter in a view.
- Render whole external entities in a chosen view mode inside a view.
- Add View/Edit/Delete links and an operations dropdown to each row.
- Expose the entity language as a column.
- Build an exposed-filter search page over an external dataset.
- Create a block view of the latest records from a remote API.
- Combine external-entity fields with rewrite/global Views fields.
- Provide an admin listing of remote records with bulk operation links.
- Feed a view of external entities into other display types (page, block, feed).
