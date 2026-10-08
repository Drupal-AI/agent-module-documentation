Adds an "Augmentors" dropdown button to the CKEditor 4 toolbar so editors can run a selected Augmentor plugin on the currently selected text.

---

`augmentor_ckeditor4` is the CKEditor 4 integration submodule of the Augmentor framework. It registers a `@CKEditorPlugin` (`augmentor_ckeditor`, class `AugmentorCKEditor`) that contributes a searchable rich-combo dropdown button to the CKEditor 4 toolbar. Per text-format editor, an admin picks which configured augmentors appear in the dropdown via the plugin's settings form. At runtime the bundled `plugin.js` reads the editor's current text selection and POSTs it, plus the chosen augmentor UUID, to the parent module's execute endpoint (`augmentor.augmentor_execute`); the returned text is appended into the editor content. The submodule ships only a CKEditor plugin, a JS file, an icon and a small CSS file — all augmentor execution, provider configuration and permissions live in the parent `augmentor` module. This submodule is marked **deprecated** in favour of `augmentor_ckeditor5` (see issue 3469771); use it only on sites still running the legacy CKEditor 4.

---

- Add an AI "Augmentors" dropdown button to a CKEditor 4 text format toolbar.
- Let editors transform selected body text with a configured augmentor (summarise, rewrite, translate, tag, etc.) without leaving the editor.
- Expose only a curated subset of augmentors per text format by ticking them in the editor's Augmentor settings form.
- Provide a per-editor, checkbox-driven list of allowed augmentors for the toolbar dropdown.
- Give content editors a searchable dropdown (type-to-filter) when many augmentors are configured.
- Run an augmentor against a text selection and append the AI output as new paragraphs at the end of the editor content.
- Keep legacy CKEditor 4 formats working with Augmentor while migrating a site to CKEditor 5.
- Reuse the site's existing augmentor definitions (from the parent module's `/admin/config/augmentors` list) directly inside the WYSIWYG.
- Offer one-click access to summarisation/generation augmentors for authors editing nodes, blocks or any entity using a CKEditor 4 format.
- Support multi-select of augmentors in the toolbar combo so several augmentors are reachable from one button.
- Display a full-screen AJAX progress indicator while an augmentor call is in flight.
- Surface augmentor/API errors back to the editor as Drupal messages.
- Integrate AI text tooling into moderation/authoring workflows that still rely on CKEditor 4.
- Serve as the CKEditor 4 counterpart to the field widgets provided by the parent module for structured fields.
- Let a themer style the toolbar dropdown via the module's `augmentor_ckeditor` CSS library.
- Act as a reference for how a CKEditor 4 `@CKEditorPlugin` wires a toolbar button to a Drupal AJAX route.
