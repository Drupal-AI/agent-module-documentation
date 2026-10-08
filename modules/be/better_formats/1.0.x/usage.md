<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Better Formats extends Drupal core's text-format system so you can, per text field, control which text formats are allowed, their order, and the default format — plus hide the format selector and format tips per role.

---

The module has a small global setting (`better_formats.settings` → `per_field_core`, the "Use field default" toggle) and does most of its work through **per-field third-party settings** and **dynamic permissions**. When a text/long-text/long-text-with-summary field's config edit form is shown, Better Formats adds a "Text Formats" fieldset (`field.field.*.*.*.third_party.better_formats`) letting you: limit the allowed formats (`allowed_formats_toggle` + `allowed_formats`), and override the default format order for new content (`default_order_toggle` + `default_order_wrapper.formats`). At form-render time a process callback (`better_formats_filter_process_format`, spliced in right after core's `TextFormat::processFormat()`) applies those choices to the `text_format` render element — filtering the `#options`, reordering them, choosing a default, and (via permissions) hiding the selector or the format tips/help for non-privileged users. Permissions are `hide format tips`, `hide more format tips link`, and a dynamically generated `hide format selection for <entity_type>` per fieldable entity type. When "Use field default" is on, it also lets you set a field's default format via the field's standard Default Value form even when no value is entered. It depends only on core's Filter module and provides no Drush commands or plugin types.

---

- Restrict a specific body field so only "Basic HTML" can be selected.
- Allow only a single safe format on a comment or user-bio field (which hides the selector).
- Reorder the format dropdown so your preferred format appears first for new content.
- Set the default text format used when creating new content in a field.
- Hide the "About text formats" tips for a role to declutter the editing UI.
- Hide the "More information about text formats" link for basic authors.
- Hide the format selector entirely from certain roles on a given entity type.
- Force a field to Full HTML for trusted editors while limiting others.
- Prevent authors from accidentally choosing a dangerous format on a field.
- Standardize the allowed formats across many fields for editorial consistency.
- Give a "notes" field a plain-text-only experience without a format selector.
- Assign a field-level default format via the Default Value form (enable "Use field default").
- Limit a teaser/summary field to a restricted format separate from the main body.
- Simplify a landing-page WYSIWYG field to one curated format.
- Keep legacy content editable by ensuring its saved format stays in the allowed list.
- Offer only Markdown (or only CKEditor Full HTML) on a documentation field.
- Reduce editor confusion by removing rarely-used formats from a field's options.
- Enforce a house style where new blog posts default to a specific format.
- Hide format guidelines for all but administrators on public-facing forms.
- Configure per-form-mode editing experiences by restricting formats at the field level.
- Roll out consistent format policies via exported field config (`third_party.better_formats`).
- Curate the order of formats so the most common choice is the top/default option.
- Lock down which formats a webform-like text field exposes.
- Migrate a site to a smaller set of formats field by field without code.
