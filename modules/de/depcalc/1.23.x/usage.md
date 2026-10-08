Depcalc (Dependency Calculation) is a developer API module that recursively computes every entity and module an arbitrary entity depends on, caching the result for reuse (notably by Acquia Content Hub).

---

Given any content or config entity, Depcalc's `DependencyCalculator` service walks its fields and configuration to build the complete transitive set of entities it needs to exist elsewhere — referenced entities, config dependencies, embedded media/images, layout-builder components, menu links, path aliases, taxonomy parents, workflows, translations and more. You wrap the entity in a `DependentEntityWrapper`, pass it with a `DependencyStack` to `calculateDependencies()`, and get back a keyed array of `DependentEntityWrapper` objects (plus a `module` list). The recursion is driven by the `calculate_dependencies` event: many `*DependencyCollector` event subscribers each contribute the dependencies they understand, so the system is fully extensible. Results are cached in a dedicated, tag-aware cache bin (`cache.depcalc` service, table `cache_depcalc`) that deliberately survives a normal cache rebuild; the module ships a Drush command `depcalc:clear-cache` (alias `dep-cc`) and events to invalidate it. Depcalc has no UI, permissions, routes, or configuration of its own — the submodule `depcalc_ui` adds a "Clear depcalc cache" button. It is primarily a dependency of packaging/staging tools rather than something end users interact with.

---

- Compute the full set of entities that must be exported alongside a given node.
- Power content-staging/packaging tools (e.g. Acquia Content Hub) with accurate dependencies.
- Find every referenced entity a piece of content transitively needs before migrating it.
- List the modules an entity depends on so a deployment includes them.
- Resolve dependencies of a Layout Builder page including inline blocks and components.
- Include embedded media and images (entity_embed, media embed) in an entity's dependency set.
- Track config-entity dependencies (view modes, fields, workflows) of a content entity.
- Include menu links, path aliases and taxonomy parents in a calculated dependency graph.
- Cache expensive dependency calculations in the dedicated depcalc cache bin.
- Reuse cached dependency results across repeated exports without recalculating.
- Extend calculation for a custom field or entity by adding a `calculate_dependencies` subscriber.
- Skip hash calculation for specific fields via the hash-calculation event.
- Exclude config dependencies from a calculation with `DependencyStack::ignoreConfig()`.
- Clear the depcalc cache from the CLI with `drush depcalc:clear-cache` (`dep-cc`).
- Clear the depcalc cache from the UI (via the depcalc_ui submodule button).
- Invalidate an entity's cached dependencies (and its tagged dependents) on update.
- Build a manifest of everything a "page" bundle needs to render identically elsewhere.
- Detect the module set required to import a config entity into another site.
- Programmatically obtain each dependency's hash for change detection.
- Filter which config entities are treated as dependencies via the filter-config event.
- Support recursive dependency resolution without hitting infinite loops (stack de-dup).
- Integrate dependency calculation into a custom migration or deploy pipeline.
- Warm the depcalc cache ahead of a large export by pre-calculating key entities.
- Diagnose why an exported entity is missing a dependency by inspecting collectors.
- Provide the dependency backbone for a decoupled publishing/staging workflow.
