<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Paragraphs Limits lets site builders set a minimum and maximum number of each paragraph type allowed on a Paragraphs field, enforced both by hiding "Add" options once the maximum is reached and by a validation constraint on submit.

---

The module adds a new **entity reference selection** plugin, `paragraphs_limits` (id `paragraphs_limits`, extends the Paragraphs module's `ParagraphSelection`), which you choose as the *Reference method* on a paragraph field's settings. It extends the standard per-bundle drag-and-drop table with two extra numeric columns — **Lower limit** and **Upper limit** — for every paragraph type, stored in the field config under `handler_settings.target_bundles_drag_drop.<bundle>.{lower_limit, upper_limit}`. A value of `0` disables that limit. Enforcement happens two ways: `hook_entity_bundle_field_info_alter()` attaches a `ParagraphsLimits` validation constraint to any paragraph field whose handler is `paragraphs_limits`, so submitting too few or too many of a type raises a violation (with configurable min/max messages), and a widget-complete form alter (for both the classic `entity_reference_paragraphs` and stable `paragraphs` widgets) removes a paragraph type from the "Add more" select / buttons once its upper limit is reached, hiding the whole add-more control if nothing is left to add. On uninstall the module cleanly reverts affected fields back to the default `default:paragraph` handler and strips the limit settings. It requires the Paragraphs module, and has no admin settings page of its own (`configure: null`).

---

- Require at least one "Hero" paragraph on a landing-page field.
- Cap "Call to action" paragraphs at a maximum of two per page.
- Allow exactly one "Header" and unlimited "Text" paragraphs on a field.
- Prevent editors from adding more than N image-gallery paragraphs.
- Hide a paragraph type's "Add" button once its maximum is reached.
- Enforce a minimum number of "Step" paragraphs on a how-to content type.
- Set per-paragraph-type min/max instead of a single field cardinality.
- Show a clear validation message when too many of a type are added.
- Show a validation message when too few of a required type are present.
- Disable a limit for a specific type by setting it to 0 while limiting others.
- Constrain a "Section" builder so authors can't overload a page.
- Keep a testimonial field to between 3 and 6 items.
- Limit "FAQ item" paragraphs to a manageable maximum.
- Ensure a "Pricing table" field has at least one plan paragraph.
- Standardize page structure across a content type via per-type limits.
- Work with both the classic and stable Paragraphs widgets.
- Revert fields to the default paragraph handler automatically on uninstall.
- Guide non-technical editors with enforced structural rules.
- Prevent accidental duplication of a unique paragraph type (max 1).
- Combine minimum and maximum to define an exact count for a type.
- Apply different limits to different paragraph types on the same field.
- Reduce editorial errors on complex page-builder content types.
