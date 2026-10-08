Field Image Style adds an `image_style` field type whose value is the machine name of a Drupal image style, letting editors pick a style per entity. Its companion image formatter then renders an `image` field using whichever style the entity selected.

---

The module defines one field type, `image_style`, which extends the core Options `ListItemBase` so its allowed values are drawn from the site's configured image styles (`image_style_options()`). Storage settings are `allowed_values` (a checkbox list restricting which image styles may be chosen; empty means all) and `sort` (order the options by label). Because a single entity should carry one style, `hook_form_field_storage_config_edit_form_alter()` forces cardinality to 1 and hides the cardinality control. The field reuses core widgets (`options_select`, `options_buttons`) and core list formatters (`list_default`, `list_key`), which the module registers for the new type via `hook_field_widget_info_alter()` and `hook_field_formatter_info_alter()`. The payoff is a second formatter, `image_style_image_formatter` (a subclass of core's `ImageFormatter`), placed on an ordinary `image` field: its `field_image_style` setting names an `image_style` field on the same bundle, and at render time it reads that field's stored value and applies it as the image style, falling back to the original image when empty. This lets a content author choose the display size/crop of an image on a per-node basis without a developer editing the view display.

---

- Let editors choose which image style renders a node's hero image on a per-node basis.
- Offer a "Small / Medium / Large" style selector on articles that controls how the teaser image is scaled.
- Store a preferred thumbnail style on each product and render the product image with it.
- Restrict the selectable styles to an approved subset via the field's `allowed_values` storage setting.
- Sort the style dropdown alphabetically by label with the `sort` storage setting.
- Give landing pages a per-page banner crop chosen from a curated list of crop styles.
- Build a gallery where each item's image style is data-driven from a field rather than hard-coded in the display.
- Use the `options_buttons` (radio) widget to present image styles as radio buttons instead of a select list.
- Expose the chosen image style as plain text with the `list_key` formatter for debugging or theming.
- Show the human-readable style label with the `list_default` formatter.
- Drive responsive-ish behavior editorially: authors switch to a wider style for full-bleed images.
- Let a migration set the image style per row by writing the style machine name into the `image_style` field.
- Provide a fallback to the original (unstyled) image when the editor leaves the style field empty.
- Combine an `image_style` field with an `image` field so the image formatter's style follows editor choice.
- Configure the image link (to content or to file) alongside the dynamic style in the formatter settings.
- Standardize allowed crops across a content type by limiting allowed values centrally.
- Let non-developers change image presentation without touching Manage display.
- Support editorial A/B of image sizes by toggling the style field value.
- Reference the same image field with different styles across view modes by pointing formatters at different `image_style` fields.
- Keep image-style choices in content (and thus revisionable/translatable) rather than in configuration.
- Populate a style picker only with the styles relevant to a given bundle by curating allowed values.
- Cache-tag rendered images by the selected image style automatically (the formatter merges the style's cache tags).
- Let taxonomy terms or media entities carry a display-style preference via the field.
- Prototype new image styles and let editors opt in per entity before making them the default.
