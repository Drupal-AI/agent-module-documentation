File Field Sources extends Drupal's File and Image field widgets so that, instead of only uploading from your computer, editors can populate a file field from other sources — a remote URL, an existing file reference, a server directory, the IMCE file browser, or the clipboard.

---

The module defines a `FilefieldSource` plugin type (annotation `@FilefieldSource`, manager `plugin.manager.filefield_sources` aliased `filefield_sources`) and ships five source plugins: **remote** (download from a URL), **reference** (autocomplete an existing managed file by name), **attach** (pick a file from a server directory), **imce** (choose via the IMCE file browser, if IMCE is installed), and **clipboard** (paste a file). Core's own **upload** is always present as the default. Sources are enabled **per field widget**: via `hook_field_widget_third_party_settings_form()` it adds a "File sources" details element (a checkbox list of sources plus each source's own settings) to the widget settings of supported widgets — by default `file_generic` and `image_image` (extendable through `hook_filefield_sources_widgets()`). The choice is stored as a third-party setting on the widget component in the `entity_form_display` config: `content.<field>.third_party_settings.filefield_sources.filefield_sources.sources` (a map of enabled source ids) alongside per-source setting groups like `source_attach`, `source_reference`, `source_remote`. At form build time `hook_field_widget_single_element_form_alter()` attaches those settings to the element and a `#process` callback (`filefield_sources_field_process`) injects each enabled source's UI and value/process callbacks (from the plugin's static `value()`/`process()` methods). Source plugins may also declare their own routes via a static `routes()` method (collected by `FilefieldSourcesRoutes`), e.g. for autocomplete/browse endpoints. There is no global settings page (`configure: null`); `hook_filefield_sources_sources_alter()` lets modules filter the available sources per field.

---

- Let editors add a file to a File field by pasting a remote URL for the module to download.
- Reuse an already-uploaded file in a new node by referencing it via autocomplete.
- Populate an Image field from a file sitting in a server directory ("File attach").
- Browse and pick a file with the IMCE file browser directly in a file widget.
- Paste an image from the clipboard into an Image field.
- Enable multiple sources on one widget so editors choose how to supply each file.
- Avoid re-uploading large files by referencing existing managed files.
- Import files placed on the server by an external process via the attach source.
- Bulk-populate media by dropping files into a watched server directory and attaching them.
- Configure which sources are available per content type via its form display.
- Offer a "Remote URL" option for editors syndicating images from another site.
- Restrict a widget to only the reference source to enforce file reuse.
- Add File Field Sources support to a custom file widget via hook_filefield_sources_widgets().
- Filter out sources a given user shouldn't see with hook_filefield_sources_sources_alter().
- Provide autocomplete matching on existing file names when referencing files.
- Attach files from an absolute or relative server path depending on attach settings.
- Let content teams pull documents from a shared server folder into nodes.
- Reduce storage duplication by referencing one file across many entities.
- Give an Image field both Upload and Remote URL options simultaneously.
- Migrate editorial workflows that rely on FTP-dropped files into the Drupal UI.
- Deploy the per-widget source configuration with exported form-display config.
- Implement a custom FilefieldSource plugin for an in-house file provider.
- Keep the default Upload option while adding extra sources beside it.
- Enable clipboard pasting for quick screenshot attachments on support content.
