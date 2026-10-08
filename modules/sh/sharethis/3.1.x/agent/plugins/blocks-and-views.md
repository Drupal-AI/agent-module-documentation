# ShareThis — blocks & Views field

These are plugins of core's existing Block and Views types; ShareThis defines no plugin type of
its own.

## Block: `sharethis_block`

`src/Plugin/Block/SharethisBlock.php` — `@Block(id = "sharethis_block", admin_label =
@Translation("Sharethis"))`. Renders the share buttons for the **current page** (title + URL
come from the current route/page). Place it in any region via *Block layout*. Uses
`sharethis.manager->blockContents()` → `renderSpans()`.

```bash
# place the block programmatically in the sidebar of the default theme
drush ev '\Drupal\block\Entity\Block::create([
  "id" => "sharethis_demo",
  "plugin" => "sharethis_block",
  "region" => "sidebar_first",
  "theme" => \Drupal::config("system.theme")->get("default"),
  "settings" => ["id" => "sharethis_block", "label" => "Share", "label_display" => "visible"],
])->save();'
```

## Block: `sharethis_widget_block`

`src/Plugin/Block/SharethisWidgetBlock.php` — `@Block(id = "sharethis_widget_block",
admin_label = @Translation("Sharethis Widget"))`. Like the basic block but shares a **specific
path / external URL** you configure, not the current page. Block settings (schema
`block.settings.sharethis_widget_block`):

| Setting | Meaning |
|---|---|
| `sharethis_path` | internal path to share. |
| `sharethis_path_external` | external URL to share. |

## Views field: `sharethis_node`

`src/Plugin/views/field/SharethisNode.php` — `@ViewsField("sharethis_node")`, extends
`FieldPluginBase`. Adds a "ShareThis" column to a View so each row renders share buttons for its
node. Add it in the Views UI as a field, or in `views.view.*` config with
`plugin_id: sharethis_node`.

## Rendering pipeline

All three ultimately call `sharethis.manager->renderSpans($data_options, $title, $path)`, which
themes `sharethis_block` (`templates/sharethis-block.html.twig`) and attaches the external
libraries `sharethis/sharethis`, `sharethis/sharethispickerexternalbuttons(ws)`. See
[../api/manager.md](../api/manager.md).
