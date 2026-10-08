<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Media adds a "Media Enhanced" reference field that stores a per-reference caption and video start/end time alongside each referenced media item, with a matching Media Library widget and a rendered-entity formatter.

---

Install it like any contrib module (it needs core **Media** and **Media Library**), then add a field of type **Media Enhanced** to a content type or other fieldable entity — the field always targets media entities and can hold multiple items. In the field's settings, choose which media types (bundles) the field targets and tick, per bundle, whether to enable the **Caption** and the **Start/End time** extras. On the *Manage form display* tab set the widget to **Media library**: editors pick items in the usual media-library modal, and for each selected item they get a "Show default caption text" checkbox (with a custom-caption textarea when unchecked) and a "Use default video start/end time" checkbox (with start/end number inputs when unchecked). On *Manage display* set the formatter to **Rendered entity** and, per media bundle, map the caption / start / end onto a real text or number field that exists on that media type; at render time the formatter temporarily writes the per-reference values onto those media fields (in memory, never saved) before rendering the media in the chosen view mode. The value of this over a plain core media reference is that the caption and timings belong to *this* reference, so the same image or video can carry different text or a different clip range everywhere it is reused. The current release is **1.0.0-rc7**, a release candidate, and if you need the field to work with widgets or formatters other than the two it ships you would have to patch or alter those (e.g. `hook_field_formatter_info_alter`).

---

- Reference one or more media items from a node or other entity.
- Add a caption that is specific to one use of a media item.
- Show a different caption for the same image on different pages.
- Store per-reference metadata without editing the shared media entity.
- Set a start time for a referenced video, per reference.
- Set an end time (clip range) for a referenced video, per reference.
- Reuse one video with a different start/end in each place.
- Fall back to the media item's own caption with a single checkbox.
- Fall back to the media item's own start/end time with a checkbox.
- Pick media through the standard Media Library modal.
- Select multiple media items in one field.
- Override a chosen text field on the media entity with the custom caption.
- Override chosen fields on the media entity with the video start/end.
- Render referenced media in a configurable view mode.
- Enable the caption UI only for specific media bundles.
- Enable the start/end UI only for specific media bundles (e.g. video).
- Build an image gallery field with per-image captions.
- Build a video field with per-placement clip trimming.
- Keep relationship-specific data off reusable media assets.
- Extend core's media reference field with editorial extras.
