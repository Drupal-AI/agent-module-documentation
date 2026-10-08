# Configuration

There are two places to configure Media PhotoSwipe: a site‑wide settings form for
gallery behaviour, and the per‑field formatter on **Manage display** where you
actually turn images into a lightbox.

## The settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Media → Media PhotoSwipe**, or navigate directly to
   `/admin/config/media/media-photoswipe`.

This form tunes how the PhotoSwipe galleries behave site‑wide. Adjust the gallery
options to taste and click **Save configuration**; the changes apply wherever the
formatter is used.

## Setting the formatter on a field

The lightbox only appears where you enable the formatter:

1. Go to the entity that holds your image field — for example **Structure →
   Content types → *(your type)* → Manage display**.
2. For the image field, choose the **Media PhotoSwipe** formatter from the format
   dropdown.
3. Open the formatter's settings (the gear icon) to configure its options — such
   as which **image style** to use for thumbnails versus the full‑size lightbox
   view, and captions drawn from media fields.
4. Save the display.

Remember the current limitation: the formatter works with **Image fields**, not
Media reference fields.

## Suppressing the lightbox for a request

If you need a page to render without the PhotoSwipe behaviour — for print styles,
debugging, or a special view — append `?media_photoswipe=no` to the URL. The
module detects that query parameter and skips attaching the lightbox for that
request only.
