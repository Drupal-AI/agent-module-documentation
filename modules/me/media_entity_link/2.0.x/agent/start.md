<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Entity Link — agent index

Adds a `link` **media source plugin** and ships a ready-made **Link** media type so
internal/external URLs are stored as reusable media. Installs its config in `config/install`,
so it works with **no configuration**. No permissions, no Drush, no settings form, no
`configure` route (`configure: null`). Depends on core `media`, `media_library`, `link`,
`image`, `path`.

- **The shipped Link media type, its source field, and how to restrict internal/external links** →
  [configure/link-media-type.md](configure/link-media-type.md)
- **The `link` MediaSource plugin, the Media Library add form, and the OOP hooks** →
  [api/source-and-forms.md](api/source-and-forms.md)

Key facts:
- Media type: `media.type.link` (id `link`, `source: link`).
- Source field: `field_media_entity_link` (core `link` field type, cardinality 1) on the
  `link` bundle; config `field.field.media.link.field_media_entity_link`.
- Allowed link kinds come from the core Link field setting `link_type`
  (`1` = internal, `16` = external, `17` = both/generic — shipped default is `17`).
- Source plugin class `MediaEntityLink` (`@MediaSource(id = "link")`), custom add form
  `LinkMediaLibraryAddForm` (form id `media_entity_link_media_library_add`).
- A Link media entity is just a `name` + the `field_media_entity_link` URL; access uses core
  Media permissions.
