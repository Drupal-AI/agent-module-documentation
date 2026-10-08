# Entity reference override Entity Browser (entity_reference_override_entity_browser) — agent index

Submodule of **entity_reference_override**. Adds ONE field widget so `entity_reference_override`
fields can select their referenced entities through the **Entity Browser** module while still
capturing the parent's per-reference **override** text (custom title) for each selected item.
No admin UI (`configure` = null), no permissions, no Drush, no services, no plugin *types* — just
the one widget plugin. Depends on `entity_browser` and `entity_reference_override`.

- **Enable the Entity Browser widget on an `entity_reference_override` field, how the per-row
  override box works, and its AJAX behavior** → [fields/widget.md](fields/widget.md)

For the override MECHANISM itself (the `entity_reference_override` field type, its `override` /
`override_format` storage, `override_label` setting, widgets, and the `override_action`
formatters) see the parent docs:
`modules/en/entity_reference_override/2.0.x/agent/configure/field.md` and
`modules/en/entity_reference_override/2.0.x/agent/plugins/plugins.md`.

Key facts:
- Widget plugin id **`entity_browser_entity_reference_override`** (label "Entity browser"),
  class `Drupal\entity_reference_override_entity_browser\Plugin\Field\FieldWidget\EntityReferenceOverrideEntityBrowser`;
  `multiple_values = TRUE`, `field_types = {entity_reference_override}`.
- Extends Entity Browser's `EntityReferenceBrowserWidget`; adds an `override` textfield to each
  row of the widget's `current` items table (title/placeholder taken from the field's
  `override_label` setting).
- Config schema `field.widget.settings.entity_browser_entity_reference_override` extends
  `field.widget.settings.entity_browser_entity_reference` — adds no extra keys.
- No config form, no routes, no permissions, no Drush, no services, no plugin managers.
