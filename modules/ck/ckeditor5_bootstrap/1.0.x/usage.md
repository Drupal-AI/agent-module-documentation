Adds CKEditor 5 toolbar widgets that let editors author Bootstrap 5 markup (Div containers, Tables, and prebuilt Components) without writing HTML.

---

CKEditor5 Bootstrap Integration ships three core CKEditor 5 plugins — Bootstrap Div, Bootstrap Table, and Bootstrap Components — that appear as toolbar buttons once you add them to a text format's CKEditor 5 toolbar. Bootstrap Div inserts a configurable `<div>` (utility/layout classes with autocomplete, an id, a background image with position/size, AOS animation data attributes, and freeform data-*/aria- attributes). Bootstrap Table adds a balloon toolbar over any table for setting a caption and toggling `table-*` classes (striped, bordered, hover, responsive, colors). Bootstrap Components inserts ready-made Bootstrap snippets (accordion, alert, badge, card, carousel, collapse, list group, modal, offcanvas, toast, tooltip, popover, tabs). The available classes, table options, and component templates are all defined in bundled JSON files, and each plugin can be pointed at a custom JSON file (per text format) so site builders extend the lists without touching PHP or JS. The module provides no routes, permissions, services, or Drush commands; it only registers CKEditor 5 plugins and their allowed-HTML elements. The module needs its JavaScript built (`yarn build` / `npm run build`) — the packaged release ships the compiled `js/build/*.js`. Bootstrap's own CSS/JS is not bundled; supply it via your theme so the authored markup renders and behaves correctly.

---

- Give editors a point-and-click way to wrap content in Bootstrap layout containers (`container`, `row`, `col-*`, `d-flex`, spacing/padding utilities).
- Let content authors add background images (URL + position + size) to a section without editing raw HTML.
- Add AOS (Animate On Scroll) data attributes (`data-aos`, duration, delay, anchor-placement) to a div for scroll animations.
- Attach arbitrary `data-*` / `aria-*` attributes to a div for JS hooks or accessibility.
- Assign an `id` to a section so it can be targeted by anchor links or custom scripts.
- Style existing tables with Bootstrap classes (`table`, `table-striped`, `table-bordered`, `table-hover`, `table-sm`) via a balloon toolbar.
- Add color variants to tables (`table-primary`, `table-dark`, etc.).
- Make tables responsive (`table-responsive`, `table-responsive-md`, …).
- Add or remove a table `<caption>` and control caption placement (`caption-top`).
- Insert a Bootstrap accordion with multiple collapsible items directly from the editor.
- Drop in contextual alert boxes with a chosen color variant.
- Add badges, cards, carousels, list groups, and other Bootstrap components as prebuilt snippets.
- Insert interactive components (modal, offcanvas, toast, tooltip, popover, tabs, collapse) with the required Bootstrap data attributes already wired.
- Standardize marketing/landing-page building blocks across a content team using one shared component set.
- Extend the Div class picker with project-specific utility classes by editing `bootstrap-config.json` (or a themed override).
- Add or reorder Bootstrap component definitions by editing `components_config.json` and rebuilding, or via a custom JSON path per text format.
- Customize the table options dialog (tabs, groups, fields) by editing `table_options.json` — no rebuild needed, just `drush cr`.
- Point a text format at a theme-provided JSON config so different sites/sections offer different Bootstrap building blocks.
- Enable Bootstrap authoring only on specific text formats (e.g. Full HTML) by adding the buttons to just that toolbar.
- Pair with a Bootstrap 5 front-end theme so authored components render and behave without extra markup.
- Build a WYSIWYG page-builder-lite experience on plain body fields instead of a heavier layout/paragraphs stack.
