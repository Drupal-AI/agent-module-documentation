# Configuration

LightGallery Formatter is configured in two places: you create reusable **gallery
profiles**, and then you **apply a profile** to a media field's display. A profile
holds all the gallery behavior in one named bundle of settings, so you configure
it once and reuse it across as many fields as you like.

## Create a gallery profile

Profiles are standard Drupal configuration entities managed from the module's
profile listing in the admin area (reachable from the module's configuration; if
you installed the **Preview** submodule, each profile also gains a live‑preview
tab). Add a profile, give it a clear name, and configure its options. Depending on
the release, the settings a profile exposes include:

- **Transition / animation** — the effect used when moving between slides. The
  module offers a large set (slide, fade, zoom, rotate, and many more), chosen
  from a dropdown.
- **Controls and UI** — toggles for the close icon, fullscreen/maximize button,
  the image counter, the download button, thumbnails, and similar chrome.
- **Zoom** — whether visitors can zoom into an image.
- **Auto‑hide controls** — hide the gallery controls after a configurable delay so
  they don't obscure the image.
- **Keyboard and touch** — keyboard navigation (Esc to close, arrow keys, mouse
  wheel) and touch gestures (swipe, drag) for mobile.
- **Remote video** — support for YouTube and Vimeo items, including automatic
  thumbnail extraction for those videos.

Because profiles are configuration, they export with `drush config:export` and
sync between environments like any other Drupal config.

## Live preview (optional)

If the **Preview** submodule (`lightgallery_formatter_preview`) is enabled, the
profile edit screen gains a preview so you can see the gallery render as you change
settings — useful for dialing in transitions and controls without leaving the form.

## Apply a profile to a field

1. Go to **Structure → Content types → *(your type)* → Manage display** for a
   bundle that has a **media reference field**.
2. In the **Format** column for that field, choose **LightGallery Formatter**.
3. Open the formatter settings (the gear icon) and pick the **profile** to use.
4. Click **Update**, then **Save** the display.

The field now renders as a lightGallery gallery using that profile. To restyle
every gallery that shares the profile, edit the profile once — all fields using it
follow the change.
