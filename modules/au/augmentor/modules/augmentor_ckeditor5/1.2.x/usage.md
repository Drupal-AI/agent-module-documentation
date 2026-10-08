Adds an "Augmentors" dropdown to the CKEditor 5 toolbar so editors can run a configured Augmentor plugin on the current text selection, inserting the AI output at the cursor.

---

`augmentor_ckeditor5` is the CKEditor 5 integration submodule of the Augmentor framework. It provides a CKEditor 5 plugin (`Drupal\augmentor_ckeditor5\Plugin\CKEditor5Plugin\Augmentor`, machine `augmentor_ckeditor5_augmentor`) and the compiled front-end plugin under `js/build/augmentor.js`. A toolbar dropdown lists the augmentors an admin enabled for the text format; selecting one sends the current selection to the parent module's execute endpoint and inserts the returned text at the last selection position. The plugin is exposed only to users who hold the parent module's `execute augmentor` permission — `hook_ckeditor5_plugin_info_alter()` (in `AugmentorCkeditor5Hooks`) removes the plugin definition entirely for anyone lacking it. Per-format augmentor selection is stored in the editor config with a config schema (`ckeditor5.plugin.augmentor_ckeditor5_augmentor`). All augmentor execution, provider configuration, API keys and permissions live in the parent `augmentor` module; this submodule only wires the editor UI to it. This is the current, non-deprecated editor integration (replacing `augmentor_ckeditor4`).

---

- Add an AI "Augmentors" dropdown button to a CKEditor 5 text format toolbar.
- Let editors run a configured augmentor (summarise, rewrite, translate, generate tags, etc.) on selected text from inside the WYSIWYG.
- Insert the augmentor's output at the last selection position rather than appending at the end.
- Expose a curated per-format subset of augmentors via the editor plugin's checkbox settings form.
- Hide the augmentor toolbar entirely from users who lack the `execute augmentor` permission.
- Provide a searchable/scannable dropdown listing the enabled augmentors by label.
- Show a full-screen AJAX progress indicator while an augmentor request is running.
- Surface augmentor and API errors back to the editor as dismissible Drupal messages.
- Give CKEditor 5 sites the same in-editor AI tooling that `augmentor_ckeditor4` offered on legacy CKEditor 4.
- Reuse existing augmentor definitions (from `/admin/config/augmentors`) directly in the editor without re-declaring them.
- Automatically drop deleted/invalid augmentors from a format's stored config at render time.
- Convert newlines in AI output to `<br/>` so multi-line results render correctly in CKEditor 5.
- Integrate AI text assistance into node, block, paragraph or any entity edit form using a CKEditor 5 format.
- Serve as a reference implementation of a configurable CKEditor 5 plugin backed by a Drupal AJAX route.
- Let a themer style the toolbar dropdown via the module's admin CSS library.
- Restrict AI feature availability by simply granting/revoking one permission per role.
