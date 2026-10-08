<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Custom Paragraphs is a developer library for building dynamic, repeatable "add another item"
field groups in custom Drupal forms, storing the collected rows as JSON in a hidden field.

---

The module ships a front-end JavaScript class, `RepeatableFieldGroup` (exposed on the global
`window.RepeatableFieldGroup`, in `js/components/repeatable-field-group.js`), plus a small CSS
theme and a Drupal library `custom_paragraphs/custom_paragraphs`. A developer attaches the
library, adds a hidden data element and a wrapper container to their own form, and instantiates
the class in JavaScript with a field definition (text, textarea, select, checkbox, and file
fields, with optional CKEditor 5 rich-text on textareas). The widget renders the add/remove UI,
runs client-side validation, optionally rich-texts textareas via `Drupal.editors.ckeditor5`, and
serializes every row back into the hidden input as JSON on change. File fields are backed by two
AJAX endpoints served by `RepeatableFileUploadController`
(`/custom-paragraphs/repeatable-file-upload` and `/custom-paragraphs/repeatable-file-restore`)
that save uploads as permanent managed `file` entities and return their metadata (fid, filename,
uri, url) as JSON, and re-hydrate previously saved files by fid. The module has no admin settings
form, no config entities, and no permissions of its own; it is wired into forms in code.

---

- Build a repeatable "add another item" field group in a custom form.
- Collect several sets of similar inputs (addresses, team members, documents) as one JSON value.
- Store the whole group as JSON in a single hidden form field.
- Offer text, textarea, select, checkbox and file field types per row.
- Add CKEditor 5 rich-text editing to a textarea field in a repeatable row.
- Attach an AJAX file-upload widget to a repeatable row with a preview list.
- Upload one or many files per file field over AJAX and get managed-file metadata back.
- Cap a file field to a single file with the `multiple` flag.
- Restrict a file field to given extensions/MIME types with an `accept` list.
- Enforce minimum and maximum item counts (`minItems`, `maxItems`).
- Pre-populate the group from existing data (`fieldGroupDefaultValue`) when editing.
- Re-hydrate previously uploaded files by fid when re-rendering a saved form.
- Mark fields required and show per-field client-side validation messages.
- Customize labels, button text, CSS classes and wrapper ids for the generated markup.
- Number and re-number repeated item titles automatically as rows are added/removed.
- Reuse one generic field-group library across many custom forms and content types.
- Avoid the entity overhead of core Paragraphs for lightweight, form-local repeatable data.
- Return uploaded-file URLs to the editing UI so editors can open the files.
- Prefix/suffix a field with custom HTML fragments in the generated markup.
- Drive the widget entirely client-side and read the JSON value on form submit.
