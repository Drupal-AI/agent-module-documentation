# Typed Entity UI — agent index

Admin explorer for the [Typed Entity](../../../../4.1.x/agent/start.md) module: browse the
wrapper/renderer classes per entity-type/bundle and inspect their PHP class hierarchy. Read-only
developer aid. Depends on `typed_entity`.

- **The explorer page, routes, and permission** →
  [configure/explore-ui.md](configure/explore-ui.md)

Key facts:
- Configure route `typed_entity_ui.explore` → `/admin/config/development/typed-entity`
  (*Configuration → Development → Explore Typed Entity*).
- Details route `typed_entity_ui.details` → `/admin/config/development/typed-entity/{typed_entity_id}`.
- Single permission: **`explore typed entity classes`** (gates both pages).
- No config entities, no plugins, no Drush. Provides theme hooks `php_class_info`,
  `class_with_variants`, `php_class_summary` and stores one State flag
  `typed_entity_ui.hide_video_thumbnail` (removed on uninstall).
- Most useful with `typed_entity_example` enabled so there are repositories to explore.
