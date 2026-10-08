# Configuration

Image Lazy Loader is configured in two places: a small module‑wide settings form,
and the per‑field display settings where you actually switch lazy loading on.

## Module settings

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Media → Image Lazy Loader**, or navigate directly to
   `/admin/config/media/image-lazy-loader`.

The setting to know about here concerns the **animate.css** library. The module
loads animate.css automatically so it can animate images as they appear. If your
**theme already includes animate.css**, you can disable the module's copy from this
page to avoid loading the library twice. Leave it enabled if your theme does not
provide animate.css — otherwise the appearance animations won't have their styles.

Save the form after changing the setting.

## Per‑field display settings

The lazy‑loading behaviour is applied to individual image fields on their display:

1. Go to **Structure → *(content type)* → Manage display** (choose the view mode you
   want to affect).
2. Open the image field's formatter settings (the gear icon).
3. Choose to **lazy‑load** the image rather than load it normally.
4. Pick the **animation** to play as the image appears on scroll, and its
   **duration** / speed.
5. Save the display.

Repeat for each image field and view mode where you want deferred loading. Because
these are display settings, they are captured in your exported configuration.
