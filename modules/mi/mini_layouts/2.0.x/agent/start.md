# Mini Layouts — agent index

Reusable Layout Builder sections exposed as placeable blocks — a modern "Mini Panels". Define a
`mini_layout` config entity, lay out blocks on its Layout Builder canvas, then place it anywhere as a
derived block. Requires core `layout_builder`. Single permission `administer mini layouts`.
Managed at `admin/structure/mini_layouts` (`configure` = `entity.mini_layout.collection`).

- **Create/edit a mini layout, required contexts, where config lives, how it renders as a block** →
  [configure/mini-layout.md](configure/mini-layout.md)

Key facts:
- Config entity `mini_layout` (`Drupal\mini_layouts\Entity\MiniLayout`), config_export: `id`,
  `admin_label`, `category`, `required_context`, `sections`, `locked`. Schema:
  `mini_layouts.mini_layout.*`; `sections` uses core `layout_builder.section`.
- Derived block: `MiniLayoutBlockDeriver` → block id `mini_layout:<id>` (label = `admin_label`,
  category = `category` or "Layouts", context defs from `required_context`).
- Section storage plugin: `@SectionStorage("mini_layout", weight=20)` bridges entity ↔ Layout Builder;
  edit canvas at route `layout_builder.mini_layout.view`.
- Rendering (`MiniLayout::build()`): builds contexts (required + context repository +
  `display`/`layout_builder.entity`), invokes `hook_layout_builder_view_context_alter`, renders each
  section via `Section::toRenderArray($contexts)`.
- No Drush; access via `admin_permission = "administer mini layouts"` (list/add/edit/delete + Layout tab).
