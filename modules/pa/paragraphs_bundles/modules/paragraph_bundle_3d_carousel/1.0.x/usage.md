Paragraph Bundle 3D Carousel adds the `3d_carousel_bundle` Paragraph type(s) to the Paragraphs Bundles suite — a page-building bundle with a Content tab for its fields and a Display tab for per-instance colors, spacing, border, and background styling.

---

This submodule of [Paragraphs Bundles](../../../../1.0.x/agent/start.md) ships the `3d_carousel_bundle` paragraph type(s) as `config/optional` (paragraph type, field storages/instances, and default form/view displays), provisioned when the module is enabled. Like every bundle in the suite it reuses the base module's shared Display-tab fields (`pb_display_*`) and CSS-variable rendering: the template reads the color/opacity/spacing fields and emits CSS custom properties (`--pb-bg`, `--pb-tx`, `--pb-br`, …) plus utility classes on a `.paragraph__inner` wrapper, so appearance is data-driven per instance with no custom CSS and no jQuery. Add it to content by allowing the bundle in a Paragraphs reference field (on a node, or the suite's PB Content / PB Block). Depends on: `paragraphs_bundles`.

---

- Present a set of items in a rotating 3D carousel.
- Showcase featured products or photos with a depth/perspective effect.
- Add an eye-catching interactive hero-style rotator to a landing page.
- Cycle through testimonials or logos in 3D.
- Attach the bundle's own CSS/JS library automatically via its template.
- Combine with the Image bundle for image-based 3D slides.
- Use as a slide source referenced by the Node Reference bundle.
- Provide a JS-driven carousel with no jQuery dependency.
- Theme the rotation container by overriding the bundle template.
- Style this bundle per instance from the **Display** tab: background, text, and border colors plus their hover variants.
- Set border, border-radius, margin, padding, width, and box-shadow on the instance without writing CSS.
- Adjust the instance's background opacity (0–100) with the BG Opacity Range field.
- Place the bundle in a Paragraphs field on any node, or inside the suite's PB Content / PB Block.
- Nest the bundle inside a layout or column bundle to build structured page sections.
- Override its `paragraph--<bundle>.html.twig` template in your theme to customize markup.
- Enable just this submodule to add only this bundle type to the site.
