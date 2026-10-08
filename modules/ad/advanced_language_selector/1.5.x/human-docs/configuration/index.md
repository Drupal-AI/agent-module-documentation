# Configuration

There is no standalone settings page — you configure everything in the block's own
placement form.

## Place the block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Find the region where you want the switcher and click **Place block**.
3. Choose **Advanced language selector block** (in the *Language block* category)
   and place it.

The block only shows on the front end when your site is multilingual, so if you
don't see it yet, confirm you have at least two languages configured.

## Choose a style ("Look and Feel")

At the top of the block form is the **Look and Feel → Theme** selector. This is the
single most important choice — it picks which of the eight display styles renders,
and the rest of the form changes to show only that style's options:

- **Bootstrap Dropdown** (the default) — a dropdown menu.
- **Bootstrap Navigation** — nav tabs.
- **Bootstrap Modal** — a button that opens a modal.
- **Bootstrap Offcanvas** — a slide‑in panel.
- **Bootstrap List Group** — a Bootstrap list‑group.
- **Bootstrap Button Group** — a Bootstrap button‑group.
- **Plain HTML** — a native `<select>` dropdown, no Bootstrap.
- **Plain HTML List** — a simple `<ul>` of links, no Bootstrap.

## The options each style exposes

The Bootstrap styles group their settings under **General** and **Display
options**; the plain styles are simpler. The common fields are:

- **Enter ID** — the HTML `id` for the component (required on Bootstrap styles).
- **Custom CSS class** — extra classes to add, e.g. `btn-primary`. Bootstrap styles
  let you set classes separately for the selected item and for all items.
- **Text transformation** — `default`, `upper`, `lower`, or `capitalize` applied to
  the labels. (Plain HTML uses a simpler uppercase checkbox.)
- **Load external Bootstrap library** — tick this **only** if your site theme is
  *not* Bootstrap‑based; it attaches Bootstrap 5 and Popper from a CDN so the
  Bootstrap styles work. Leave it off if your theme already includes Bootstrap.
- **Select items to display** — choose any of **icons** (flag), **language code**
  (EN, ES), and **language name** (English, Español). At least one is required. On
  Bootstrap styles you set this independently for the selected item and for all
  items.
- **Flag icon height (px)** — the height of the flag icons (default 25).
- **Icon alignment** — place the flag to the **left** or **right** of the label.

Save the block. The switcher renders in the chosen style, with each language
linking to the translated version of the current page.

## Notes

- If core language switching produces no links (for example Interface Translation
  isn't installed), the block falls back to a single link for the default language.
- To change the actual markup, override the style's Twig template in your theme; to
  use different flag artwork, replace the bundled SVGs. Both are covered in the
  [`agent/`](../agent/start.md) theming docs.
