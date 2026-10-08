<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Scene — setup

1. **Toolbar** — `/admin/config/content/formats`, edit a text format, drag **Add Background Image**, **Background Scene Settings**, **Remove Background Image** into the CKEditor 5 active toolbar.
2. **Render filter** — if the format has *Limit allowed HTML tags* enabled, also enable **Render Media Scene backgrounds** in that format's Enabled filters. Full HTML formats do not need it.
3. **Image style** — `/admin/config/media/media-scene` (permission `administer media scene`) picks the image style applied to the selected media when rendering the background.
4. **Use** — in a field on that format: **Add Background Image** → pick/upload an image (Media Library, image type only) → **Background Scene Settings** for width/height, overlay colour+opacity, focal point (9-grid → `background-position`), parallax (`background-attachment: fixed`).

The background stores the media entity reference (via `MediaSceneResolver` + `file_url_generator`), not a URL, so replacing the underlying image or changing the image style updates every usage on next render. Using the buttons requires only the core **View media** permission.
