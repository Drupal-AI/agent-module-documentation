# panels — configure a display

Panels has **no settings form of its own**. `panels.info.yml` declares
`configure: panels.admin` (the "Panels Dashboard", gated by the `use panels dashboard`
permission); the module description states it "provides no external UI, at least one other
Panels module should be enabled." You build displays through **Page Manager** or the
**Panels IPE** submodule.

## The Panels display variant

`Drupal\panels\Plugin\DisplayVariant\PanelsDisplayVariant` (plugin id `panels_variant`,
admin label "Panels") extends ctools' `BlockDisplayVariant`. Add it to a Page Manager page
as a variant and it stores its config under the `variant_settings` key of the page variant.
`panels.module` wires the storage automatically: `panels_page_variant_create()` /
`panels_page_variant_presave()` call `$panels_display->setStorage('page_manager', $id)` so
Panels knows the display is Page-Manager–backed (which enables the IPE).

## What a display holds (config schema: `display_variant.plugin.panels_variant`)

| Key | Meaning |
|---|---|
| `layout` | Layout plugin id (core Layout Discovery, e.g. `layout_onecol`, `layout_twocol`, `layout_threecol_25_50_25`) |
| `layout_settings` | Settings for that layout (`layout_plugin.settings.[layout]`) |
| `builder` | DisplayBuilder plugin id (default `standard`; IPE uses `ipe`) |
| `storage_type` / `storage_id` | Which PanelsStorage plugin holds it and under what id |
| `page_title` | Page title (may be drawn from a pane) |
| `css_classes` (sequence), `html_id`, `css_styles` | Wrapper CSS classes / id / inline styles |

Blocks (panes) placed into the layout's regions carry their own ctools block config;
`panels_config_schema_info_alter()` adds `css_classes`, `html_id`, `css_styles` to every
`ctools.block_plugin.*`.

## Build flow

1. Create a Page Manager page and add a variant of type **Panels** (`panels_variant`).
2. **Select layout** — `LayoutPluginSelector` form. Changing it runs `LayoutChangeSettings`
   then `LayoutChangeRegions` to remap panes into the new regions.
3. **Place blocks** into regions. Block CRUD forms live at
   `/admin/structure/panels/{tempstore_id}/{machine_name}/…`:
   `select_block`, `add/{block_id}` (`PanelsAddBlockForm`), `edit/{block_id}`
   (`PanelsEditBlockForm`), `delete/{block_id}` (`PanelsDeleteBlockForm`). Access is gated
   by the `_panels_tempstore_access` check.
4. Save — the display is persisted via its PanelsStorage plugin.

For a fully on-page (front-end) editing experience instead of Page Manager wizard forms,
enable **panels_ipe**.
