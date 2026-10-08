Submodule of Media Entity Browser that provides an alternative Entity Browser whose UX mirrors core Media Library, aimed at WYSIWYG media embedding.

---

This optional submodule adds a second browser, `media_entity_browser_media_library`, backed by its own View that reuses core Media Library's look and behavior. It exists to close the gap in WYSIWYG (CKEditor) media embedding until core Media Library covers that case directly; for media reference fields the recommendation is to use core's Media Library widget instead. Like the parent module it is almost entirely configuration: a preprocess hook attaches core `media_library/view` plus the submodule's own styling library, and a form-alter fixes the exposed filter's submit button. It depends on core `media_library` in addition to Entity Browser, Inline Entity Form, Media and Views. You wire it into an Entity Embed button to expose it in the WYSIWYG. Once core provides native WYSIWYG media embedding this submodule is expected to be deprecated.

---

- Give editors a Media Library-styled picker for WYSIWYG embedding.
- Match the core Media Library UX inside CKEditor media embeds.
- Provide a nicer thumbnail/grid browser than the default iFrame browser.
- Fill the WYSIWYG embedding gap until core Media Library supports it.
- Wire a Media Library browser into an Entity Embed button.
- Reuse existing media in rich text with a familiar library interface.
- Search and filter media using Media Library's exposed filters.
- Offer consistent media selection between fields (core widget) and WYSIWYG (this browser).
- Style the browser via the bundled `media_entity_browser_media_library/view` library.
- Migrate existing entity browsers to the Media Library-styled View.
- Preview media thumbnails in a responsive grid when embedding.
- Let authors pick videos or documents through the library UI in body text.
- Deploy the alternative browser as exportable configuration.
- Prototype a WYSIWYG media library without custom Entity Browser config.
- Provide an upgrade path aligned with core Media Library conventions.
- Serve as a drop-in replacement browser for the default media_entity_browser view.
