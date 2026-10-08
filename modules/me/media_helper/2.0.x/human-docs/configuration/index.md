# Configuration

Media Helper works out of the box — the Twig filters, functions, and the
**Rendered image** formatter are all available the moment the module is enabled.
The settings form exists only to switch on the **optional SVG integrations**, so
if your site doesn't use SVG images you can safely ignore this page.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Media → Media Helper**, or navigate directly to
   `/admin/config/media/media-helper`.

## SVG integrations

By default Media Helper renders raster images (JPEG, PNG, WebP, …) through Drupal's
standard image and responsive‑image pipeline. SVGs are different — they don't have
pixel dimensions in the usual sense — so the module offers optional integrations
that only make sense when the matching contributed module is installed:

- **SVG Image integration** — enable this when you use the *SVG Image* module. It
  lets Media Helper size SVGs based on your image‑style effects rather than
  treating them as fixed‑size files.
- **SVG Image Field integration** — enable this when you use the *SVG Image Field*
  module. It adds the same SVG awareness for media that stores its SVG in an SVG
  image field, and lets you optionally override the SVG's dimensions.

Leave both off if you don't render SVGs — turning them on without the corresponding
module installed has no effect.

## Save

Click **Save configuration**. The change takes effect immediately; clear caches if
a template that renders SVGs doesn't pick up the new behavior right away.
