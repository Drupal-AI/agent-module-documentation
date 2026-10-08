<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor 5 toolbar buttons that set a Media Library image as a styled background (size, overlay tint, focal point, parallax) behind field content.

---

Media Scene adds CKEditor 5 toolbar buttons that let editors pick an image from the core Media Library and apply it as a styled background — explicit width/height, overlay tint and opacity, a 9-position focal point, and an optional parallax effect — behind the field's content, without theme changes.

Three toolbar buttons (Add Background Image, Background Scene Settings, Remove Background Image) drive the workflow; a media_library opener plugin (`MediaLibraryMediaSceneOpener`, restricted to the `image` media type) handles selection, and `MediaSceneResolver` turns the stored media reference into a rendered background at display time using a configurable image style (set at `/admin/config/media/media-scene`, permission `administer media scene`, restricted). The background stores a reference to the media *entity*, not a frozen URL, so replacing the image or changing the image style updates every usage on next render. On text formats with "Limit allowed HTML tags", the **Render Media Scene backgrounds** filter must be enabled for the stored reference to render; Full HTML formats work without it. Day-to-day use of the toolbar buttons needs only the core **View media** permission.

Typical setup: add the three buttons to a text format's CKEditor 5 toolbar, enable the render filter on restricted formats, choose the image style on the settings form, then use the buttons in any field on that format.
---
- Set a Media Library image as a field background from CKEditor.
- Reuse the core Media Library dialog (image type only).
- Set an explicit pixel width and height for the background.
- Add an overlay tint colour and opacity for text legibility.
- Choose a focal point from a 9-position grid.
- Toggle a parallax (fixed-attachment) scroll effect.
- Remove a background and restore normal content flow.
- Reference a media entity so updates propagate automatically.
- Pick the image style used to render backgrounds.
- Enable the render filter on restricted text formats.
- Use Full HTML formats without the extra filter.
- Let editors work with only the View media permission.
- Restrict image-style config to administrators.
- Keep backgrounds up to date when the image is replaced.
- Style content backgrounds without touching a theme.
- Upload a new image on the spot during selection.
