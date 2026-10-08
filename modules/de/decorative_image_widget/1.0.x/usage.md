Decorative Image Widget adds a per-widget option that puts a "Decorative" checkbox on image fields, so editors must either enter alt text or explicitly mark the image as decorative (empty alt) — never leave alt silently blank.

---

The module is a widget-level enhancement for core's Image field widget (`ImageWidget`). It adds no field type or settings page. Via `hook_field_widget_third_party_settings_form()` it offers a single checkbox — "Force image to be marked decorative if no alt text provided" — on the widget settings of any image field, but **only when that field's Alt text is enabled and NOT required** (`alt_field_required` is FALSE). Enabling it stores a third-party setting `decorative_image_widget.use_decorative_checkbox: true` on the widget component in the `entity_form_display` config. At form build time (`hook_field_widget_single_element_form_alter` on D10+, `hook_field_widget_form_alter` on D9) a process callback in `DecorativeImageWidgetHelper` adds a "Decorative" checkbox next to the alt field and attaches an element validator: on submit, if an image was uploaded, alt text is empty, and the Decorative box is unchecked, it raises "You must provide alternative text or indicate the image is decorative." A small JS library keeps the checkbox and the alt textfield in sync in the UI. The net effect is an accessibility guardrail — editors can produce a genuinely empty `alt=""` for decorative images (correct for screen readers) but cannot accidentally forget alt text.

---

- Force editors to either write alt text or consciously mark an image decorative, improving accessibility.
- Allow a legitimately empty `alt=""` for purely decorative images without disabling alt entirely.
- Add a "Decorative" checkbox to an Article's image field on its Manage form display.
- Prevent authors from silently saving images with missing alt text.
- Meet WCAG guidance that decorative images be hidden from screen readers via empty alt.
- Keep alt text optional at the field level while still enforcing an explicit choice at edit time.
- Apply the guardrail per form mode (e.g. enforce on the default form but not a bulk-import form).
- Roll out the decorative-checkbox behaviour across many image fields by toggling one widget setting each.
- Give a media image field a decorative option without writing a custom widget.
- Reduce accessibility-audit findings for missing alt attributes on editorial content.
- Let a screen-reader-hidden hero/background image be marked decorative during authoring.
- Standardise how a content team handles alt text vs decorative images.
- Store the choice in exported config (`third_party_settings.decorative_image_widget.use_decorative_checkbox: true`) for deployment.
- Turn the behaviour on or off per environment by overriding the form-display config.
- Validate alt/decorative only at genuine save (not on the intermediate upload AJAX step).
- Pre-check the Decorative box automatically when editing an existing image that was saved with empty alt.
- Combine with core image styles and existing image fields with no data migration.
- Provide a clearer editor prompt ("This image is decorative and should be hidden from screen readers").
- Enforce the alt-or-decorative rule on user profile or taxonomy image fields via their form displays.
- Avoid making alt text hard-required (which blocks decorative images) while still catching omissions.
