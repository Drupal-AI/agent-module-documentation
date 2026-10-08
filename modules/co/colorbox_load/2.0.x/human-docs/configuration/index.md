# Configuration

Colorbox Load ships **no settings of its own**. Everything you configure lives on the
**NG Lightbox** settings form — Colorbox Load only adds the **Colorbox** option to the
*Renderer* select there. That is why the module's *Configure* link takes you to NG
Lightbox rather than to a page of its own.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Media → NG Lightbox**, or navigate directly to
   `/admin/config/media/ng-lightbox`.

## The fields

- **Paths** — a textarea of path patterns, **one per line**. Each pattern must start with
  a leading slash, and `*` is the wildcard. For example, `/node/*` lightboxes every node
  page, `/comment/*/reply` lightboxes comment reply forms, and `/gallery` lightboxes just
  that one page. **This list starts empty, and while it is empty nothing is lightboxed** —
  this is the setting people most often forget.
- **Renderer** — choose **Colorbox**. This is the option Colorbox Load contributes;
  installing the module selects it for you, but if it ever gets switched back to *Core
  Modal* or *Core Dialog* you set it here. (Behind the scenes the value stored is
  `drupal_colorbox`.)
- **Default Width** — a width used for the core modal/dialog renderers. Note that the
  Colorbox renderer ignores this and always opens at 90% × 90% of the window, so changing
  it has no visible effect while Colorbox is the renderer.
- **Lightbox Class** — an optional extra CSS class added to the overlay, handy if you want
  to style one section's lightboxes differently.
- **Skip all admin paths** — ticked by default; leave it on unless you specifically want
  admin pages to open in the lightbox too.

Click **Save configuration** when you are done.

## Opting a single link in

Independent of the *Paths* list, NG Lightbox will lightbox any link that already carries
the `ng-lightbox` CSS class. That is a useful escape hatch when you want just one link to
open in the overlay without adding a path pattern for it.

## Good to know

- If the *Paths* list is empty, nothing opens in a lightbox no matter what the *Renderer*
  is set to.
- The overlay is a real link with an AJAX enhancement, so search-engine crawlers and
  "open in new tab" fall back to the ordinary full page — the behaviour degrades
  gracefully by design.
- Uninstalling Colorbox Load clears the renderer, which makes NG Lightbox fall back to its
  default core modal.
