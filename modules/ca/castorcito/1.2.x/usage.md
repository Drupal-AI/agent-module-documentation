Castorcito lets site builders assemble reusable, configurable UI components in an admin interface and drop them into any content entity through a JSON field, rendering them with overridable Single Directory Components.

---

Castorcito is a no-code component builder for Drupal. A "component" (`castorcito_component` config entity) is composed of typed cfields — plain text, formatted (WYSIWYG) text, image, link, boolean, number, list/select, iframe/video, entity reference, block reference, and layout containers — configured from `/admin/castorcito/component`. To use a component you add a Drupal JSON field (from the `json_field` module) to a bundle, set its form widget to "Castorcito Component" (choosing which components are allowed), and set its display formatter to "Castorcito Component". Editors then build content with a Vue-based UI; the assembled data is stored as JSON and rendered on view through an SDC whose markup, CSS and JS can be overridden from a theme via the SDC `replaces` key. Components are grouped by categories, can be cloned, and can restrict themselves to living only inside containers. Sub-modules add ready-made component packs (basepack, advancedpack), extra cfield types (date, webform), and configuration export/import (sync).

---

- Build a landing-page hero/banner component with heading, body text, background image and a call-to-action link, reusable across many pages.
- Add a "card grid" using a container component whose allowed children are card components, with configurable min/max items.
- Let editors assemble tabbed or accordion content sections without touching Twig or CSS.
- Create image galleries or carousels/sliders (via castorcito_basepack / castorcito_advancedpack) that content authors populate per node.
- Embed YouTube or Vimeo videos through the iframe cfield with per-provider width/height and playback options.
- Attach a JSON field to nodes, taxonomy terms, media, users, blocks or commerce entities and reuse the same component library everywhere.
- Provide a formatted-text cfield restricted to specific text formats so editors get a controlled WYSIWYG inside a component.
- Reference existing Drupal blocks (block_reference cfield) or render referenced entities in a chosen view mode (entity_reference cfield) inside a component.
- Embed a Webform inside a component with the castorcito_webform sub-module.
- Add date/datetime values to components with the castorcito_date sub-module, formatted with a chosen date format.
- Override a component's markup per theme by copying its SDC into the theme's `components/` directory and declaring `replaces: 'castorcito:<sdc>'`.
- Override display settings (image style, on/off labels, date format, CSS classes, HTML id) per view-display without editing the component definition.
- Add CSS classes or an HTML id to a rendered component using the reserved `component_classes_text`, `component_classes_select`, and `component_id` options.
- Clone a shipped basepack/advancedpack component to customise it while keeping the original as a backup.
- Group repeated container items (e.g. render items in rows of N) using the container `group_items` settings.
- Prevent deletion of a component that is still in use, and inspect where a component is used from the "in use" modal/page.
- Export selected (or all) Castorcito components and their categories as a config tarball and import them into another site with castorcito_sync.
- Bulk-migrate existing JSON fields onto the Castorcito widget across many entity types via the module's update hooks.
- Restrict which block providers can be referenced by a block_reference cfield.
- Upload images (including SVGs, which are sanitised) directly from the component editor via the module's AJAX upload endpoint.
- Serve component-attached files from private storage, with access tied to the parent entity's view access.
