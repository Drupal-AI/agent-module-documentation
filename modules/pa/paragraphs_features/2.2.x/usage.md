Paragraphs Features adds editor-experience enhancements to the Paragraphs widget — add-in-between buttons, delete confirmation, a single-action button, drag-and-drop, and a CKEditor 5 "Split paragraph" tool.

---

The contrib Paragraphs module gives editors a repeatable field widget for building structured content, and Paragraphs Features layers usability improvements on top of it without replacing it. Most features are toggled per field via the Paragraphs widget's **third-party settings** on a form display: **Add in between** inserts "+ Add" buttons between existing paragraphs (with a configurable number of type links) so new items land exactly where you want; **Delete confirmation** shows a confirm step before removing a paragraph; **Show drag & drop** exposes Paragraphs' advanced drag-and-drop reorder UI (needs `core/sortable`); and a collapse-all toggle is available too. A single **global** setting (Admin → Configuration → Content authoring → Paragraphs features) reduces the actions drop-down to a plain button whenever only one action is available, saving a click. It also ships a CKEditor 5 **Split paragraph** toolbar plugin that lets an editor split a text paragraph into two at the cursor. The module works by altering the Paragraphs widget through Drupal field-widget hooks and attaching JavaScript libraries; it adds no new entity types or permissions and stores its options as ordinary configuration.

---

- Add a paragraph precisely between two existing ones with in-between buttons.
- Configure how many paragraph-type links show in the add-in-between control.
- Require a confirmation step before an editor deletes a paragraph.
- Prevent accidental loss of content in long paragraph lists.
- Collapse the single-option actions drop-down into a one-click button site-wide.
- Enable advanced drag-and-drop reordering of paragraphs.
- Add a collapse-all / expand-all control to a paragraphs field.
- Let editors split a rich-text paragraph in two from the CKEditor 5 toolbar.
- Speed up building long landing pages made of paragraphs.
- Improve the authoring UX of a page-builder built on Paragraphs.
- Turn on features per field/form display rather than globally.
- Keep different paragraph fields with different feature sets.
- Reduce clicks when a paragraph only offers a "Remove" action.
- Insert a new hero/section block at a chosen position mid-page.
- Give content teams a safer delete flow on complex layouts.
- Add drag-and-drop only where the sortable library is available.
- Enable the split tool so editors break one text block into two paragraphs.
- Standardize authoring ergonomics across a multisite Paragraphs setup.
- Export the per-widget feature settings as configuration.
- Pair with the Gin admin theme for a polished editing experience.
- Configure add-in-between behavior for a specific content type's body.
- Cut down support requests by making paragraph reordering intuitive.
- Provide a confirmation dialog to satisfy editorial governance rules.
- Reduce mis-clicks in the paragraphs actions menu for new editors.
