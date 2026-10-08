# Enhanced Views block display

`ctools_views` replaces core's Views `Block` display plugin with
`Drupal\ctools_views\Plugin\Display\Block` (a subclass of core `views\...\display\Block`),
swapped in via `hook_views_plugins_display_alter()`. No configuration is required — enabling
the module is enough.

Once enabled, placing any view's **Block** display through **Admin → Structure → Block layout**
shows extra fields in the block's settings form (the `blockForm()` override):

| Setting | Effect |
|---|---|
| Items per block / offset | Override the display's item count and result offset for this placement. |
| Pager | Choose pager type (view default, full, mini, some, none). |
| Fields | Hide and/or re-weight individual fields for this block only. |
| Exposed filters | Set/override exposed filter values (incl. entity autocomplete) in block config. |
| Exposed sort | Override sort field/order for this block. |

These are saved into the block's configuration, so the same view display can back several
blocks with different settings. The extra keys (`pager`, `fields`, `filter`, `sort_*`) are
added to the `views_block` config schema through `hook_config_schema_info_alter()` in
`ctools_views.module`, making them storable and translatable.

Programmatic/theming impact: none beyond standard Views block rendering — the plugin only adds
settings and applies them to the executed view before render.
