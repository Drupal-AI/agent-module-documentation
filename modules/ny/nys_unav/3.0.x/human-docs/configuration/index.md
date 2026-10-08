# Configuration

NYS Universal Navigation works as soon as it is enabled — by default it inserts the
header and footer on every page automatically. The settings form and the blocks
described here are for cases where you want more control over how and where the
navigation appears.

## Open the settings form

1. Log in as a user who can administer the module (an administrator by default —
   the module provides its own permissions).
2. Go to the module's settings form (route `nys_unav.form`).

The form controls how the Universal Navigation is applied to your site — for
example how the header and footer are embedded. Adjust the options to suit your
theme and save.

## Automatic insertion vs. manual placement

You have two ways to display the navigation:

- **Automatic (default)** — the module inserts the Universal Navigation header at
  the top and the footer at the bottom of every page, outside your page's HTML. If
  this is what you want, there is nothing more to do.
- **Manual placement with blocks** — if you need the bars in specific regions or
  want to control them alongside your theme, use the two blocks instead:
  1. Go to **Structure → Block layout** (`/admin/structure/block`).
  2. Place the **NYS uNav Header** block in your header/top region and the **NYS
     uNav Footer** block in your footer region.
  3. Configure each block's visibility and save.

  The module also exposes two functions you can call directly from theme templates
  if you prefer to embed the header and footer in your Twig.

## A note on assets

The navigation bars are iFrames served from NYS‑hosted assets. Visitors' browsers
load those assets directly, so make sure nothing in your site's content security
policy or your visitors' network blocks the NYS endpoints, or the bars will not
render.

## Save and verify

Save the settings, then load a front‑end page and confirm the header and footer
appear where you expect — either auto‑inserted site‑wide, or in the regions where
you placed the blocks.
