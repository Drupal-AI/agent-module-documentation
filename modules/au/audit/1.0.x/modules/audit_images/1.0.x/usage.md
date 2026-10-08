Scores image display config: image/responsive styles, breakpoints, lazy loading, and image-field formatters.

---

Registers the `images` analyzer (`ImagesAnalyzer`, weight 3). It reviews the enabled image modules, image styles and responsive image styles (with breakpoints), CKEditor image styles, unused styles, lazy-loading configuration, and image-field formatter setup — flagging image fields whose formatters bypass responsive styles or lazy loading. This submodule has no settings of its own.

---

- Inventory image styles and responsive image styles (with breakpoint mapping).
- Find unused image styles safe to remove.
- Check that image fields use responsive styles and lazy loading.
- Review CKEditor image style configuration.
- Flag image-field formatters that hurt performance or LCP.
- Confirm the enabled image module stack (image, responsive_image, breakpoint).
- Run headless: `drush audit:run images --format=json`.
- Weight 3 by default in the Project Score.
