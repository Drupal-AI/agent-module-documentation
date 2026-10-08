<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lottiefiles Field adds a `lottiefiles_field` field type (a Link-field subclass) plus a matching widget, formatter and a `lottiefile` Media source, so editors can attach a Lottie JSON animation — by external URL, internal path, or uploaded `.json` file — and render it with the bundled `<lottie-player>` web component.

---

The module extends core's `LinkItem`/`LinkWidget` to store a URI to a Lottie animation JSON alongside player options (`autoplay`, `background`, `controls`, `hover`, `loop`, `mode`, `speed`, `selector`, `width`). The widget (`lottiefiles_field`) offers a URL textfield, a `managed_file` upload restricted to the `json` extension (saved to `public://lottiefile_field/`), a hex/`transparent` background colour picker, and the player toggles; on submit an uploaded file is made permanent and its generated URL replaces the URI. The formatter (`lottiefiles_field`) renders the `lottiefiles_player_formatter` theme hook whose Twig emits a `<lottie-player src=…>` element and attaches the bundled `lottie-player-0.3.0.js` library (loaded in the page header). Installing the module also creates a ready-made `lottiefiles` **Media type** backed by a `lottiefile` Media source and a `field_media_lottiefile` field, with a custom media-library add form (`LottiefilesFieldMediaForm`) that accepts a URL or upload. `hook_install()` copies the `lottie.png` thumbnail icon into the media icon directory. There is no global settings page (`configure` is null) and no permissions of its own; access follows the entities/fields you attach it to. Background values are validated to a 6-digit hex or `transparent` and passed through `Xss::filter`; the animation JSON itself is loaded client-side by the player from whatever URL is stored.

---

- Add a Lottie animation field to a content type and paste a lottiefiles.com JSON URL.
- Upload a `.json` Lottie file directly on the node form and have its URL auto-filled.
- Reference an internal animation file (e.g. `/sites/default/files/animations/x.json`).
- Autoplay an animation on page load.
- Loop an animation continuously.
- Show player controls (play/pause/slider) to visitors.
- Play an animation only while the mouse hovers over it.
- Set a transparent or specific hex background colour behind the animation.
- Play an animation in bounce mode instead of normal.
- Set playback speed from 1 to 5.
- Constrain the player width in pixels.
- Create reusable animation Media entities via the bundled `lottiefiles` media type.
- Add Lottie animations through the Media Library add form (URL or upload).
- Give each field instance a unique CSS selector/id for per-instance styling or scripting.
- Render animated icons or illustrations in view modes without shipping large GIFs/videos.
- Add lightweight hero or loading animations to landing pages.
- Attach the field to any entity type (taxonomy terms, users, custom entities) that supports fields.
- Display the same animation with different player settings per view mode.
- Serve vector animations that scale crisply on any screen density.
- Use the Link-field foundation to benefit from external-protocol and access validation constraints.
- Provide editors a colour picker to match animation background to the site theme.
- Store animation options per field value so multiple animations on one node differ.
- Migrate legacy phpexcel-style GIF banners to compact Lottie JSON.
- Restrict uploads to JSON only, keeping the media directory clean.
