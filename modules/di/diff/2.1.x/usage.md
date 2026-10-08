Diff adds a "Revisions" comparison UI that shows exactly what changed between any two revisions of a node or other revisionable entity, field by field, in several selectable layouts.

---

Drupal core tracks content revisions but only lets you view or revert them — it never shows *what* actually changed. Diff fills that gap by rendering a side-by-side or inline comparison of two revisions, breaking every field down into human-readable strings and highlighting additions and deletions. Comparisons are produced by two plugin types: **FieldDiffBuilder** plugins (one per field type — text, image, file, link, list, entity reference, comment, taxonomy, etc.) turn field values into comparable text, and **DiffLayoutBuilder** plugins (Split fields, Unified fields, and Visual inline) control how the result is displayed. Site builders enable and weight layouts and tune per-field comparison options at Admin → Configuration → Content authoring → Diff (routes `diff.general_settings` and `diff.fields_list`). The heavy lifting for rendered "visual" diffs relies on the external `php-htmldiff-advanced` library. Everything is exposed on the entity's revision overview page, and the module integrates with Views via diff field handlers. Developers extend it by adding FieldDiffBuilder plugins for custom field types or new DiffLayoutBuilder layouts, and can alter registered plugins through two info-alter hooks.

---

- Compare two node revisions field-by-field on the revisions tab.
- See exactly which words changed in a body/text field between edits.
- Review edits before reverting a node to an older revision.
- Audit who changed what across an entity's revision history.
- Display a unified line-by-line diff of a revision.
- Display a two-column split-field diff of a revision.
- Show a rendered "visual inline" diff of the entity as it appears on the page.
- Tune how many leading/trailing context lines surround each change.
- Enable or disable specific diff layouts site-wide and order them by weight.
- Configure image field comparisons to include alt, title, or thumbnail.
- Configure file field comparisons to include the file ID or description.
- Compare the text format alongside the value of a formatted text field.
- Compare the summary of a text-with-summary field separately.
- Compare link fields by URI and/or title.
- Compare entity reference fields by referenced label or ID.
- Compare taxonomy term reference fields by name or term ID.
- Set the revisions-per-page limit on the diff pager for long histories.
- Support content moderation workflows by reviewing draft-vs-published changes.
- Add revision-diff comparison to custom revisionable entity types.
- Write a FieldDiffBuilder plugin so a custom field type diffs cleanly.
- Add a new DiffLayoutBuilder layout for a bespoke comparison display.
- Alter another module's diff builder labels via hook_field_diff_builder_info_alter().
- Expose "from/to" revision diff links as fields in a View.
- Choose the radio-button selection behavior on the revision overview form.
- Pick which view mode drives the visual inline comparison.
