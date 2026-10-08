H5P Editor adds the in-browser H5P authoring experience: a field widget (`h5p_editor`) and the AJAX endpoints that let editors create and modify interactive H5P content and install content types from the H5P Hub without leaving Drupal.

---

This submodule of H5P provides the `h5p_editor` field widget, an alternative to the base module's upload-only `h5p_upload` widget, that embeds the full H5P editor on the entity edit form so authors can build quizzes, interactive video, presentations and other content types interactively. It wires up the editor's server side: a set of AJAX routes (`/h5peditor/{token}/{content_id}/…`) served by `H5PEditorAJAXController` for fetching library info, the content-type cache, installing a library from the Hub, uploading a library, uploading editor files, translations and filtering — plus `H5PEditor` storage/ajax/utility integration classes and a `h5peditor_library_info_build()` hook that registers the editor's front-end assets. It adds two permissions: `access h5p editor` (use the authoring widget) and `install recommended h5p libraries` (install only Hub-recommended content types). It has no configuration form of its own; you enable authoring by choosing the `h5p_editor` widget for an H5P field on the bundle's *Manage form display*. It depends on the base `h5p` module.

---

- Let content editors author an H5P quiz directly in the node form (no external tool).
- Switch an existing H5P field from upload-only to the full in-browser editor widget.
- Install new H5P content types from the Hub through the editor's library-install AJAX.
- Restrict editors to installing only Hub-recommended content types via a dedicated permission.
- Upload a custom `.h5p` library from within the editor.
- Provide translations for the editor UI via the translations AJAX endpoint.
- Gate access to the authoring experience with the `access h5p editor` permission.
- Build Interactive Video with embedded questions inside Drupal's edit form.
- Modify existing H5P content parameters interactively rather than re-uploading a package.
- Offer non-technical authors a WYSIWYG-style interface for interactive content.
- Use the editor widget on H5P fields attached to any entity type/bundle.
- Filter/validate editor content through the filter AJAX endpoint before saving.
- Fetch and cache the available content-type list for the editor's content-type selector.
- Combine with base H5P display settings to control how authored content renders.
- Upload editor images/files used inside an H5P (files AJAX endpoint).
- Empower an editorial team to maintain interactive learning content in-house.
- Author once and reuse the resulting h5p_content entity across multiple nodes.
- Grant the editor widget only to trusted roles while others keep the upload widget.
