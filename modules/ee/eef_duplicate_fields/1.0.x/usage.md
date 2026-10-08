<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds two Entity Extra Field plugins that let you re-render an existing field (or a referenced entity's field) as a computed extra field on an entity display, each with its own field-formatter configuration.

---

EEF - Duplicate Fields is an add-on for the Entity Extra Field (entity_extra_field) module. It ships two ExtraFieldType plugins configured entirely from the Manage Display UI. "Duplicate Field" mirrors any field already on the same entity and renders it again with an independently chosen formatter and formatter settings, so the same value can appear more than once in different presentations. "Entity Reference Duplicate Field" pulls a field out of a referenced entity and renders it inline on the parent's display, optionally chaining one level deeper through a second entity reference (for example Event -> Branch -> Branch Address). Both reuse core's field formatter plugins and their third-party settings, respect field- and entity-level view access, skip empty or inaccessible values, iterate all values of multi-value reference fields, and record config dependencies on the referenced field so the extra field is cleaned up when a source field is deleted. It requires Drupal 10 or 11 and entity_extra_field ^2.0, and adds no routes, permissions, services, or config schema of its own.

---

- Show the same image field twice on a node display, once as a thumbnail and once at full size.
- Render a date field in two formats side by side (for example a long human date and a compact numeric date).
- Display a body/text field once in full and once truncated with a summary or trimmed formatter.
- Apply different formatter third-party settings (such as an address map link) to a duplicate of an address field.
- Re-render a number or price field with alternative formatter options without duplicating the stored data.
- Surface a link field both as a plain URL and as a formatted clickable link.
- Pull a referenced Branch entity's phone number onto an Event display without writing custom code.
- Show an address from a referenced Location entity directly on the parent content.
- Display the name or picture of a referenced User (author, contact) inline on another entity.
- Chain through references to render Event -> Branch -> Branch Address on the event page.
- Render a field from every entity in a multi-value entity reference field (all accessible values are output).
- Choose the target bundle when an entity reference field can point at several bundles.
- Reuse an image style, responsive image, or media formatter when re-displaying a referenced media field.
- Add editorially useful "computed" fields to a view display without extending the content model.
- Present taxonomy term fields from referenced content with a specific term formatter.
- Build layout-friendly displays where a duplicated field is placed in a different region than the original.
- Keep the original field hidden while showing only its reformatted duplicate.
- Combine with entity_extra_field's own visibility/token features to conditionally show duplicated fields.
- Expose a referenced organization's contact details on many child content types consistently.
- Render a second-level referenced field (reference of a reference) with the correct formatter for its field type.
