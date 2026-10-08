# The layout plugin it provides

Dynamic Layouts does **not** define a new plugin *type*. It provides a single core `@Layout` plugin
with a deriver, so every `dynamic_layout` config entity you create surfaces as its own layout in
Layout Builder / Display Suite / Panels.

## Plugin + deriver

- Plugin: `\Drupal\dynamic_layouts\Plugin\Layout\DynamicLayout` (extends `LayoutDefault`).
  ```
  @Layout(
    id = "dynamic_layout",
    admin_label = @Translation("Dynamic layout"),
    category = @Translation("Dynamic layout category"),
    deriver = "Drupal\dynamic_layouts\Plugin\Derivative\DynamicLayoutDeriver"
  )
  ```
- Deriver: `\Drupal\dynamic_layouts\Plugin\Derivative\DynamicLayoutDeriver`. Loads all `dynamic_layout`
  entities and emits one `LayoutDefinition` per entity, keyed by entity id — so the usable plugin ids
  are `dynamic_layout:<layout_id>`.

Each derived definition sets: `label` = entity label, `category` = entity `category`,
`class` = the DynamicLayout plugin, `regions` = `$entity->getLayoutRegions()`,
`icon_map` = `$entity->getIconMap()`, `template` = `dynamic-layout-frontend`
(path `<module>/templates`), plus a `config_dependencies` entry on the layout entity (so a Layout
Builder section that uses the layout depends on that config).

## Runtime render

`DynamicLayout::build($regions)`:
1. Splits its plugin id `dynamic_layout:<id>` to load the config entity and read `getRows()`.
2. Emits only the regions declared by the plugin definition, in order.
3. Sets `#theme` = the definition's theme hook (`dynamic-layout-frontend`), `#wrapperClasses`
   (`<frontend_library>-<grid_column_count>`), and attaches `dynamic_layouts/dynamic_layouts_frontend`
   CSS when the frontend library is `custom`.
4. Template `templates/dynamic-layout-frontend.html.twig` prints row/column classes
   (`default_row_class`, `custom_row_classes`, `<prefix>-<width>`, `default_column_class`,
   `custom_column_classes`) into `class="…"` attributes and renders each region's placed content at
   `content[column.region_name]`. Class strings are printed with Twig `{{ }}` (autoescaped).

## Adding "a layout"

There is no code plugin to write — a site builder adds a layout by creating a `dynamic_layout` entity
(UI or entity API, see [configure/layouts.md](../configure/layouts.md)). The deriver + a plugin cache
clear (done automatically on entity save/delete) make it appear.

## Libraries / theme

- `dynamic_layouts.libraries.yml`: `dynamic_layouts` (admin JS+CSS for the builder form) and
  `dynamic_layouts_frontend` (front-end CSS, attached only for the `custom` library).
- `hook_theme()` registers `dynamic_layouts_backend` (the admin row template,
  `templates/dynamic-layouts-backend.html.twig`); the frontend template is registered via the
  derived layout definition, not `hook_theme()`.
