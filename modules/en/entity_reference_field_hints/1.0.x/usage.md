<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds editor-facing helper text below entity reference field widgets listing the field's allowed target bundles and, optionally, the bundles the current editor can create.

---

Entity Reference Field Hints improves the content-editing experience for entity reference fields. On a bundle's Manage form display, each supported reference widget gains third-party settings to turn on a hint that is rendered as the widget's standard description (help text) on the entity edit form. The hint can show an "Allowed: …" line naming the field's configured target bundles (with a configurable fallback string when the field permits every bundle) and a "You can create: …" line naming only the allowed bundles the current user has create access to. It supports `entity_reference` and `entity_reference_revisions` fields targeting media, nodes, paragraphs, taxonomy terms, and users, and enhances the stock autocomplete, select, radios, and checkboxes widgets without replacing them. The module ships as pure widget hooks plus two helper services — it adds no routes, no permissions, no site-wide configuration form, and no new plugin types.

---

- Show editors which content types an entity reference autocomplete field accepts before they start typing.
- Display allowed vocabularies/terms under a taxonomy term reference select widget.
- List which media bundles (Image, Document, Remote video) a media reference field will accept.
- Clarify which paragraph types are valid for an `entity_reference_revisions` paragraphs field.
- Show the allowed user reference targets on an author or contributor field.
- Tell an editor which of the allowed bundles they personally have permission to create inline.
- Reduce wrong selections in fields labelled generically like "Related content" or "Category".
- Surface field configuration (allowed target bundles) that is otherwise hidden from editors.
- Enable hints per widget on a bundle's Manage form display page.
- Provide a custom fallback message for reference fields that allow all bundles of a target type.
- Use the `@target_type` token in the fallback message to name the target entity type in plural.
- Keep the standard entity reference widget while adding only descriptive help text.
- Combine allowed-bundle and create-permission hints on the same field.
- Show hints only on entity form widgets, not on the default-value widget in field settings.
- Append the hint after any existing widget description rather than overwriting it.
- Give new or occasional editors context so they need less training on complex content models.
- Help multi-bundle reference fields where the target type spans many content types.
- Improve accessibility of reference fields by putting valid targets in the field help text.
- Turn hints on or off individually so only the fields that need guidance display it.
- Confirm at a glance, from the form-display settings summary, whether hints are enabled for a widget.
- Support Drupal 10.3, 11, and 12 with only the core Field module as a dependency.
- Guide editors toward creatable bundles when an inline-create workflow is available.
- Document allowed targets for editorial handbooks straight from the live edit form.
- Avoid custom preprocess or theme overrides just to add reference-field help text.
