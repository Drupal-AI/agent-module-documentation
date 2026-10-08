<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Insert Media — agent index

Experimental submodule of **Insert**. Adds a new Insert type `media` for the core
`media_library_widget`, so a referenced media item can be inserted into a text area in a chosen
**view mode**. No config object, no configure route, no permissions — its only persistent state is a
per-widget `third_party_settings.insert_media` on an `entity_form_display` component.

- **Enable/configure Insert Media on a media field, view-mode settings, where stored** →
  [configure/insert-media.md](configure/insert-media.md)

Key facts:
- Registers `['media' => ['media_library_widget']]` via `hook_insert_widgets`.
- Per-widget setting at `core.entity_form_display.<entity>.<bundle>.<mode>` →
  `content.<field>.third_party_settings.insert_media` with keys `view_modes` (map of enabled media
  view modes; empty ⇒ disabled) and `default` (default view mode, shipped default `full`).
- The insert "styles" are the media entity's **view modes** (`hook_insert_styles` for type `media`).
- Depends on `media_library` + `insert`. Extends Insert via the parent's hooks (see the parent
  project's `agent/hooks/extend.md`).
