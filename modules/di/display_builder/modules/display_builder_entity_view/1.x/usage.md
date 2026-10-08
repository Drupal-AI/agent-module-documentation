Display Builder for entity view lets a bundle's view mode be built with Display Builder, adds per-entity display overrides, and can migrate Layout Builder configs.

---

`display_builder_entity_view` connects Display Builder to Drupal's entity view display system. Enabling it lets you build an entity view display (a bundle + view mode, such as node.article.default or a Teaser view mode) with the Display Builder canvas instead of Field UI's field table or core Layout Builder. It provides `entity_view` and `entity_view_override` buildable plugins, an `EntityViewDisplay` config entity (and a `LayoutBuilderEntityViewDisplay` variant for migration), a per-entity **override** flow with publish/revert, dynamically registered Manage-display and per-entity builder routes (via `Routing/DisplayBuilderRoutes` and `Routing/OverridesRoutes` route subscribers), an `ExtraFieldSource` UI Patterns source, template overrides, and a Navigation hook. It depends on `field_ui`, `display_builder`, and the UI Patterns field / field-formatters modules.

---

- Build a bundle's default view mode with Display Builder from Manage display.
- Build any additional enabled view mode (Teaser, Full, Search result…) with components.
- Use SDC components, fields and blocks to lay out how a content type is displayed.
- Add an extra field ("Display builder") into an entity display via the `ExtraFieldSource`.
- Let an editor override the display of a single entity on top of the bundle default.
- Publish an override so it becomes the live display for that entity.
- Revert an override back to the bundle's default display.
- Migrate an existing Layout Builder entity view display configuration into Display Builder.
- Migrate existing per-entity Layout Builder overrides (see the migration tests) into Display Builder overrides.
- Replace core Layout Builder for entity displays while keeping view-mode semantics.
- Preview an entity display live, rendered through the real entity view pipeline.
- Drive the builder from a clean full-page route (no admin chrome) so the viewport switcher works.
- Keep field-based displays and Display-Builder displays side by side across different view modes.
- Provide a "Display builder" local task/tab on entity displays for editors.
- Use it as the entity-view piece of a full design-system setup with UI Suite themes.
