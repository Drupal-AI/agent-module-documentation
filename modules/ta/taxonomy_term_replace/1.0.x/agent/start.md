# Taxonomy Term Replace — agent index

A single admin dashboard that bulk-replaces a taxonomy term reference on nodes with another term
from the same vocabulary, reports how many nodes use a term, and exports the list to CSV. No config,
no config schema, no plugins, no services, no Drush — just one form and one permission.

- **The dashboard route/permission, how it finds nodes, and the replacement semantics** →
  [configure/dashboard.md](configure/dashboard.md)

Key facts: route `taxonomy_term_replace.dashboard` at
`/admin/structure/taxonomy/taxonomy-term-replace`; permission
`access Taxonomy Term Replace dashboard`. Published-node search uses the core `taxonomy_index`
table; the unpublished path scans entity-reference fields (`target_type: taxonomy_term`) matching
the vocabulary. Replacement is a batch that swaps the matching `target_id` in the reference field to
the replacement term and saves each node. CSV export goes to `public://taxonomy-term-node-search.csv`.
