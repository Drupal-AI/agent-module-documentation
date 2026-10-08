Decorative Image lets content editors mark an image field value as purely decorative, so it renders with `role="presentation"` and empty alt text and is skipped by screen readers. Site builders enable the option per image field and can require that either Alt text or the Decorative flag is set.

---

The module is hook-driven with no config entity or schema of its own. On the image field's *Edit field*
form (`field_config_edit_form`) it adds two third-party settings via `hook_form_alter`
(`DecorativeConfigFormAlter`): **Enable the Decorative field** (`decorative_enabled`) and **Require Alt
or Decorative** (`decorative_or_alternative_required`), stored as `decorative_images` third-party
settings on the `FieldConfig`. When enabled, `hook_field_widget_single_element_form_alter`
(`DecorativeWidgetFormAlter`) adds a checkbox to each image widget item and, if the "require"
option is on, an element validator that errors when a file is present but neither Alt nor Decorative is
set. The per-image decorative flag is **not** stored on the field value; instead
`hook_entity_presave` writes it to a **key-value store** (`\Drupal::service('keyvalue')->get('decorative_images')`)
keyed by the image's file id (only for `node` and `media` entities). At display time
`hook_preprocess_field` looks up that key-value flag for each image item and sets
`#item_attributes['role'] = 'presentation'`; then `template_preprocess_image` (via the module's
`hook_preprocess_image`) removes the `role` attribute and forces `alt=""` on presentation images. Depends
on core `image`. There is no admin settings page (`configure` null) and no permissions.

---

- Mark a hero/banner image as decorative so screen readers ignore it.
- Flag spacer, divider, or background images as presentation-only.
- Enable the Decorative option on a specific node image field.
- Enable it on a Media entity image field.
- Let editors toggle "decorative" per image right in the upload widget.
- Require editors to provide either Alt text or mark the image decorative (no silently-missing alt).
- Ensure decorative images output `role="presentation"` and empty `alt` for WCAG conformance.
- Reduce screen-reader clutter on image-heavy landing pages.
- Keep meaningful (informative) images with real alt text while suppressing decorative ones.
- Avoid custom preprocess/theme code to emit presentation roles on images.
- Apply the decorative treatment consistently across content types that share an image field.
- Give a11y reviewers a clear editor-facing switch instead of empty-alt guesswork.
- Store the decorative state out-of-band (key-value by file id) without altering field schema.
- Support both node and media image fields with the same option.
- Improve automated accessibility audit scores by correctly marking non-informative images.
- Let site builders enforce the alt-or-decorative rule only where appropriate (per field).
- Handle AJAX upload/remove flows without falsely triggering the required validation.
- Prevent decorative images from being announced as unlabeled graphics.
