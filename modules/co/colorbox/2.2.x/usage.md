Colorbox integrates the jQuery Colorbox lightbox into Drupal, displaying images and other content in a customizable modal overlay instead of a full page load.

---

Colorbox wires the light-weight jQuery Colorbox plugin into Drupal so image and entity-reference fields can open in an in-page modal ("lightbox") rather than navigating away. It ships three field formatters — a plain image formatter (`colorbox`), a responsive-image formatter (`colorbox_responsive`), and an entity-reference/view-mode formatter (`colorbox_view_modes`) — that you assign under a display's "Manage display". A settings form at **Configuration → Media → Colorbox** controls the transition style, dimensions, opacity, slideshow, navigation text, mobile behavior, and which visual style (default, plain, stockholmsyndrome, or "none" to hand styling to your theme) is loaded. Images sharing a gallery grouping become a browsable slideshow with prev/next controls, and a token-driven gallery-id helper lets you scope galleries per field, per post, or per page. The actual Colorbox JS library is external and is fetched separately (via the bundled `drush colorbox:plugin` command or manual download into `/libraries/colorbox`). Developers can reshape the runtime options through `hook_colorbox_settings_alter()`, and the module exposes services (`colorbox.activation_check`, `colorbox.attachment`, `colorbox.gallery_id_generator`) for programmatic integration. It depends only on core's Image module and works on Drupal 10.2+ and 11.

---

- Open image-field images in a lightbox modal instead of a separate page.
- Build an image gallery with prev/next navigation from a multi-value image field.
- Present entity-reference content (e.g. a referenced node view mode) inside a modal.
- Show responsive images inside the lightbox via the responsive-image formatter.
- Turn a gallery into an auto-advancing slideshow with start/stop controls.
- Configure transition type (elastic, fade, none) and speed site-wide.
- Set the modal's max width/height as percentages so it fits any viewport.
- Customize navigation labels (Prev, Next, Close, "{current} of {total}").
- Adjust overlay opacity and click-to-close behavior.
- Choose a bundled visual style (default, plain, stockholmsyndrome) for the lightbox chrome.
- Hand all lightbox styling to your theme by selecting the "None" style.
- Group images across a page into one shared gallery using a token-based gallery id.
- Scope galleries per field or per post to keep unrelated images separate.
- Trim long image captions to a configurable length.
- Detect mobile devices and disable Colorbox below a width threshold for touch UX.
- Serve the minified vs. development build of the library via the compression setting.
- Add lightbox behavior to Views image fields through the field formatters.
- Install or update the external Colorbox JS library with `drush colorbox:plugin`.
- Override runtime Colorbox options in code with `hook_colorbox_settings_alter()`.
- Swap in a custom per-page style plugin based on the current route.
- Attach Colorbox activation programmatically via the `colorbox.attachment` service.
- Generate unique gallery ids from tokens with the gallery-id helper service.
- Display product or portfolio images in a modal on Commerce or gallery sites.
- Provide a consistent modal image viewer across content types.
- Reduce full-page loads by previewing linked images in place.
