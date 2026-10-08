Chosen Field provides a dedicated "Chosen" field widget so you can enable the Chosen searchable-select UI on specific list and entity-reference fields from Manage Form Display.

---

The main Chosen module applies globally to selects that pass its option-count thresholds. Chosen Field (`chosen_field`) instead exposes a per-field widget, `chosen_select`, that extends core's Options Select widget so a site builder can deliberately turn Chosen on for one field regardless of the global rules. It supports `list_integer`, `list_float`, `list_string` and `entity_reference` field types. The widget adds its own settings — a placeholder string, "no results" text, and a per-widget "search contains" override — stored under the `field.widget.settings.chosen_select` config schema and edited from the field's Manage Form Display screen. It depends on the main Chosen module for the underlying library and behavior. Use it when you want Chosen on selected fields only, or want different placeholder/search behavior on a particular field than the site default.

---

- Enable Chosen on a single entity reference field only.
- Give a list_string field a searchable Chosen dropdown from Manage Form Display.
- Override the placeholder text for one specific field.
- Set custom "no results" text on an individual widget.
- Turn on "search contains" for just one field, independent of global settings.
- Use Chosen on a field even when it has fewer options than the global threshold.
- Keep Chosen off site-wide but on for chosen fields via the widget.
- Provide a tag-style multi-select for a multi-value reference field.
- Apply Chosen to a list_integer priority/rating select.
- Apply Chosen to a list_float field of numeric options.
- Export the per-field Chosen widget configuration with the form display.
- Give editors a consistent Chosen experience on key content fields.
- Configure placeholder and search behavior per bundle by using the widget on each form display.
- Swap a plain select widget for Chosen without changing site-wide config.
- Differentiate Chosen behavior between two fields on the same content type.
