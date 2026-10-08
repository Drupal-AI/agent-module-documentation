Field Label extends every field formatter with optional per-display settings to override a field's label text (including a separate plural label), wrap the label in a chosen HTML tag, and add CSS classes to the label — each feature individually toggleable and permission-gated.

---

The module hooks the field-formatter third-party settings form (`hook_field_formatter_third_party_settings_form()`) so that, on any *Manage display* (or Layout Builder formatter) form, an authorized user sees a "Label settings" details group. Depending on which features are enabled site-wide and which permissions the user holds, that group offers: a **Label value** override, a **Plural label** (used when a multi-value field renders more than one item), a **Label class** free-form text field, a **Label class** select drawn from a configured class list, and a **Label wrapper** tag chosen from an allowed-tags list. The choices are stored as third-party settings under `field_label` on that formatter component inside the `entity_view_display` config entity, and applied at render time via `hook_preprocess_field()` (it swaps `variables['label']`, appends `title_attributes.class`, and sets a `label_tag` variable). Which features are available globally is controlled at `/admin/config/content/field-label` (`field_label.settings`: the `*_enabled` booleans, `allowed_tags`, and `class_list`), and each feature has its own permission (`edit_field_label_value`, `edit_field_plural_label`, `edit_field_label_class`, `edit_field_label_class_select`, `edit_field_label_tag`). Because the wrapper tag is applied through a `label_tag` Twig variable, custom themes that override `field.html.twig` must reference `{{ label_tag|default('div') }}` for the wrapper feature to take effect. It is especially useful with Layout Builder, where per-block formatter settings become editable by users who never had *Manage display* access.

---

- Override a field's label text on a specific view mode without renaming the field.
- Show a different label when a multi-value field has more than one value (plural label).
- Wrap a field label in an `h3` (or `span`, `h2`…) instead of the theme's default element.
- Add a utility CSS class (e.g. `visually-hidden`, `text-uppercase`) to a field label.
- Offer editors a curated dropdown of label styles via a configured class list.
- Rename the "Body" label to "Article text" only in the teaser view mode.
- Give Layout Builder users control of field labels without granting *Manage display*.
- Enable only the label-override feature and hide the class/tag features site-wide.
- Restrict who can add free-form label classes vs. who can pick from a preset list.
- Let translators/editors change a label per display while site builders keep tag control.
- Present a singular "Author" and plural "Authors" label on a multi-value reference field.
- Standardize label markup (e.g. always `h4`) across a set of displays.
- Add semantic heading tags to field labels to improve document outline/accessibility.
- Apply BEM-style classes to labels from a governed `class_list` to keep markup consistent.
- Localize/adjust a label for a single entity display without a code deployment.
- Configure allowed wrapper tags (`div`, `span`, `h2`–`h6`) that editors may choose from.
- Store label customizations in exported `core.entity_view_display.*` config for deployment.
- Turn off the plural-label feature globally when it is not needed.
- Give a "content designer" role label-styling powers while other editors cannot change labels.
- Change a promoted field's label wrapper to a heading for SEO/structure on landing pages.
- Suppress a label visually by adding a `visually-hidden` class while keeping it for screen readers.
- Use per-display plural labels on catalog listings ("1 Result" vs "Results").
- Adjust field labels inside Layout Builder inline blocks per section.
- Keep a single field but present it with different labels across teaser, full and search displays.
- Provide a select list of approved label classes so editors cannot enter arbitrary CSS.
