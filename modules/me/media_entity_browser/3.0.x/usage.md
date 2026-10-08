Media Entity Browser ships ready-made Entity Browser configurations for core Media, giving editors a searchable, thumbnail grid to pick and embed media in WYSIWYG fields and media reference fields.

---

The module is essentially a package of configuration (an Entity Browser, a supporting View, an image style, and an Entity Embed button) rather than PHP logic. On install it provides two browsers — an iFrame browser for WYSIWYG embedding and a modal browser for use with Inline Entity Form "complex" media reference widgets — both driven by the `media_entity_browser` View that lists existing Media entities as a styled thumbnail grid. It builds on Entity Browser, Inline Entity Form, Entity Embed and core Media/Views, adding custom CSS and JS (a preprocess hook attaches `media_entity_browser/view`) to make the grid feel like a media picker. The browser is not visible until you wire it into an Entity Embed button or a media reference field's form widget. Because everything is config, once installed you customize the browser through Entity Browser's own admin UI (`/admin/config/content/entity_browser`) and manage changes as exported configuration. An optional submodule, `media_entity_browser_media_library`, offers an alternative browser whose UX mirrors core Media Library for WYSIWYG embedding. It is a lightweight bridge that predates full core Media Library WYSIWYG support and is intended to fill that gap.

---

- Add a "browse media" picker to a CKEditor field via an Entity Embed button.
- Let editors insert existing images into rich text without re-uploading.
- Provide a modal media picker for a media reference field using Inline Entity Form.
- Display available media as a searchable thumbnail grid instead of an autocomplete.
- Embed videos, documents, or remote media through the WYSIWYG editor.
- Reuse a single uploaded image across many nodes instead of duplicating files.
- Give content authors a consistent media-selection UX across content types.
- Style the media grid with the bundled CSS/JS to match a media library look.
- Configure an iFrame browser for in-editor embedding.
- Configure a modal browser for entity-reference field widgets.
- Filter selectable media by type through the underlying View.
- Add pagination to the media picker for large media libraries.
- Serve as a starting-point config you clone and customize per project.
- Restrict which media bundles appear in the browser by editing the View.
- Combine with Entity Embed to place captioned, aligned media in body text.
- Swap the default browser for the Media Library-styled variant (submodule).
- Bridge WYSIWYG media embedding until core Media Library covers it.
- Provide a thumbnail preview image style (`media_entity_browser_thumbnail`).
- Export and deploy a standard media browser across environments as config.
- Let multiple editors share a common pool of reusable media assets.
- Attach a media picker to custom entity types that reference media.
- Give decoupled/editorial workflows a controlled media selection UI.
- Offer a modal "add or select" media flow inside inline entity forms.
- Replace the default file upload widget with a browse-existing-media flow.
- Prototype a media library experience without writing custom Views/Entity Browser config.
