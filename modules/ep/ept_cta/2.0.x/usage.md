<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EPT Call to Action adds a Paragraphs type that combines a title, rich text, an optional image and one or two styled link buttons into a configurable one- or two-column call-to-action section, with the EPT family's shared per-paragraph design and button settings.

---

Landing and marketing pages repeatedly need the same block: a short headline and pitch next to (or above) a prominent button that drives a click. EPT Call to Action packages that as the `ept_cta` Paragraphs bundle so editors build it in a few clicks instead of hand-assembling fields. The bundle carries an optional title (`field_ept_title`, text_long), body text (`field_ept_text`, text_long), an optional image (`field_ept_cta_column_image`, a single Media reference limited to the `image` media type), and two link fields — a primary `field_ept_cta_link` and an optional `field_ept_cta_second_link` — each rendered as a styled button. Its settings widget, `ept_settings_cta` (`EptSettingsCtaWidget`, a subclass of EPT Basic Button's `EptSettingsBasicButtonWidget`), adds a **Styles** choice (2 Columns, 2 Columns fluid image, or One column), **Align Content** (left/center/right), **Image position** (left/right, for the two-column layouts), **Image position on mobile** (image first/last after the columns stack) and a numeric **Mobile breakpoint** at which the two columns collapse to one; it also duplicates the full Basic Button style set as a **Second Link options** group so the second button can have its own colors, shape, size, alignment, stretched flag and custom class. The primary button reuses EPT Basic Button's colors and styles, and the whole paragraph inherits ept_core's shared **Design** tab (margins/padding/border, background color/image/video, edge-to-edge, container width). Layout, alignment and button choices are written onto the wrapper as CSS classes by `templates/paragraph--ept-cta--default.html.twig`, which also attaches `ept_cta/ept_cta` (`css/ept_cta.css`) and prints three scoped inline `<style>` blocks: `styles` (ept_core design output), `button_styles` (button colors from EPT Basic Button) and `cta_styles` — the responsive column CSS that the module's own `ept_cta.generate_cta_css` service (`GenerateCtaCSS`) builds from the settings (column widths, image order, mobile stacking at the chosen breakpoint). The module requires `ept_basic_button` (which brings in `ept_core`), `paragraphs`, `link` and `media`; its `hook_requirements()` blocks install until a Media type named `image` exists. Version 2.0.x; core `^10.1 || ^11 || ^12`; maintained by levmyshkin and Narine_Tsaturyan. It ships no permissions, routes, config schema, or Drush of its own — the only settings are per-paragraph, plus the site-wide EPT defaults on ept_core's configuration form.

---

- Add a headline-plus-button call to action anywhere a Paragraphs field is enabled.
- Build a two-column CTA with an image on the left and text plus button on the right.
- Flip the image to the right column for alternating CTA rows down a page.
- Use the "2 Columns fluid image" style so the image fills half the width edge to edge.
- Fall back to a single-column, centered CTA for a simple banner.
- Offer two buttons in one CTA — a primary and a secondary action side by side.
- Give the second button its own color, shape, size and alignment via Second Link options.
- Point a button at an internal node or an external URL using the Link fields.
- Open a CTA link in a new tab and add rel="nofollow" for sponsored/outbound links.
- Set a custom mobile breakpoint so the two columns stack at the width you choose.
- Control whether the image appears first or last once the CTA stacks on mobile.
- Center or left/right-align the CTA content within its container.
- Apply per-section background color, image or video via the shared Design tab.
- Make a full-width, edge-to-edge CTA band with inner content constrained to the container width.
- Add margins, padding, borders or a border radius around a single CTA paragraph.
- Reuse the same CTA paragraph type site-wide instead of building bespoke layouts.
- Compose landing pages from stacked CTA sections without Layout Builder.
- Add a Media image (with alt text and responsive image styles) as the CTA visual.
- Pair a promotional image with a "Buy now" / "Sign up" button in a product CTA.
- Style primary and secondary buttons as square, round or circle shapes.
- Stretch a button to full width for a mobile-friendly tap target.
- Add a custom CSS class to a button to hook site-specific styling.
- Install just this paragraph type from the EPT family when a CTA is all you need.
- Mix a CTA paragraph among other EPT paragraph types (text, image, columns) on one page.
