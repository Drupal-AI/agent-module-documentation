# Configuration

Favicons is deliberately simple to configure: you upload one image and the module
generates every icon variant from it.

## Open the settings form

1. Log in as a user with the module's administrative permission (an administrator by
   default).
2. Open the **Favicons** settings form — the quickest route is the module's
   **Configure** link on the **Extend** page (`/admin/modules`); it also appears
   under **Configuration**.

## Upload your source icon

The form has a single essential field: an upload for your **source favicon**, a
PNG. Choose a square image at a reasonably high resolution (so the largest
generated variant, 180×180, stays crisp) and save the form.

On save, the module generates the icon set from your image:

- a **180×180** `apple-touch-icon` (for iOS home‑screen bookmarks),
- a **`favicon.svg`**,
- a **96×96** icon,
- a **`site.webmanifest`** describing the icons.

It then adds the matching `<link>` and manifest references to the `<head>` of every
page automatically — you do not need to edit your theme or add any markup yourself.

## After saving

If you have just installed the module, remember to **clear the cache** once (see
[Installation](../installation/index.md)) so its late head‑hook placement takes
effect. To change the icons later, simply upload a new source image and save again.
