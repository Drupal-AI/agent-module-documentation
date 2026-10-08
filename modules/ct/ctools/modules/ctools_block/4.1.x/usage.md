Chaos Tools Blocks adds an "Entity field" block plugin that renders a single field of an entity (from context) using any field formatter, plus a matching config schema.

---

`ctools_block` is a small experimental submodule of Chaos Tools that provides block improvements intended to eventually land in Drupal core. Its main contribution is the **Entity Field** block (`entity_field:*` deriver `EntityFieldDeriver`, class `Plugin\Block\EntityField`), which takes an entity from a block context and outputs just one of its fields, rendered with a chosen field formatter and formatter settings. It also ships an `EntityView` block and a config schema (`block.settings.entity_field:*:*`) that stores the formatter type, weight, region, label, settings, and third-party settings. A hook (`ctools_block_plugin_filter_block_alter`) hides these blocks from the Layout Builder chooser, since core equivalents are preferred there — they are meant for context-aware systems like Panels and Page Manager. There is no admin configuration page; you place and configure the block through whichever block/variant UI consumes it. It depends on the base `ctools` module and supports Drupal 9.5, 10, and 11.

---

- Render a single entity field as a standalone block.
- Show a node's body, image, or custom field via a Panels/Page Manager variant.
- Pick any field formatter (and its settings) for the field block.
- Display an entity field using context passed in from a display variant.
- Add per-field label, weight, and region settings to a block.
- Store field-block configuration as exportable config.
- Provide field blocks for a decoupled layout system.
- Attach third-party settings to a rendered field block.
- Render a computed/base field of an entity as a block.
- Reuse a field formatter's output outside the entity's default view display.
- Build a page layout that pulls individual fields from a context entity.
- Hide CTools field blocks from Layout Builder (default behavior) while keeping them for Panels.
- Show an entity's title or author field independently in a region.
- Compose a detail page from separate field blocks instead of one view display.
- Provide the field-block backbone that Panels IPE uses.
- Render a referenced entity's field via context relationships.
- Give site builders granular field placement without Layout Builder.
- Expose an `EntityView` block that renders a full entity from context.
- Standardize field-block config schema for validation and translation.
- Migrate legacy Panels field panes to a supported field block.
