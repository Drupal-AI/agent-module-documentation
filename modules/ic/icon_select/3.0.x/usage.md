Icon Select lets you manage a library of SVG icons as taxonomy terms and pick them through a visual icon-picker field widget, rendering them from a generated, sanitized SVG sprite sheet either as entity-reference fields or via a `svg_icon()` Twig function.

---

On install the module creates an `icons` taxonomy vocabulary with two fields on each term: `field_symbol_id` (a required, unique string that becomes the SVG `<symbol id>`) and `field_svg_file` (a public file). Editors add icons as terms ("Add term"), uploading one SVG each. Whenever an icon term is inserted, updated or deleted, a shutdown function calls `SvgSpriteGenerator::generateSprites('icons')`, which reads every term's SVG, runs it through the `enshrined/svg-sanitize` sanitizer, assembles a hidden `<svg><symbol>…` sprite sheet, and writes it to `public://icons/icon_select_map.svg` (path configurable). To use an icon on content, you create an **entity-reference field** targeting the `icons` vocabulary, then switch its form-display widget to **Icon Select** (`icon_select_widget_default`, a checkbox-style visual picker) and its view-display formatter to **SVG Icon** (`icon_select_formatter_default`), which outputs an `<svg><use xlink:href="#symbol-id">` referencing the sprite. Front-end developers can drop an icon anywhere with the Twig function `{{ svg_icon('symbol-id', 'class1 class2') }}` (provided by `IconSelectExtension`, rendered through the `icon_select_svg_icon` theme hook). The sprite path is edited on the `icons` vocabulary edit form (stored as `icon_select.settings:path`, default `icons/icon_select_map.svg`, relative to the public files folder), and the sprite can be regenerated on demand with `drush generate-sprites` (alias `gens`). JS loads the sprite via XHR (compatible with S3FS given proper CORS). The module defines no permissions or config schema of its own and has no dedicated settings route.

---

- Build a reusable library of SVG icons managed as taxonomy terms in the Drupal admin.
- Give editors a visual icon picker instead of an autocomplete when choosing an icon.
- Reference an icon from a content type via an entity-reference field to the `icons` vocabulary.
- Render a chosen icon on a node using the "SVG Icon" field formatter.
- Output an icon inline in a Twig template with `{{ svg_icon('ui-check') }}`.
- Add CSS classes to a Twig-rendered icon: `{{ svg_icon('ui-check', 'icon--large') }}`.
- Serve all icons from a single sanitized SVG sprite sheet for performance.
- Automatically regenerate the sprite whenever an icon term is added, edited or removed.
- Regenerate the sprite manually after bulk changes with `drush generate-sprites`.
- Sanitize uploaded SVGs (strip scripts/exploits) via enshrined/svg-sanitize before serving.
- Enforce unique, lowercase symbol IDs so each icon has a distinct `<symbol id>`.
- Change where the sprite file is written by editing the path on the icons vocabulary form.
- Store icons on a CDN / S3 bucket (S3FS-compatible) with the sprite loaded over XHR.
- Provide a consistent icon set to both back-end editors and front-end theme templates.
- Swap an icon site-wide by replacing one term's SVG file (sprite updates automatically).
- Use icons in menus, cards, or CTAs by referencing their symbol IDs in templates.
- Give a "category" or "tag" taxonomy an associated icon by adding an icon reference field.
- Preview icons directly in the picker widget when editing content.
- Keep icon markup out of content, referencing shared symbols by ID instead.
- Support theming icons via the `icon` and `icon--<symbol-id>` CSS classes added automatically.
- Handle icons missing a viewBox gracefully (the generator emits a visible placeholder).
- Build a design-system icon component backed by editorially managed SVGs.
- Localize/curate an icon set per site while reusing the same rendering pipeline.
- Integrate icons into custom render arrays via the `icon_select_svg_icon` theme hook.
