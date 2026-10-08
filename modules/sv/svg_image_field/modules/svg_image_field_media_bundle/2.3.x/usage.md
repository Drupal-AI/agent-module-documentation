A submodule of SVG Image Field that installs a ready-made "Vector image" media type wired to the SVG source, so SVGs work with core Media and the Media Library without manual setup.

---

Setting up an SVG media type by hand means adding a media type, choosing the SVG media source, creating the source field and configuring form and view displays. This submodule does all of that on install by shipping the config: a `vector_image` media type, a `field_media_svg` SVG Image Field storage and field, and default plus media-library form/view displays. If Acquia Site Studio is installed it also imports matching Site Studio components (a "Vector Image" component and card). Install it after enabling core Media (and Media Library first, if you intend to use it) and the parent `svg_image_field` module. After installation editors can immediately add "Vector image" media entities and pick them through the Media Library. It provides no code, services, permissions or settings of its own — it is purely a configuration bundle to save setup time.

---

- Add SVG support to the Media Library without manually building a media type.
- Get a ready-made "Vector image" media type on install.
- Let editors upload and reuse SVG logos/icons as first-class media entities.
- Reference SVG media from content via the standard Media reference field.
- Skip the manual steps of creating the SVG source field and displays.
- Provide a consistent SVG media type across multiple sites or environments.
- Import Acquia Site Studio "Vector Image" components automatically when Site Studio is present.
- Use SVG media with preconfigured media-library form and view displays.
- Bootstrap a design system's scalable icon library as media.
- Store brand vector assets centrally for reuse across pages.
- Give content authors a point-and-click way to insert SVGs.
- Standardize how SVG media is uploaded and displayed site-wide.
- Serve as a starting point you can further customize after install.
- Deploy an SVG media capability through configuration rather than code.
- Enable SVG media entities that render sharp on high-DPI displays.
