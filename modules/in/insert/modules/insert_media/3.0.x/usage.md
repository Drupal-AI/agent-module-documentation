<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Insert Media extends the Insert module to the core Media Library: it adds an Insert button to `media_library_widget` field widgets so an editor can drop a referenced media item, rendered in a chosen view mode, into a body/text area.

---

Insert Media is an experimental submodule of Insert that registers a new Insert *type* — `media` — for the core `media_library_widget` (via `hook_insert_widgets`). Like the parent module it adds a per-widget settings fieldset (an **Insert Media** details element) to *Manage form display*, whose choices are stored as `third_party_settings.insert_media` on the form-display component. Instead of image styles, the selectable "styles" here are the media entity's **view modes** (`hook_insert_styles` returns the view-mode list); the settings hold `view_modes` (the enabled view modes) and `default` (the default view mode, shipped default `full`). At insert time `hook_insert_variables` grabs the selected media entity from the widget and hands it to the renderer so the chosen view mode's markup is inserted. It ships its own `insert_media` JS library and uses `hook_module_implements_alter` to run after the parent Insert hooks. It has no config object, no configure route, and no permissions of its own.

---

- Let editors insert a media-library image, in the "full" view mode, into a node body.
- Offer several media view modes (e.g. `full`, `embedded`, `thumbnail`) as insert options on a media field.
- Restrict a media reference field to a single insert view mode so it is used automatically.
- Set the default view mode used when inserting media (shipped default `full`).
- Insert remote video or document media items into rich-text areas via their view mode.
- Standardise how referenced media appears inline across content types.
- Add inline media insertion to any field using the core `media_library_widget`.
- Disable Insert for a media field by selecting no view modes.
- Combine with CKEditor 5 so inserted media markup survives the editor (see parent `insert_media` allowed-HTML).
- Present a media item at a small thumbnail view mode inline while linking to full.
- Give authors a quick way to reference the same media entity in multiple view modes in one body.
- Enable inline media insertion on a paragraph or custom entity that uses the media library widget.
- Keep the media entity relationship intact (unlike copying an image) while embedding its rendered output.
- Provide editors a per-field media insert button without configuring CKEditor media embed.
- Use a dedicated "embedded" view mode for inline media rendering.
- Apply new view modes automatically to a media field by enabling "all" view modes.
- Insert media into a plain textarea (non-WYSIWYG) field as rendered markup.
- Configure per form mode which media view modes are insertable.
- Roll out consistent inline media view-mode usage to an editorial team.
- Let a gallery/slideshow view mode be inserted inline for a referenced media item.
