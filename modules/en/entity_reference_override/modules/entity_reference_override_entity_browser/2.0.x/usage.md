Entity reference override Entity Browser adds an Entity Browser–based field widget for `entity_reference_override` fields, so editors can pick the referenced entities through any configured Entity Browser and still type a per-reference override (custom title) for each selected item.

---

This submodule provides a single field widget, `entity_browser_entity_reference_override` ("Entity browser"), for the parent module's `entity_reference_override` field type. The class `EntityReferenceOverrideEntityBrowser` extends Entity Browser's `EntityReferenceBrowserWidget`, so entity selection happens through whatever Entity Browser you configure (modal/iframe, views, media library, upload, etc.), and it augments the widget's "current items" table by adding an extra `override` textfield to each row — labelled or placeholdered from the parent field's `override_label` setting. It preserves override text across the widget's AJAX add/remove operations by serialising a `{delta => {override, target_id}}` map into a hidden `entity_reference_override_default_values` element and re-reading it on the relevant triggering element, restores overrides in `formElementDefaultValues()`, remaps them on single-item removal in `removeOverrideItemSubmit()`, and copies each visible row's override back onto the saved field values in `massageFormValues()`. It depends on both `entity_browser` and `entity_reference_override`, and adds no configuration form, no permissions, no Drush and no services — only the widget plugin (its config schema extends `field.widget.settings.entity_browser_entity_reference`, adding no keys). The override display/formatting is entirely the parent module's concern.

---

- Let editors select referenced entities via an Entity Browser instead of an autocomplete, while still overriding each item's title.
- Curate a media gallery through a media Entity Browser and give each item a custom caption/title per placement.
- Pick multiple nodes from an Entity Browser and set a per-reference display title for each.
- Keep override text intact while adding or removing items in the Entity Browser widget (AJAX-safe).
- Use a modal or iframe Entity Browser for reference selection on an `entity_reference_override` field.
- Provide a richer selection UX (search, views, upload) for overridable references.
- Set the override box label/placeholder per field via the parent field's `override_label` setting.
- Replace the parent module's default autocomplete widget with a browser widget on Manage form display.
- Support multi-value overridable reference fields with a browser-based selection table.
- Combine Entity Browser's bulk selection with entity_reference_override's per-item custom text.
- Build editorial "featured content" widgets where items are browsed and titled in one place.
- Reorder browsed items while retaining their override values.
- Remove a single browsed item without losing the override values of the remaining items.
- Use Entity Browser's media-library integration together with per-reference titles.
- Give content teams a familiar Entity Browser flow plus contextual title overrides.
- Avoid duplicating media/nodes just to show different titles in different placements.
- Run several instances of the widget on one form without their override state colliding.
- Configure the underlying Entity Browser (selection mode, cardinality, display) independently of the override behavior.
