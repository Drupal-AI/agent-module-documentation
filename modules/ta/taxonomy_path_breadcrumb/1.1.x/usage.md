<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Taxonomy Path Breadcrumb lets you choose, per vocabulary, whether taxonomy term pages use Drupal's default taxonomy-hierarchy breadcrumb or the core **path/URL-alias-based** breadcrumb builder.

---

The module registers a single high-priority breadcrumb builder
(`taxonomy_path_breadcrumb.breadcrumb`, priority 1003) that `applies()` only to the taxonomy
term canonical route (`entity.taxonomy_term.canonical`). Rather than build a breadcrumb
itself, it reads a **third-party setting** stored on the term's vocabulary
(`taxonomy_path_breadcrumbs_builder`) and delegates `build()` to whichever core breadcrumb
service that names — either `taxonomy_term.breadcrumb` (Drupal's default term-hierarchy
breadcrumb) or `system.breadcrumb.default` (the path/alias-based breadcrumb). The setting is
added to the vocabulary edit form via `hook_form_taxonomy_vocabulary_form_alter()` under an
"Breadcrumb builder settings" group, and persisted through an entity builder. When a
vocabulary has no setting, it falls back to `taxonomy_term.breadcrumb`, so behavior is
unchanged until you opt a vocabulary in. There is no global configuration page, no
permissions of its own, and no Drush commands — everything is per-vocabulary.

---

- Give one vocabulary's term pages URL/path-based breadcrumbs while leaving others on the default.
- Make taxonomy term breadcrumbs match the site's menu/URL structure instead of term hierarchy.
- Improve SEO by aligning term-page breadcrumbs with the canonical URL path.
- Keep the default term-hierarchy breadcrumb for glossary/reference vocabularies.
- Switch a vocabulary back to the core default breadcrumb without uninstalling anything.
- Provide consistent breadcrumbs on term pages that live under a section landing path.
- Configure breadcrumb behavior entirely through the vocabulary edit form (no code).
- Support mixed strategies across many vocabularies on the same site.
- Use path-based breadcrumbs on term pages that have Pathauto aliases mirroring site structure.
- Avoid confusing hierarchy breadcrumbs on flat (non-hierarchical) vocabularies.
- Store the choice in config (vocabulary third-party setting) so it deploys with the site.
- Ensure the term breadcrumb builder only overrides on genuine term canonical pages.
- Let a Path-based breadcrumb reflect a term's placement in the navigation menu.
- Roll out path breadcrumbs incrementally, one vocabulary at a time.
- Keep breadcrumb logic delegated to core services (no custom breadcrumb rendering to maintain).
