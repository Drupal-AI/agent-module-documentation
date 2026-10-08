# Configuration

Panels Everywhere has **no dedicated settings form**. You configure it entirely
through **Page Manager**, which is where it plugs in its central idea: a **site
template** page whose Panels variant wraps every page on the site.

## Where you work

Go to **Structure → Pages** (`/admin/structure/page_manager`). This is Chaos
Tools' Page Manager UI, listing the pages it manages. Panels Everywhere adds a
**site template** entry here — this is the page that takes over the full-page
layout for the rest of the site.

## Set up the site template

The general workflow is:

1. Open the **site template** page in Page Manager.
2. Edit (or add) a **variant** and choose the **Panels** display so you can lay
   the page out with the Panels interface.
3. Pick a **layout** for the variant. Because this template is your whole page —
   not just the content area — its regions become the site's header, footer,
   sidebars, and content areas.
4. Place **panes** (blocks, the main page content pane, the system region for the
   inner page, menus, branding, and so on) into the layout's regions. The pane
   that outputs the actual page being viewed is what turns this template into a
   real "wrapper" around every page.
5. Save the variant. From now on, pages are rendered *inside* this Panels layout
   rather than through the theme's `page.html.twig`.

Because arrangements are variants, you can add **selection criteria** to a variant
(for example, by path or content type) to give a section its own full-page
structure, and order the variants so the right one wins.

## Things to check after enabling

Taking the page shell away from the theme is the whole point of Panels Everywhere,
but it also means anything that assumed the theme's regions needs verifying:

- **Blocks placed by contrib modules or your theme** — they were expecting the
  theme's regions; make sure the equivalent panes exist in your Panels layout.
- **The admin toolbar and status messages** — confirm they still render, since
  they rely on regions the inversion can bypass.
- **Your theme's own preprocess/template code** — anything tied to
  `page.html.twig` may no longer run as before.

Work through these on a staging copy before going live. If a region's content
disappears, it usually means the corresponding pane has not been placed in the
site template variant.

## A note on choosing this module

This is the Drupal 7-era approach to full-page layout. Core's **Layout Builder**
solves the same problem, is core-maintained, and has the larger community. Panels
Everywhere makes the most sense for a site that already relies on it; for a new
build, weigh Layout Builder first.
