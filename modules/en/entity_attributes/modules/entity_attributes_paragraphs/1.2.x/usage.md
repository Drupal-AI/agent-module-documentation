Entity Attributes Paragraphs is a submodule that lets the Entity Attributes module manage HTML attributes on Paragraphs entities.

---

This submodule plugs Paragraphs into the Entity Attributes system. It adds a `paragraph` EntityAttributes plugin (`ParagraphAttributes`, extending `ContentEntityAttributesBase`) so paragraph bundles can be enabled on the Entity Attributes settings form and get the YAML "Attributes" field, and it implements `hook_preprocess_paragraph` (`entity_attributes_paragraphs\Hook\PreprocessHooks`) that hands each paragraph to the shared `entity_attributes.processor` service, merging the stored attributes into the paragraph's template variables. It requires the base `entity_attributes` module and `paragraphs`.

---

- Enable HTML attributes on selected paragraph bundles.
- Add a CSS class to individual paragraph items for component styling.
- Give a paragraph a stable `id` for anchoring or scripting.
- Attach `data-*` attributes to a paragraph for a JS library.
- Add ARIA/semantic attributes to paragraph markup.
- Manage paragraph attributes from the same UI as nodes, blocks and menus.
- Store per-paragraph attributes in the standard paragraph field.
- Let chosen roles edit paragraph attributes via the per-bundle permission.
- Print paragraph attributes in a paragraph Twig template with `{{ attributes }}`.
- Avoid writing custom preprocess code for paragraph attribute handling.
- Apply consistent attribute management across paragraph and non-paragraph entities.
- Prototype paragraph markup tweaks without editing theme templates.
- Turn attribute support on or off per paragraph bundle.
- Validate paragraph attribute YAML on save.
- Reuse the base module's CodeMirror editor option for paragraph attributes.
