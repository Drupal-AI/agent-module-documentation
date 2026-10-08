<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facets View Mode Processor (facets_view_mode_processor) — agent index

A single **Facets processor** plugin that renders each facet result item as a
rendered **entity view mode** instead of a plain label. On an entity-reference
facet (e.g. a taxonomy-term field) each item is shown by loading the referenced
entity and rendering it in a chosen view mode, so items can display images,
descriptions or any other field rather than just the entity name.

- Requires **Facets** (`facets:facets`); Composer `drupal/facets ^2.0 || ^3.0`, core `^9.3 || ^10 || ^11`.
- **No settings page, no routes, no permissions, no Drush, no hooks, no `.module`/`.install`, no `config/*`.** The whole module is one `src/Plugin/` class; you configure it per facet in the Facets UI.
- Only applies to a facet whose field resolves to an **entity reference** — otherwise the processor throws `InvalidProcessorException` and cannot be used on that facet.
- Cost note (not a bug): rendering one entity per facet item is far heavier than printing a label — a facet with 100 values renders 100 entities per search. Keep it to facets with few values, cap the result count, and rely on render caching.

Solutions:
- **Enable the processor on a facet and pick the view mode (UI / config / PHP), plus how it renders at runtime** → [configure/processor.md](configure/processor.md)

Key facts:
- Processor plugin id: `translate_view_mode_entity` — label "Transform entity ID to view mode", `@FacetsProcessor`, stage `build` weight `6`.
- Class `Drupal\facets_view_mode_processor\Plugin\facets\processor\TranslateEntityViewModeProcessor` extends facets' own `TranslateEntityProcessor` (id `translate_entity`, the "Transform entity ID to label" processor).
- Setting: `view_mode` (single `select`, `#required`), stored on the facet at `processor_configs.translate_view_mode_entity.settings.view_mode`.
- Injected services: `language_manager`, `entity_type.manager`, `entity_display.repository`.
- Ships no config schema of its own; Facets validates processor settings generically.
