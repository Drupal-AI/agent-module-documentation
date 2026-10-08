# Configure Paragraphs Grid

## Global settings form
Route `paragraphs_grid.paragraphs_grid_config_form` → `/admin/config/content/paragraphs_grid`.
Permission **`use paragraphs_grid config form`** — declared `restrict access: TRUE` (its own
description warns it can cause data loss by switching grid systems). Config object
`paragraphs_grid.settings` (`config/install/paragraphs_grid.settings.yml`):

| Key | Default | Meaning |
|---|---|---|
| `gridtype` | `paragraphs_grid.grid_entity.bs4` | The active `grid_entity` (config id) that defines breakpoints/classes. |
| `uselibrary` | `1` | Whether the module attaches its own grid CSS library on the front end. Set 0 to use your theme's own Bootstrap/grid CSS. |
| `use_lib_admin_pages` | `0` | Also attach the grid CSS on admin pages so the edit preview matches. |

## The grid system: `grid_entity` config entity
`@ConfigEntityType(id = "grid_entity")`, config prefix `paragraphs_grid.grid_entity.*`,
`admin_permission = administer site configuration`. Four presets ship in `config/install/`:
`bs3`, `bs4`, `bs5`, `mdc`. Each describes:
- `breakpoints`: xs/sm/md/lg/xl/xxl with `cols`, `name`, `icon`, `bpoint` label, class
  `fragment` (e.g. `-md`).
- `wrapper`: `grid` (container / container-fluid / none) and `row` options.
- `cell-fallback` (e.g. `col-12`) and `cell-properties`:
  - `col` — formatter `col%bp-%cols`, plus `additional` classes `auto`/`full`/`hide`.
  - `offset` — formatter `offset%bp-%cols`.
  - `order` — formatter `order%bp-%cols`, plus `first`/`last`.
- `library`: the asset library to load for this system (e.g. `paragraphs_grid/paragraphs_grid.bootstrap5`).

To add a **custom** grid framework, create a new `paragraphs_grid.grid_entity.<id>.yml`
mirroring a preset (adjust `fragment`s, `cell-properties.*.formatter`, and `library`) and
select it as `gridtype`.

## Setup outline
1. Enable the module; pick a `gridtype` on the settings form.
2. Add a **Paragraphs grid** (`grid_field_type`) field to the paragraph type (or its host
   entity) — see plugins/field.md.
3. Set the field's form widget to **Grid widget** and its display to a grid formatter.
4. Editors then choose columns per breakpoint per paragraph.
