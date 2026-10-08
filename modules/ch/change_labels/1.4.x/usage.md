Change labels lets site builders override the labels and button texts shown on Drupal entity forms, configured per form-display mode and per field widget, without writing code.

---

Change labels adds extra, context-aware string overrides on top of Drupal's normal interface translation. Rather than translating a string globally, it stores the replacement as a third-party setting on the field widget (in "Manage form display") or on the entity form display itself, so the same label can read differently on different content types, view modes, or widgets. It can overwrite or hide a field's label, rename or hide the "Add another item" button on multivalue fields, force a multivalue widget to act as single-value, rename the "Remove" button on file/image widgets, resize number-field inputs, rename the form's "Save"/"Submit" button, and (experimentally) replace the status message shown after a save. All changes are display-only: machine names, stored data, cardinality storage, and access are untouched, and every override is plain Drupal configuration (exportable and deployable).

---

- Rename the "Add another item" button on a multivalue field to something domain-specific, e.g. "Add another team member".
- Hide the "Add another item" button entirely for a specific widget while keeping the field multivalue.
- Force a multivalue widget to present only a single item (hides the delta weight controls) without changing field storage cardinality.
- Overwrite a field's visible label per widget/form mode while leaving the field machine name intact.
- Hide a field label completely by entering the token `<nolabel>` in the "Overwrite field label" box.
- Give the same reused field different labels on different content types or form modes.
- Rename the "Remove" button on file and image upload widgets (e.g. to "Delete attachment").
- Change the input box size (`#size`) of number-field widgets to make them narrower or wider.
- Rename the "Save" / "Submit" button of a content entity form per form-display mode (e.g. "Publish story").
- Replace the post-save status message (experimental) — suppress the default "Article X has been created" and show a custom confirmation instead.
- Tailor node, media, taxonomy term, user, comment, or any content-entity form labels through its form display.
- Localize or reword editorial UI wording for a specific team without touching global string translation.
- Improve accessibility wording of a widget label for a particular form without a theme override.
- Provide clearer instructions to editors by relabeling generic core buttons on a per-workflow basis.
- Prepare per-form label configuration as part of a config-managed deployment (labels live in the display config entity).
- Migrate away from the Custom add another module (no D11 release) to a more flexible label store.
- Set up a "compact" alternate form mode with hidden labels and single-item widgets for inline/embedded editing contexts.
- Rename buttons in bespoke content types (events, products, listings) so the form language matches the domain.
- Combine a hidden field label with a custom widget description to simplify a busy edit form.
