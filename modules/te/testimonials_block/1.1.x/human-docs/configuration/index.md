# Configuration

Testimonials Block has no central settings page — you configure everything on the
block itself when you place it.

## Place the block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region where you want the testimonials to appear,
   and choose the **Testimonials** block.

## Enter your testimonials

On the block configuration form, add one entry per testimonial. Each entry can
include:

- **Quote** — the testimonial text itself.
- **Author** — the name of the person giving the testimonial.
- **Author image** — an optional photo of the author.
- **Designation** — the author's job title or role.
- **Other information** — any additional detail about the author.

Use the **order weight** option on each testimonial to control the sequence in
which they are displayed.

## Responsive display options

The block renders as a responsive carousel, and you can tune how it behaves at
different screen sizes:

- **Number of items** shown on large, medium, small, and extra‑small screens.
- **Navigation arrows** — show or hide the prev/next navs per screen size.
- **Dots** — show or hide the pager dots per screen size.
- **Hide box shadow** — an option to remove the box shadow around each testimonial
  item.

Set these to suit your layout, then save the block.

## Customising the look (optional)

If you want full control over the markup or styling, copy the module's template
file `templates/testimonials-block.html.twig` into your own theme and edit it
there. The template exposes variables you can work with, including:

- `testimonials_data` — the array of testimonials, each with `quote`, `author`,
  `image_url`, `designation`, and `other_info`.
- `responsive_settings` — the carousel configuration you set on the block
  (per‑screen item counts, nav and dots toggles, and `hide_box_shadow`).

With these you can implement your own HTML and CSS, or wire up a different carousel
library entirely.
