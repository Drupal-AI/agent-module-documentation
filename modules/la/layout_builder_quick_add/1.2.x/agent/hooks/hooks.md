# Hooks & routes — the add-block rewrite mechanism

All hooks live in `layout_builder_quick_add.module`. This is how the module hijacks the core
"Add block" link.

## hook_element_info_alter — the core mechanism

```php
function layout_builder_quick_add_element_info_alter(array &$types) {
  $types['layout_builder']['#pre_render'][] = [LayoutBuilderQuickAddHelper::class, 'layoutBuilderPreRender'];
}
```

`LayoutBuilderQuickAddHelper::layoutBuilderPreRender()` (a `TrustedCallbackInterface` callback)
walks every section/region of the rendered `layout_builder` element and, for each region's
`layout_builder_add_block` link, rewrites its `#url` from core's chooser to
`Url::fromRoute('layout_builder_quick_add.add_blocks', $route_parameters, ...)`, keeping the
original link's `class` attribute (dropping the off-canvas dialog options). It also attaches the
`layout_builder_quick_add/<theme>` CSS library unless `theme` is `none`. Net effect: clicking
"Add block" now hits the module's AJAX route instead of opening the core off-canvas sidebar.

## Routes / controller (not a hook, but the other half)

`layout_builder_quick_add.routing.yml` + `LayoutBuilderQuickAddController`:

| Route | Path | Requirement | Controller method | Effect |
|-------|------|-------------|--------------------|--------|
| `layout_builder_quick_add.add_blocks` | `/layout_builder/quick_add_blocks/{section_storage_type}/{section_storage}/{delta}/{region}` | `_layout_builder_access: 'view'` (+ `layout_builder_tempstore` param on `section_storage`) | `addBlocks()` | Returns an `AjaxResponse` that inserts the `quick_add_blocks_listing` render (a list of enabled block types) after the add link and hides the add link. |
| `layout_builder_quick_add.cancel_add_blocks` | `/layout_builder/quick_cancel_add_blocks/{…same…}` | `_layout_builder_access: 'view'` (+ tempstore) | `cancelAddBlocks()` | Returns an `AjaxResponse` that removes the listing DOM and re-shows the add link. |

Neither controller method mutates or saves the layout. `addBlocks()` only builds a listing whose
per-item links point to CORE `layout_builder.add_block` (with
`plugin_id = inline_block:<block_content_type_id>`); the "See more blocks" link points to core
`layout_builder.choose_block`. The real insertion + tempstore write is therefore performed by
core's own add-block form flow, under core's access and form handling.

## hook_form_alter — icon on block-type edit

On `block_content_type_edit_form`, adds a `managed_file` element `layout_builder_quick_add_icon`
(upload location `public://layout_builder_quick_add`). Its submit callback
`layout_builder_quick_add_form_submit()` marks the file permanent and stores its id as a
third-party setting: `$block_content_type->setThirdPartySetting('layout_builder_quick_add', 'icon', $fid)`.
See [../theme/theme.md](../theme/theme.md) for where the icon is read/rendered.

## hook_page_attachments_alter — theme support libraries

When `layout_builder_quick_add.settings:theme` is `gin`, and the active admin/front theme resolves
to Gin, and the current route is a Layout Builder route (`layout_builder.overrides.*` /
`layout_builder.defaults.*`), it attaches `gin/gin_base`, `gin/gin_accent`, `gin/gin_init` and
mirrors Gin's `drupalSettings` (darkmode, accent/focus colors, high-contrast, toolbar variant) so
the listing matches Gin's look. The `claro` branch is a no-op stub.

## hook_theme

Declares `quick_add_blocks_listing` and `quick_add_blocks_listing_item` — see
[../theme/theme.md](../theme/theme.md).

## Install / update

- `hook_install`: if the site admin theme is `gin`, sets `settings:theme` to `gin`.
- `layout_builder_quick_add_update_8001`: sets `settings:theme` to `default` for sites that
  installed before the theme setting existed.
