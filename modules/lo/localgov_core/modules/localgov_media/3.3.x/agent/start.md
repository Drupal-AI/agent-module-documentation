# LocalGov Media — agent index

Submodule of **localgov_core**. A configuration bundle for the LocalGov media stack: `image`,
`document`, `remote_video` media types, image/responsive-image/crop styles, a `wysiwyg` CKEditor5
format + Linkit profile, and media admin views. Mostly shipped config; `container_rebuild_required`.
Depends on ckeditor5, editor, media_library, media_library_edit, responsive_image, image_widget_crop,
linkit. No config route of its own; manage via core media/image-style admin.

Key facts:
- Media types (config/optional): `media.type.image|document|remote_video` with fields `field_media_image`, `field_media_document`, `field_media_oembed_video`.
- Ships many `image.style.*`, `responsive_image.styles.*`, `crop.type.*`, plus `filter.format.wysiwyg` + `editor.editor.wysiwyg` and `linkit.linkit_profile.default`; admin views `views.view.files` / `views.view.media`.
- `hook_modules_installed`: force-installs optional config and grants `use text format wysiwyg` to the authenticated role.
- `hook_localgov_roles_default()`: grants author/contributor/editor roles media create/edit/delete perms.
- `FilesLocalTasks` derivative + `menu_links_discovered_alter` move the "Files" listing under Media.
