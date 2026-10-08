CKeditor Responsive Plugin adds a CKEditor 5 toolbar button that inserts responsive column/grid `<div>` blocks into rich-text content, so editors can build responsive layouts without tables.

---

The module ships a CKEditor 5 plugin (`responsiveAreaPlugin.ResponsiveArea`, defined in `ckeditor_responsive_plugin.ckeditor5.yml` and built in `js/build/responsiveAreaPlugin.js`) that registers a "Responsive Area" toolbar item. Clicking it inserts `<div>` markup carrying standard responsive CSS classes — column classes (`onecol`, `twocol`, …) and grid classes (`grid-1`, `grid-2`, …) — which your theme (or the bundled `css/responsivearea.css`) styles into a responsive layout. It has no server-side configuration of its own: setup is done entirely through core's text-format/editor UI (the `configure` route is `filter.admin_overview`). You enable it per text format by dragging the Responsive Area button onto that format's CKEditor 5 toolbar; the plugin declares the elements it needs (`<h2>`, `<div>`), and if the format uses "Limit allowed HTML tags" you must permit `<div class="">` (and the grid/column classes) so the markup is not filtered out. The module provides no permissions, schema, or Drush commands — it is purely an editor-side plugin plus supporting CSS/icons. Requires core `ckeditor5`.

---

- Add a "Responsive Area" button to a CKEditor 5 toolbar.
- Let editors insert multi-column responsive layouts without using tables.
- Build two-, three-, or four-column content blocks inside the rich-text editor.
- Insert `<div>` blocks with predefined column classes (`onecol`, `twocol`, …).
- Insert grid-classed `<div>` blocks (`grid-1`, `grid-2`, …) for grid layouts.
- Provide editors a table-free way to create responsive rich content.
- Style the responsive areas with the bundled `responsivearea.css` or your theme's classes.
- Integrate with Bootstrap-style grid classes already present in a theme.
- Enable the plugin only on specific text formats (e.g. Full HTML) via the toolbar config.
- Allow `<div class="">` in a restricted format so responsive markup survives filtering.
- Give content authors reusable layout primitives inside body fields.
- Replace legacy table-based layouts in migrated content with responsive divs.
- Keep layout markup semantic (divs + classes) rather than inline styles.
- Add the responsive-area icon (bundled SVG/PNG) to the editor toolbar UI.
- Provide a lightweight layout tool where full Layout Builder is overkill.
- Standardize column markup across editors on a multi-author site.
