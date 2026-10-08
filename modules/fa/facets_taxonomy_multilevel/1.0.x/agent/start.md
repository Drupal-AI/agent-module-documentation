<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facets Taxonomy Multilevel (facets_taxonomy_multilevel) — agent index

Adds two Facets **build processors** for hierarchical taxonomy facets. Enabled per facet from the
Facets UI, they refine (filter) the facet's already-computed result list so a deep vocabulary shows
one level at a time instead of every term at once. No index changes, no routes, no permissions.
Depends on `facets` (and core `taxonomy`). Composer: `drupal/facets ^2.0 || ^3.0`; core
`^9 || ^10 || ^11`. No settings page (`configure` null).

| Processor (plugin id) | Build stage weight | Effect |
|---|---|---|
| Term Depth (`term_depth`) | 40 | Keep only facet results whose term sits at one chosen depth of one vocabulary |
| Term Dependent (`term_dependent`) | 41 | Keep only child terms of the term selected in another (dependee) facet |

- **Term Depth: level + vocabulary settings, runtime tracing** → [configure/term-depth.md](configure/term-depth.md)
- **Term Dependent: dependee-facet drill-down settings, runtime tracing** → [configure/term-dependent.md](configure/term-dependent.md)

Key facts:
- Plugins are of the `@FacetsProcessor` type (defined by the Facets module), classes in
  `src/Plugin/facets/processor/`; both implement `BuildProcessorInterface` — they run in the facet's
  `build` stage and only trim the result array.
- Term Depth settings: `level` (1-based, 1 = root level) and `bundle` (vocabulary machine name).
  Term Dependent settings: a map keyed by dependee facet id, each `{ dependee: true }`.
- Term Dependent runs AFTER Term Depth (stage weight 41 > 40) and reads the dependee facet's
  `term_depth` settings, so the dependee facet must have Term Depth enabled.
- Config schema: `config/schema/facets_taxonomy_multilevel.processor.schema.yml`; the values are
  stored inside each facet config entity under `processor_configs.<id>.settings`.
- `.module` implements only `hook_help`. No `*.services.yml`, `*.routing.yml`, `*.permissions.yml`,
  or drush.
