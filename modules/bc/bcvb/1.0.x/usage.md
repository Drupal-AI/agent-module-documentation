Bundle Class View Builder (BCVB) lets a content entity's bundle class render itself from a `build()` method, bypassing core's Field UI / view-display rendering.

---

BCVB is a small developer utility. On its settings page (`/admin/config/content/bcvb`) you tick the content entity types that should use its view builder. For each ticked type, `bcvb_entity_type_alter()` replaces the entity type's view-builder class with `Drupal\bcvb\Handler\BcvbViewBuilder`. When such an entity is rendered, the builder checks whether the entity's bundle class implements `Drupal\bcvb\Entity\BuildableEntityInterface` and whether `shouldBuild($viewMode)` returns TRUE; if so, the render array comes from the bundle class's own `build($viewMode)` method instead of core's managed display, with cacheability metadata merged in automatically. Any bundle class that does not implement the interface (or returns FALSE from `shouldBuild()`) keeps rendering normally, so the switch is safe to enable per entity type. It pairs naturally with the BCA module (attribute-based bundle class discovery) and the Pinto module (object-oriented, component-style theming), letting a bundle class return a Pinto theme object directly from `build()`.

---

- Render a Paragraph bundle entirely from PHP in its bundle class instead of configuring Field UI display.
- Render a custom Block content bundle (e.g. an accordion) via a bundle-class `build()` method returning a component render array.
- Take full control of Media entity rendering per bundle without touching manage-display.
- Return a Pinto theme object straight from a bundle class `build()` for object-oriented theming.
- Opt a single entity type (e.g. `block_content`) into custom rendering while leaving nodes untouched.
- Gate custom rendering by view mode: return TRUE from `shouldBuild()` only for the `full` view mode and fall back to core for teasers.
- Provide bundle-specific markup that varies by view mode using the `$viewMode` argument passed to `build()`.
- Skip building for a bundle conditionally (return FALSE from `shouldBuild()`) so it renders via the normal view display.
- Attach cacheability metadata to bundle-class output; BCVB merges it with core's build defaults automatically.
- Replace verbose Twig/preprocess theming with typed, testable PHP render logic in the bundle class.
- Build a design-system component library where each entity bundle maps to a component object.
- Migrate legacy hook_preprocess-heavy rendering into per-bundle `build()` methods incrementally.
- Combine with BCA `#[Bundle]` attributes so bundle classes are auto-discovered without hook_entity_bundle_info().
- Keep field data access in the bundle class (typed getters) and render it explicitly, avoiding field-formatter config drift.
- Toggle which entity types use custom rendering entirely through configuration, exportable via config sync.
- Restrict configuration access with the `administer bcvb settings` permission.
- Unit/functional test entity rendering by asserting the render array returned from `build()` directly.
- Clear entity-type definition caches automatically when the opted-in entity type list changes (handled by the config event subscriber).
- Use as a lightweight alternative to Layout Builder or full display modes when a bundle needs one canonical rendering.
- Study the shipped `bcvb_example` test module for a complete accordion Block content example wired to Pinto.
