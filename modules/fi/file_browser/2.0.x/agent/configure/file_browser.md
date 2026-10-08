# file_browser — configure

File Browser has **no settings form of its own** (`configure` is `null`). Enabling it installs
ready-made config you attach to fields and tune through Entity Browser / Views / field-widget UIs.

## What enabling the module installs

Default config in `config/install/`:

- **`entity_browser.browser.browse_files`** — the main browser, label "Browser for files".
  `display: iframe`, `auto_open: true`, `widget_selector: tabs`, `selection_display: multi_step_display`
  (entity_type `file`, thumbnail display via image style `file_entity_browser_small`). Two widgets:
  - `view` widget → View `file_entity_browser`, display `entity_browser_1`, `auto_select: true` ("Files listing").
  - `dropzonejs` widget → upload to `public://`, description "Click or drop files here to upload them",
    `extensions: 'jpg jpeg gif png txt doc xls pdf ppt pps odt ods odp'` ("Upload files").
- **`entity_browser.browser.browse_files_modal`** — same widgets, `display: modal` (1100×650), `auto_open: false`.
- **`views.view.file_entity_browser`** — View over `file_managed` (base field `fid`), 25/page, the grid source.
- **`image.style.file_entity_browser_small`** and **`image.style.file_entity_browser_thumbnail`** — grid/preview thumbnails.
- **`embed.button.file_browser`** — Entity Embed button (type `entity`, entity_type `file`) for embedding images in rich text.

## Attach the browser to a field (the main task)

1. Go to **Manage form display** for a bundle with a File, Image, or entity-reference field
   (e.g. Structure → Content types → Article → Manage form display).
2. Set that field's widget to **Entity Browser** (Entity Browser's `entity_browser_entity_reference` /
   file widget) — or **File Browser** if that widget is offered.
3. Open the widget's gear/settings and select **Browser for files** (the `browse_files` entity browser)
   from the "Entity browser" dropdown. Save.

The field now shows a "Select files" button that opens the Masonry grid + Dropzone upload browser.
Choose `browse_files_modal` instead if you want a modal rather than the inline iframe.

## Customising behaviour

- **Which files appear / sort / filters / pager** → edit the `file_entity_browser` View.
- **Allowed upload extensions or upload location** → edit the `dropzonejs` widget settings on the browser.
- **Grid / preview thumbnail size** → edit the `file_entity_browser_small` / `file_entity_browser_thumbnail` image styles.
- **Rich-text image embedding** → use the shipped `file_browser` Embed button (Entity Embed), or place the
  `image_embed` block ("Image Embed", category Embed).

## The FileBrowser field widget plugin

The module defines a `file_browser` FieldWidget (id `file_browser`, for `file` and `image` field types) that
extends Entity Browser's `FileBrowserWidget`. Its `isApplicable()` only offers this widget on bundles already
using it — new fields are steered to Entity Browser's own widget instead.

## Extra endpoints / Views field

- Route `file_browser.preview` (`/admin/file-browser-preview/{file}/{image_style}`) →
  `FileBrowserController::preview`, guarded by `file.view` access, renders a full-size file preview.
- `file_browser_preview` Views field — adds a thumbnail + "Preview" link column to a file listing View.

## Required JS libraries

Masonry, imagesLoaded, Backbone, Underscore load from `/libraries` (declared in `file_browser.libraries.yml`);
manage them with the bundled `composer.libraries.json` (Wikimedia composer-merge-plugin) or download manually.
