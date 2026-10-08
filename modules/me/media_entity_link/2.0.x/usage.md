<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Entity Link adds a `link` media source plugin and a ready-made **Link** media type, so internal and external URLs can be stored as reusable media, browsed in the Media Library, and referenced anywhere media is supported.

---

On install the module ships (as `config/install`) a complete **Link** media type (`media.type.link`) whose source is the `link` media source plugin (`MediaEntityLink`, `@MediaSource(id="link")`), plus a `link` source field `field_media_entity_link` (core `link` field type, cardinality 1) and default form/view displays — so there is nothing to configure to start using it. Each Link media entity is essentially a name plus a URL; the URL field's allowed **link type** (internal, external, or both) comes from the standard core Link field setting (`link_type`) on `field.field.media.link.field_media_entity_link`, which you can change under *Manage fields*. The module registers a custom Media Library "add" form (`LinkMediaLibraryAddForm`, form id `media_entity_link_media_library_add`) that gives the URL box the same internal/external/`<front>`/`<nolink>`/`<button>` autocomplete behaviour as a normal link widget, and a `form_alter`/`help` hook pair (implemented as OOP hooks in `MediaEntityLinkHooks`) that tidy the media name field. There are **no permissions, no Drush commands, and no settings form** of its own (media access is governed by core Media's own permissions). It depends on core `media`, `media_library`, `link`, `image`, and `path`. Typical use is a "resources"/link library where editors reference web pages the way they reference images or videos.

---

- Store an external URL (e.g. a documentation page) as a reusable Media entity.
- Add internal links (to nodes or paths) as media that editors can pick from the Media Library.
- Build a "resources" section that references web pages the same way it references images/PDFs.
- Let editors insert a link via the Media Library button in CKEditor / media reference fields.
- Reuse a single canonical URL across many pages by referencing one Link media entity.
- Include link media in Media views alongside images and documents.
- Restrict the Link media type to external URLs only (set the link field's link type to External).
- Restrict the Link media type to internal paths only (set the link field's link type to Internal).
- Allow both internal and external links (the shipped default, `link_type: 17`).
- Add extra fields (description, category, thumbnail) to the Link media type at *Manage fields*.
- Give a Link media a friendly name distinct from its raw URL.
- Curate a shared library of approved outbound links managed as media.
- Reference the same external resource from multiple content types via a media reference field.
- Use `<front>`, `<nolink>`, or `<button>` special link tokens when adding a Link in the Media Library.
- Autocomplete a node title to create an internal link media without knowing its path.
- Provide a media source for URLs so link management gets Media's revisioning and access control.
- Surface links in the Media Library grid for consistent editorial UX.
- Migrate a list of bookmark/resource URLs into Link media entities.
- Attach Link media to a paragraph or layout component that expects a media reference.
- Theme the Link media view display (the source field renders with the core `link` formatter).
- Track and update outbound URLs in one place instead of scattered link fields.
- Add a Link media programmatically by creating a `media` entity of bundle `link`.
- Combine with the Media Library form element to pick links in custom forms.
- Present links to editors without teaching them Drupal path syntax (the add form explains the tokens).
