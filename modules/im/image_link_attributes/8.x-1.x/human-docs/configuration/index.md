# Configuration

Image Link Attributes is configured in two complementary places: **per field
display**, where you set the attributes for a specific image field, and a
**site‑wide settings form** where you set defaults.

## Per field display

This is where most of the work happens:

1. Go to **Structure → *(content type)* → Manage display** and choose the view mode
   you want to affect.
2. Set the image field's formatter to link the image — **Link image to → Content**
   or **File**. The extra settings only appear once the image is set to link to
   something.
3. Open the formatter settings (the gear icon). You'll find inputs for:
   - **Class** — one or more CSS classes added to the link, e.g. a lightbox class
     your JavaScript binds to (such as `lightbox` or a gallery‑grouping class).
   - **Target** — where the link opens, e.g. `_blank` to open in a new tab.
   - **Rel** — the relationship attribute, e.g. `lightbox-series` for a lightbox
     group, `nofollow`, or **`noopener`**.
4. **(Optional) Link to an alternate image style.** On version 8.x‑1.8 and newer,
   tick **Link to alternate Image Style** and choose an image style, so the link
   points to that style's variant instead of the original file.
5. Save the display.

> **Important — pair `target="_blank"` with `rel="noopener"`.** A link that opens in
> a new tab without `rel="noopener"` gives the newly opened page programmatic access
> to your page. Whenever you set **Target** to `_blank`, add `noopener` (and usually
> `noreferrer`) to the **Rel** field. This is a security/correctness point, not a
> style preference — and this form is how you set it declaratively.

## Site‑wide defaults

The module also provides a settings form (route `image_link_attributes.config`)
where you can set default attribute values that apply across the site, so you don't
have to re‑enter the same class or rel on every field display. Set your defaults
there and save; individual field displays can still specify their own attributes.

## A typical lightbox setup

1. On the image field's display, set it to link **to file**.
2. In the formatter settings, add your lightbox library's **Class** (for example
   `lightbox`) and, if it groups images, a **Rel** like `lightbox-series`.
3. Save. Your lightbox JavaScript now finds every linked image by that class —
   consistently, across every view mode, with no template overrides.
