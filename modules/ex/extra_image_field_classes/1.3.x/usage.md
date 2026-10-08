Extra Image Field Classes adds a single image field formatter ("Extra Image Field Classes") that behaves exactly like core's Image formatter but lets you type extra CSS classes to apply to each rendered image via *Manage Display*.

---

The module provides one formatter plugin, `extra_image_field_classes`, that extends core's `ImageFormatter` for `image` fields. It adds one setting, `extra_image_field_classes` (a space-separated list of class names entered on the formatter settings form), shows it in the settings summary, and in `viewElements()` appends those classes to each item's `#item_attributes['class']` so they land on the rendered `<img>` element. There is no global configuration, no permissions, no config schema, and no template — it is a thin subclass of the core image formatter. You select it in *Manage Display* for an image field, click the gear, enter classes, and save. The classes are administrator-entered formatter configuration (set behind *Manage Display*), rendered onto the image markup. Requires core `image` (and the Field UI module to reach the Manage Display screen, though Field UI is not needed to render).

---

- Add a Bootstrap/utility class (e.g. `img-fluid rounded`) to all images in a field's display.
- Apply a custom CSS class to an image field without writing a preprocess hook or template.
- Give different view modes (teaser vs full) different image classes.
- Add a lazy-load or animation hook class to rendered images.
- Tag images with a class targeted by theme CSS for consistent styling.
- Apply responsive helper classes to an image field.
- Add a class needed by a JS lightbox/gallery library to image markup.
- Style images in one content type differently by setting classes per bundle display.
- Add multiple space-separated classes to an image field at once.
- Keep core Image formatter behavior (image styles, linking) while adding classes.
- Apply a print-specific or utility class to images in a specific display.
- Add a semantic class (e.g. `figure-img`) for accessibility/markup consistency.
- Avoid a custom module just to add a class to one image field.
- Set image classes via exported field display config for deployment.
- Distinguish decorative vs content images by class in a display.
- Provide themers a hook class without touching Twig templates.
