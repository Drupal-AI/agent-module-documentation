Element Class Formatter Responsive Image adds a "Responsive image (with class)" field formatter that puts CSS class(es) directly on a Responsive Image field's rendered element.

---

This submodule of Element Class Formatter extends core's `ResponsiveImageFormatter` with the parent module's `ElementEntityClassTrait`, producing one extra formatter, `responsive_image_class` (label "Responsive image (with class)"), for `image` fields. It behaves exactly like the core Responsive Image formatter — you still pick a responsive image style and image link option — but adds an "Element class" setting whose space-separated classes are applied to the image element via `#item_attributes`. It depends on both `element_class_formatter` and core's `responsive_image` module, and installs automatically (via the parent module's update hook) on sites where `responsive_image` is enabled. Settings are stored in the field's component in the `entity_view_display` config entity and validated by the schema `field.formatter.settings.responsive_image_class`, which extends `field.formatter.settings.responsive_image` with a `class` string. There is no settings page, permission, or Drush command — it is pure display configuration.

---

- Add a `img-fluid` class to a responsive image field so it scales with Bootstrap.
- Put a `rounded` or `shadow` utility class on responsive images.
- Add a `lazyload` class to responsive image elements for a JS lazy-loader.
- Apply a hero/banner class to a responsive image used at the top of a page.
- Give art-directed responsive images a framework-specific element class.
- Keep the class on the image element itself rather than the field wrapper.
- Style responsive images differently per view mode by setting the class per display.
- Combine a responsive image style with a CSS class in one formatter.
- Standardise responsive image classes across content types via exported display config.
- Add multiple classes (space separated) to a responsive image element.
- Provide editors class control over responsive images without editing Twig.
- Add a gallery/thumbnail class to responsive images in a card layout.
- Add an `object-fit` helper class to responsive images.
- Ensure responsive images carry the classes a CSS grid/flex layout needs.
- Migrate a plain image display to a classed responsive image display.
- Reuse the parent module's ElementEntityClassTrait pattern for responsive images.
