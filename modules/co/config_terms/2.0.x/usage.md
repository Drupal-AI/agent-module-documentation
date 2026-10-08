<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Terms provides vocabularies and terms as **configuration entities** (`config_terms_vocab`, `config_terms_term`) rather than content, so a controlled list is exported with `drush cex` and deployed with `cim` instead of being recreated or migrated on every environment.

---

Drupal's taxonomy terms are content, which is right when editors own them and wrong when developers do. A list of statuses, regions, document types or service categories that code branches on is configuration in everything but storage: it must be identical across environments, reviewable in a merge request, and deployed rather than re-entered. Because core terms are content, teams reach for default-content modules, migration stubs, or hand-maintained term-ID lists that drift per environment. This module supplies the config-entity equivalent: the `config_terms_vocab` and `config_terms_term` entity types (with label, description, weight, parents and a per-vocab hierarchy that is recomputed on save), a full tabledrag admin UI at `/admin/structure/config-terms`, storage handlers exposing `loadTree`/`loadChildren`/`loadParents`/`getTermOptions`, an `entity_reference` selection handler (`default:config_terms_term`) that scopes options to a chosen vocabulary, and the `config_terms_views` submodule for a Views filter. Access is a static `administer config terms` permission plus per-vocabulary `edit terms in <vid>` / `delete terms in <vid>` permissions generated at runtime by `ConfigTermsPermissions::permissions`. The trade-off mirrors the benefit: config terms are not `taxonomy_term` entities, so they are not fieldable and have no revisions, no content translation, and no compatibility with the taxonomy contrib ecosystem.

---

- Deploy a controlled vocabulary as configuration.
- Keep term IDs identical across every environment.
- Review a vocabulary change in a merge request.
- Stop recreating reference lists per environment.
- Model statuses or workflow states that code branches on.
- Give developers ownership of a fixed list.
- Prevent editors from changing a controlled list.
- Export vocabularies and terms with `drush cex`.
- Roll back a term change with a config revert.
- Filter content by config term in a view.
- Grant per-vocabulary edit/delete permissions.
- Ship a vocabulary with an install profile or module.
- Avoid default-content modules for reference data.
- Keep a service catalogue in version control.
- Standardise a list across a multisite.
- Reference config terms from an entity_reference field.
- Model document types as configuration.
- Build a parent/child hierarchy of config terms.
- Reset a vocabulary to alphabetical order.
- Remove environment drift in reference data.
- Reorder terms with drag-and-drop in the admin overview.
- Look up a term by name via `config_terms_term_load_multiple_by_name`.
