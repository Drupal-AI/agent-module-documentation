A demonstration submodule for Curated Colors that installs a Drupal Brand color palette and a working `colored_card` Single Directory Component showing the curated-color-key-as-CSS-class pattern.

---

`curated_colors_example` depends on `curated_colors`. On enable it installs one palette config entity, `curated_color_palette.drupal_brand` ("Drupal Brand"), containing Drupal's official brand colors and six gradient entries organized into Primary/Secondary/Tertiary/Gradient groups. It also ships a `colored_card` SDC (`components/colored_card/`) whose `color` prop is a curated color key: the Twig template applies the key as a BEM modifier class (`colored-card--drupal-blue`, normalizing underscores to dashes), and the component stylesheet owns the actual hex/gradient values — one CSS rule per palette key. The prop is annotated `x-curated-color-palette: drupal_brand`, so with Drupal Canvas installed the swatch picker renders for it in the component editor, whether the prop is bound to a `curated_color` field or set statically on a page. The submodule provides no routes, permissions, services or config schema; it is purely example content and a reference implementation.

---

- Get a ready-made "Drupal Brand" palette to try Curated Colors without building one by hand.
- Study the recommended pattern: store a curated color key, apply it as a CSS class, keep values in CSS.
- See how gradient colors are defined via each palette entry's custom CSS `style` field.
- Use the `colored_card` component as a template for annotating an SDC prop with `x-curated-color-palette`.
- Demonstrate the Canvas swatch picker on a real component prop bound to a curated color palette.
- Copy the `colored-card--<key>` stylesheet approach into your own theme or component set.
- Show editors how palette groups (Primary, Secondary, Tertiary, Gradient) appear in the picker.
- Provide a config-install example (`config/install/curated_colors.curated_color_palette.drupal_brand.yml`) for shipping palettes.
- Verify a Curated Colors install end to end before wiring it into production content types.
- Serve as a teaching reference for the underscore-to-dash key normalization in Twig.
