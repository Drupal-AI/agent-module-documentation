Layout Components extends Drupal core Layout Builder with a visual, AJAX-driven section/column/component builder, ready-made components, live preview, and copy/paste of layout elements.

---

Layout Components (LC) sits on top of core Layout Builder and rewrites its editing experience: it overrides Layout Builder's choose-block, choose-section, add/update-block, configure-section and remove routes with its own controllers and forms, adds a lateral dialog UI with live preview and tooltips, and provides its own Bootstrap-grid layout plugins (one through six columns) rendered through the `LcBase` layout plugin and the `layoutcomponents.render` service. Each section, column and title gets extensive styling controls (background image/video/color, borders, radius, paddings, sizing/height, alignment, extra CSS classes and free-form extra attributes, and role-based visibility). Editors can copy and paste whole sections, single columns or individual blocks through a per-user private-tempstore clipboard, nest sub-sections inside columns, and mark a section as a reusable "default/overwrite" configuration. Five site-wide settings forms (General, Interface, Colors, Section, Column) seed the defaults new sections inherit. A form-element API (the `Api\*` builder classes, the `LcElement` render element, the `LcColorField` form element, and a `layoutcomponents_field_reference` field type/widget/formatter) lets developers author their own LC components; roughly 23 `lc_*` submodules ship pre-built components and are documented separately.

---

- Turn an entity's Layout Builder tab (e.g. a node bundle's layout) into a richer visual builder without writing Twig.
- Build multi-column page sections with a 1–6 column Bootstrap grid picked from the LC layout list.
- Give a section a background image (via Media library) or background video and overlay content on top of it.
- Set a solid or RGBA background color on sections and columns using the integrated color-field picker.
- Add per-section and per-column titles with configurable HTML tag, color/opacity, alignment, size, spacing and border.
- Apply borders (type, size, color) and corner radius independently to each column.
- Control section sizing (full width, container, title-container) and height (auto, manual px, or a preset).
- Add or remove top/bottom and left/right paddings on sections and columns from the UI.
- Attach arbitrary extra CSS classes and extra HTML attributes to sections/columns for theming hooks.
- Restrict which roles can see a given section or column via the built-in role-based visibility settings.
- Copy a configured section to the clipboard and paste it into another region, display or entity.
- Copy a single column (with all its blocks) or an individual block and duplicate it elsewhere.
- Nest sub-sections inside a column to create infinite/recursive grid structures.
- Configure a section once and mark it "overwrite/default" so it is locked and reused across content.
- Seed site-wide defaults for new sections and columns from the Section and Column settings forms.
- Curate the editor color palette centrally through the Colors settings form.
- Switch the builder interface theme (light/dark) through the Interface settings form.
- Set where exported blocks are stored and the lateral menu width through the General settings form.
- Reference and render a field from the current (or a chosen) entity inline via the `layoutcomponents_field_reference` field type.
- Embed a View (via viewsreference) or Slick carousel as a component inside a column.
- Add ready-made components — accordion, card, countdown, tabs, timeline, image variants, social links, iframe, video — by enabling the matching `lc_*` submodule.
- Import/export block content between displays using the `lc_commands` submodule's Drush commands.
- Grant granular per-bundle editing rights (create/move/remove/configure/copy sections, columns and blocks) through the module's dynamic permissions.
