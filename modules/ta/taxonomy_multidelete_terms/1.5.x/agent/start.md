# Taxonomy Multi-delete Terms — agent index

Adds per-row checkboxes + a "Delete" button to the core vocabulary **term overview** page so
editors can bulk-delete taxonomy terms. Pure UI enhancement on top of core Taxonomy: no settings,
no config schema, no services, no Drush, `configure: null`. Depends on `taxonomy`.

- **The permission that gates the feature** → [permissions/permissions.md](permissions/permissions.md)
- **How the feature works: routes, form alter, tempstore, confirm form, batch delete** →
  [api/delete-terms.md](api/delete-terms.md)

Key facts:
- Feature appears on `/admin/structure/taxonomy/manage/<vocabulary>/overview` for users with
  `access taxonomy multidelete terms`.
- Selecting terms + Delete redirects to a confirm form (route
  `taxonomy_multidelete_terms.delete`) that batch-deletes via
  `Drupal\taxonomy_multidelete_terms\TaxonomyMultideleteBatch::processTerms`.
- Deleting a term also deletes its child terms (standard taxonomy behaviour).
