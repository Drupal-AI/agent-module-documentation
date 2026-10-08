# Create & configure a Mini Layout

Managed at **Structure → Mini Layouts** (`entity.mini_layout.collection`,
`/admin/structure/mini_layouts`). All operations require the `administer mini layouts` permission
(the entity's `admin_permission`).

## Two-step editing

1. **Settings form** (`MiniLayoutForm`, add: `/admin/structure/mini_layouts/add`, edit:
   `/admin/structure/mini_layouts/manage/{id}`):
   - **Administrative Label** (`admin_label`) — shown when placing the block, not to end users.
   - **Machine name** (`id`).
   - **Category** (`category`) — grouping in the block chooser; empty → deriver uses "Layouts".
   - **Required Context** table — add contexts the layout needs (label, machine name, type from the
     typed-data definitions, required checkbox). Each becomes a block context definition.
2. **Layout tab** (`MiniLayoutLayoutBuilderForm`, route `layout_builder.mini_layout.view`) — the core
   Layout Builder canvas where you add sections and blocks that make up the reusable unit.

## Config entity shape

```yaml
# mini_layouts.mini_layout.<id>  (schema: mini_layouts.mini_layout.*)
id: my_cta
admin_label: 'CTA band'
category: Marketing
required_context:
  node:
    machine_name: node
    label: Node
    type: 'entity:node'
    required: true
sections:            # core layout_builder.section list
  - layout_id: layout_onecol
    layout_settings: {}
    components: { ... }
locked: null
```

`config_export`: `id`, `admin_label`, `category`, `required_context`, `sections`, `locked`. The
`sections` value is a standard Layout Builder section list (managed via `SectionListTrait`), so it is
portable config and deployable between environments.

## Placing it

Each saved mini layout is exposed by `MiniLayoutBlockDeriver` as block plugin **`mini_layout:<id>`**:
- Label = `admin_label`, category = `category` (or "Layouts").
- Any `required_context` entry becomes a `ContextDefinition($type, $label, $required)` on the block, so
  the block chooser will require you to map a matching context (e.g. the current node).

Place it like any block — in a theme region via **Block Layout**, or inside another Layout Builder
section. At render time `MiniLayout::build()` loads the entity, merges your mapped contexts with the
available context repository and the mini layout entity itself (`display` /
`layout_builder.entity`), fires `hook_layout_builder_view_context_alter($contexts, $storage)`, and
renders each section with `Section::toRenderArray($contexts)`.

## Notes

- There is no global settings page; `configure` points at the entity collection list.
- Editing the mini layout updates every placement — that is the point (central reuse).
- `MiniLayoutAccessControlHandler` is the default core handler; access is governed by the
  `administer mini layouts` permission for management and normal block/context access when rendering.
