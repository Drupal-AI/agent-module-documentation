<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drupal Canvas Field Component makes any entity field renderable as a Canvas component, so a Canvas ContentTemplate can place "this entity's body/image/date, in this view mode, through this formatter" alongside the components Canvas already offers — without the field first needing a mapping to a component property.

---

Canvas (the Experience Builder page builder) assembles pages from components, but a raw entity field is not a component, which leaves a gap: a Canvas-composed page can hold designed blocks and markup yet not, unaided, the actual field values of the entity being displayed. This module closes that gap with one ComponentSource plugin, `field_display` (`src/Plugin/Canvas/ComponentSource/FieldDisplayComponent.php`), plus a `config_schema_info_alter` hook (`src/Hook/ConfigSchemaHooks.php`) that whitelists the source and an install hook that creates the single `field_display.field_display` Component config entity. Dropped into a ContentTemplate, the component reads the template's target entity type, bundle and view mode, offers a select of the bundle's fields (configurable fields plus non-hidden base fields, minus pseudo-fields), then lets the author choose a field formatter and configure its settings, label display and third-party settings. At render time it resolves the previewed/live entity from the component tree and renders the field via core's `$entity->get($field_name)->view([...])` formatter pipeline — the same path Manage Display uses. Only `field_name`, `entity_type_id`, `bundle`, `view_mode`, `formatter_id`, `formatter_settings`, `formatter_third_party_settings` and `label_display` are persisted; the resolved entity and built render array are runtime-only and stripped before save.

Because rendering goes through the core formatter pipeline, the module inherits image/responsive-image styles, date and text formats, entity-reference rendering, multi-value output, and — importantly — core field-level access control (`EntityViewDisplay::buildMultiple()` applies `$items->access('view')`). It also carries a lot of Canvas-specific plumbing: it normalizes Canvas's string-serialized form values back into Form API shapes (booleans, ints, checkbox arrays) so contrib formatters like Smart Date behave, flattens `<optgroup>` selects the Canvas sidebar can't render, rewrites formatter `#states` selectors from Field-UI paths to the nested Canvas prop paths, and ships a small JS behavior that triggers a live preview refresh when the field or formatter select changes. It requires Drupal `^11.2 || ^12` and PHP 8.3, tracking the Canvas edge rather than a broad range. The whole surface is site-builder/admin territory (editing Canvas templates), managed under the component collection at `entity.component.collection`; it adds no routes, permissions or Drush commands.

---

- Place an entity's rendered field output inside a Canvas ContentTemplate.
- Drop the body field into a Canvas-built node template.
- Render an image field through its image style / responsive image style in Canvas.
- Show a Smart Date field in a Canvas layout even though it has no component-prop mapping.
- Use formatter-extending modules (Date Augmenter, Smart Date) via third-party settings in Canvas.
- Keep core field formatters and their settings in play inside the page builder.
- Choose a specific formatter and label display per field placement, independent of Manage Display.
- Fall back to the Manage Display formatter for component instances saved before formatter selection existed.
- Render the full content of a multi-value entity reference field in a template.
- Preserve field-level access control on composed Canvas pages.
- Build an entity template that mixes designed components with real field values (Layout Builder-style).
- Keep date and text-format handling consistent between Canvas and normal display.
- Manage the single 'Field display' component from the component collection (`entity.component.collection`).
- Place a base field such as title, author or created date into a Canvas template.
- Place a configurable field that is currently hidden in Manage Display (still access-checked at render).
- Get a live preview refresh in the Canvas UI when switching the selected field or formatter.
- Plan a Drupal 11.2+/PHP 8.3 Canvas page-building stack.
- Audit which Canvas ContentTemplates place field-display components and which fields they expose.
- Understand how a Canvas ComponentSource plugin resolves its host entity at render time.
- Migrate a Layout Builder field-block workflow toward Canvas templates.
