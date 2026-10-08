<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Conflict — agent index

Field-level concurrent-edit detection + three-way merge for entities. Auto-merges non-clashing
changes; presents the rest for resolution (inline or dialog). **No admin UI, configure route,
permissions, or Drush** — behavior is driven by the `conflict.settings` config, events, and
`FieldComparator` plugins.

- **Set the resolution strategy (inline/dialog) per entity type/bundle in config** →
  [configure/resolution.md](configure/resolution.md)
- **The FieldComparator plugin type (write one / the default)** →
  [plugins/field-comparator.md](plugins/field-comparator.md)
- **Services + event pipeline (ConflictResolverManager, discovery/resolve events)** →
  [api/services-events.md](api/services-events.md)
- **`hook_conflict_paths_alter()`** → [hooks/hooks.md](hooks/hooks.md)

Submodule: `conflict_paragraphs` → `modules/conflict_paragraphs/3.0.x/`.

Key facts:
- Config `conflict.settings` → `resolution_type.<entity_type>.<bundle>` = `inline` | `dialog`.
  Fallback: `.<type>.<bundle>` → `.<type>.default` → `.default.default` (default `inline`).
- Plugin type: `@FieldComparator` (manager `conflict.field_comparator.manager`, dir
  `Plugin/Conflict/FieldComparator/`); default plugin `conflict_field_comparator_default` (`*`/`*`).
- Events `entity_conflict.discovery`, `entity_conflict.resolve` (`EntityConflictEvents`).
