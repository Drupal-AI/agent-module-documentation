Adds a "Select All" toolbar button (and the Ctrl/Cmd+A shortcut, scoped to the editor) to CKEditor 5 in Drupal, letting editors select every bit of content inside a rich-text field in one action.

---

CKEditor 5 Select All is a tiny, zero-configuration module that surfaces CKEditor 5's built-in `SelectAll` feature as a drag-and-drop Drupal toolbar button. It ships no PHP class and no JavaScript of its own: the whole integration is a single YAML plugin definition (`ckeditor5_select_all.ckeditor5.yml`) that binds a Drupal toolbar item to the upstream `selectAll.SelectAll` plugin already bundled with CKEditor 5 in Drupal core. Because the plugin declares `elements: false`, it adds no HTML tags and therefore needs no changes to a text format's allowed-HTML filter. You enable it once, then add the **Select All** button to whichever text formats should have it via the standard CKEditor 5 toolbar configuration UI — so which editors get the button is a per-format decision, not a site-wide one. Once placed, clicking the button (or pressing Ctrl/Cmd+A while focus is inside the editor) selects all content within that editor widget without spilling over into the rest of the page. The module has no settings form, no permissions, no routes, no services, and no server-side data handling — its config schema is an empty mapping. It depends only on core `ckeditor5` and targets Drupal `^10 || ^11`.

---

- Give content editors an explicit, discoverable button to select all text in a rich-text field instead of relying on a keyboard shortcut.
- Let pointer-only or touch users select an entire editor's content without a keyboard.
- Provide an accessible, assistive-technology-friendly control for the select-all operation.
- Quickly clear an entire CKEditor 5 field before pasting replacement content.
- Select everything, then apply a single formatting change (e.g. font, alignment) to the whole body at once.
- Copy the full contents of one editor to paste elsewhere.
- Replace a whole draft in one motion during content revisions.
- Avoid the browser's page-wide select-all when focus drifts outside the editor area.
- Standardize the select-all affordance across Basic HTML, Full HTML, and custom text formats.
- Add the button only to specific text formats (e.g. Full HTML for power users) while leaving others untouched.
- Speed up bulk edits in long-form article bodies where manual selection is tedious.
- Support editors migrating from other WYSIWYG editors that had a visible select-all control.
- Offer a consistent toolbar-based workflow for editors who prefer buttons over shortcuts.
- Reduce mis-selections in nested or media-heavy editor content by using a scoped select-all.
- Enable Ctrl/Cmd+A behavior inside CKEditor 5 fields on custom node, comment, or block forms.
- Include the button in decoupled or embedded CKEditor 5 setups configured through Drupal text formats.
- Add a select-all control to CKEditor 5 fields used in webforms or paragraphs.
- Provide a training-friendly, self-evident editing control for non-technical authors.
- Improve editing ergonomics for very large blocks of pasted content.
- Ship a lightweight dependency-free enhancement without downloading any external JS library.
