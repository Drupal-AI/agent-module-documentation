LocalGov Media is a configuration bundle that sets up the LocalGov Drupal media stack: Image, Document, and Remote video media types, a large library of image styles / responsive image styles / crop types, manual image cropping, a WYSIWYG text format with Linkit, and a "Files" admin tab moved under Media.

---

This submodule is almost entirely shipped configuration (`config/optional/*`): the `image`, `document`, and `remote_video` media types with their fields (`field_media_image`, `field_media_document`, `field_media_oembed_video`) and form/view displays; dozens of image styles and responsive image styles (freestyle, 3:2, 28:9, square, newsroom, etc.); `crop.type.*` definitions used with `image_widget_crop` for manual cropping; a `wysiwyg` CKEditor5 text format + editor; a default Linkit profile; and `views.view.files` / `views.view.media` admin listings. On install (`hook_modules_installed`) it force-installs its optional config and grants the `use text format wysiwyg` permission to the authenticated role. It implements `hook_localgov_roles_default()` to give the LocalGov author/contributor/editor roles the appropriate create/edit/delete media permissions. A `FilesLocalTasks` derivative plus a `menu_links_discovered_alter` move the core "Files" listing to appear as a local task under Media (removing the admin_toolbar_tools duplicate). It declares `container_rebuild_required: true` and depends on ckeditor5, editor, media_library, media_library_edit, responsive_image, image_widget_crop, and linkit. No config UI of its own; manage the resulting media types/styles through the normal core admin pages.

---

- Provide ready-made Image, Document, and Remote video media types for a LocalGov site.
- Install a comprehensive set of image styles and responsive image styles.
- Enable manual image cropping with predefined crop types (16:9, 3:2, square, freestyle…).
- Ship a WYSIWYG (CKEditor 5) text format wired up with Linkit link autocomplete.
- Grant the authenticated role permission to use the WYSIWYG format on install.
- Give LocalGov editorial roles sensible media create/edit/delete permissions by default.
- Provide media library and inline media-library editing (media_library_edit).
- Offer responsive banner/hero image styles for page headers and teasers.
- Standardize newsroom/featured image renderings across a LocalGov build.
- Move the admin "Files" listing under the Media menu as a local task.
- Supply a default Linkit profile for consistent link autocomplete in rich text.
- Provide oEmbed remote video (e.g. YouTube) as a media type.
- Base document downloads on a `document` media type with a file field.
- Deliver a coherent, opinionated media configuration instead of manual setup.
- Support image derivatives for multiple aspect ratios and breakpoints.
- Reuse the bundle across LocalGov sites for consistent media handling.
