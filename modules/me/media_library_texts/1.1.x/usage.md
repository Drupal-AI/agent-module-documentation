<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Make Media Library widget texts configurable.

---

Media Library Widget Texts overrides the strings shown in Drupal core's Media Library widget — the "Add media" button label, the empty-selection notice, and the remaining-items cardinality messages — so you can set per-site, per-field wording without overriding Twig templates or patching core. There is no separate settings page or permission: the five texts are stored as field-widget third-party settings on each field's Manage form display entry (set the widget to "Media library", click the gear icon, fill the fields). Requires core `media_library`; supports Drupal 11.3+ and 12.

---

- Rename the Media Library "Add media" button to "Add image" on an image-only media field.
- Rename the same button to "Add document" / "Add video" / "Attach file" to match a field's purpose.
- Replace the default "No media items are selected." empty-state text with clearer guidance for editors.
- Give the empty-state a call to action, e.g. "Click 'Add image' to choose a photo."
- Customize the singular remaining-slot message ("One media item remaining.") per field.
- Customize the plural remaining-slot message using the `@count` placeholder ("@count photos left to add.").
- Customize the field-full message ("The maximum number of media items have been selected.").
- Set friendlier cardinality wording on a limited-cardinality gallery field (e.g. "Add up to @count more images.").
- Provide different wording per form mode by configuring separate Manage form display modes.
- Localize the widget wording alongside Drupal's interface translation for a specific field.
- Establish consistent on-brand microcopy across all media fields on a site.
- Clarify an editor workflow where "media" is confusing jargon for non-technical authors.
- Distinguish two media fields on the same form by giving each a distinct add-button label.
- Reduce editor confusion on a single-value media field by tailoring the "one remaining" message.
- Improve accessibility/readability by using plainer language in the widget controls.
- Preview override texts at a glance via the Manage-form-display settings summary before saving.
- Keep field help text intact — the cardinality message is appended after the field description, not replacing it.
- Roll out wording changes through configuration export/import, since the texts live in the form-display config.
- Adjust wording for a content type without touching any other content type's media fields.
- Guide editors on an events site (e.g. "Add up to 10 gallery photos") using the plural message.
- Restrict who can change the wording to site builders by relying on core's "administer form display" permission.
