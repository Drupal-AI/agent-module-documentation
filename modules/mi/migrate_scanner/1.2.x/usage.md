<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Scanner changes how Drupal finds migration definitions: instead of looking only in each module's `migrations/` directory, it discovers migration YAML recursively, so a large migration can be organised into subdirectories.

---

Core's migration plugin discovery is deliberately flat — it reads `migrations/*.yml` in a module and stops there. That is fine for a handful of migrations and painful for a project with a hundred, where the only way to impose order is a naming convention in filenames. This module swaps the discovery component for a recursive one: `src/Component` holds the scanning implementation and `src/Plugin` the discovery decorator, wired through `migrate_scanner.services.yml`, with `migrate_scanner.api.php` documenting the hook surface for other modules. It depends on core `migrate` only, has no routes, permissions, config or schema, and its `core_version_requirement` of `^10 || ^11 || ^12` already covers Drupal 12. The practical effect is entirely organisational: the same migrations run the same way, they are just allowed to live in `migrations/nodes/`, `migrations/media/`, `migrations/users/` and so on. It is a development-time convenience with no runtime behaviour for editors.

---

- Organise a large migration into subdirectories.
- Group migrations by entity type or source system.
- Escape flat `migrations/` directories on a big project.
- Keep related migration YAML files together.
- Reduce reliance on filename prefixes for ordering.
- Split a multi-phase migration into folders per phase.
- Discover migrations shipped in nested module structures.
- Make a migration codebase navigable for a new developer.
- Support several source systems in one migration module.
- Version migration groups independently in review.
- Reduce merge conflicts in a shared migrations directory.
- Prototype migrations without restructuring later.
- Keep test and production migrations in separate folders.
- Adopt a directory convention across a migration team.
- Scan migrations contributed by multiple modules.
- Extend discovery from a custom module via the API hooks.
- Prepare a migration codebase for Drupal 12.
- Audit which migration definitions a site actually loads.
