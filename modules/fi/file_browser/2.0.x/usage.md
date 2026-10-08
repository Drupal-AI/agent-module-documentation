File Browser ships a ready-made, Media-library-style Entity Browser for files: a responsive Masonry grid of existing images/files to select from, plus a DropzoneJS upload tab. You attach it to any File, Image, or entity-reference field as its form widget.

---

File Browser is a thin configuration layer on top of Entity Browser, Entity Embed, and DropzoneJS that recreates the Drupal 7 media-library experience on the modern Drupal 10/11 stack. Enabling the module installs a pre-built Entity Browser named `browse_files` (an iframe display) and a `browse_files_modal` variant (modal display), both driven by a shipped View (`views.view.file_entity_browser`) over the `file_managed` table. The browser presents two tabs: a "Files listing" tab that renders a mobile-ready Masonry grid of file thumbnails (built with the Masonry and imagesLoaded JS libraries) where editors click to select, and an "Upload files" tab powered by the DropzoneJS Entity Browser widget for drag-and-drop uploads to `public://`. Selected files flow back through a multi-step selection display using the shipped `file_entity_browser_small` and `file_entity_browser_thumbnail` image styles. To use it, a site builder switches a field's form widget to Entity Browser (or File Browser) and picks the "Browser for files" entity browser. The module also registers an `image_embed` block plugin and an `embed.button.file_browser` Embed button so images can be embedded into rich text via Entity Embed, and a `file_browser_preview` Views field plus a preview controller route for the full-size file preview. There is no admin settings form of its own — all tuning happens on the shipped Entity Browser, View, and field-widget config. The required external JS libraries (Masonry, imagesLoaded, Backbone, Underscore) are managed via `composer.libraries.json` or downloaded into `/libraries`.

---

- Give an Article's image field a Media-library-style picker instead of the plain file upload widget.
- Let editors browse all previously uploaded files in a responsive Masonry thumbnail grid and click to select.
- Provide drag-and-drop file uploads inside the browser via the DropzoneJS "Upload files" tab.
- Attach the ready-made `browse_files` Entity Browser to any File or Image field's form widget.
- Attach the browser to an entity-reference field that targets file entities.
- Offer a modal-style file browser (`browse_files_modal`) instead of the inline iframe display.
- Select multiple files at once from the grid for a multi-value field.
- Restrict uploads to specific extensions (default `jpg jpeg gif png txt doc xls pdf ppt pps odt ods odp`) via the DropzoneJS widget settings.
- Upload new files straight into `public://` (configurable upload location on the widget).
- Embed a browsed image into CKEditor rich text using the shipped `file_browser` Embed button (Entity Embed).
- Place an "Image Embed" block that lets an editor pick and render an image via the File Browser.
- Reuse the shipped `file_entity_browser` View to customise which files appear, their sort, filters, or pager.
- Swap the grid thumbnail sizing by editing the `file_entity_browser_small` / `file_entity_browser_thumbnail` image styles.
- Preview a file at full size from the browser through the `file_browser.preview` route/controller.
- Add a preview column to a custom file-listing View with the `file_browser_preview` Views field.
- Recreate the Drupal 7 media library UX on a Drupal 10/11 site without writing custom Entity Browser config.
- Give content editors an intuitive, mobile-ready interface for choosing existing site imagery.
- Standardise how images are selected across many content types by pointing their fields at one browser.
- Enable the `file_browser_example` submodule to see a working, pre-wired demo block and field.
- Manage the required JS libraries (Masonry, imagesLoaded, Backbone, Underscore) with the bundled `composer.libraries.json`.
- Use the DropzoneJS description text ("Click or drop files here to upload them") as an inline upload hint for editors.
- Provide auto-select on click so choosing a thumbnail immediately adds it to the selection.
- Serve as the file-picking layer for a decoupled editorial workflow built on Entity Browser + Entity Embed.
