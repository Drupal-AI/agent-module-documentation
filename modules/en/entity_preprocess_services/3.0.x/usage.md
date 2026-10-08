<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Preprocess Services is a developer module that lets you write entity preprocessing logic as dependency-injected, unit-testable services instead of procedural `hook_preprocess_HOOK()` functions.

---

Install it like any module (`composer require drupal/entity_preprocess_services` then enable it) — there is no configuration UI, no permissions and no settings page; everything happens in code. To add preprocessing, create a class that extends `Drupal\entity_preprocess_services\PreprocessService\PreprocessServiceBase`, override `preprocess()` to set values on `$this->variables` and `return parent::preprocess();`, then register it in your module's `*.services.yml` with the tag `{ name: entity_preprocess_service, priority: 100 }` and a `properties.applies_to` list of `{ entity_type, bundle, view_mode }` maps (only `entity_type` is required; omit `bundle`/`view_mode` to match all). A compiler pass collects every tagged service and the `entity_preprocess_services.manager` runs the matching ones, highest `priority` first, whenever a node or paragraph is rendered. Nodes and paragraphs work out of the box; for any other entity type implement that type's preprocess hook yourself and call `_entity_preprocess_services_preprocess_entity($variables, $entity, $view_mode)`. Use the `properties.excludes` list to skip specific bundles/view modes, and study the bundled `entity_preprocess_services_example` submodule for three working samples. Because each service implements `CacheableDependencyInterface`, override `getCacheContexts()`/`getCacheTags()`/`getCacheMaxAge()` to control caching, and run `drush cr` after changing any service tag so the compiler pass re-runs.

---

- Move preprocess logic out of `.theme`/`.module` files into services.
- Inject services (entity type manager, current user, config) into preprocessing.
- Unit-test preprocess logic in isolation.
- Add a `welcome` or `info_text` style variable to node templates.
- Preprocess all nodes regardless of bundle or view mode.
- Preprocess only one bundle (for example `page`).
- Preprocess only one view mode (for example `full`).
- Target a specific bundle-and-view-mode combination.
- Exclude a bundle from an otherwise broad preprocess rule.
- Order multiple preprocess services with `priority`.
- Preprocess paragraphs the same way you preprocess nodes.
- Extend preprocessing to taxonomy terms, users, media or custom entities via the helper function.
- Attach cache contexts and tags to preprocessed variables.
- Refactor a large procedural preprocess hook into small, focused classes.
- Share preprocess helpers between projects as reusable service classes.
- Study the example submodule to learn the tag and `applies_to` syntax.
- Enable the example module to see sample services fire on node templates.
- Keep theme-layer code organised per entity type and bundle.
- Register a service with `applies_to` in `*.services.yml`.
- Clear caches so the compiler pass picks up new or changed services.
- Provide a clean, OOP alternative to `hook_preprocess_HOOK()`.
