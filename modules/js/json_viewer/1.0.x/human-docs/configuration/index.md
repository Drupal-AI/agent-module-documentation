# Configuration

JSON Viewer has no single settings page. Instead you configure it in two places —
on a field's display settings, and on the JSON Previewer block — and both offer a
similar set of display options.

## Configure a field formatter

1. Go to the **Manage display** tab of the entity whose field holds JSON — for
   example **Structure → Content types → *(your type)* → Manage display**.
2. Find the field and, in its **Format** dropdown, choose the JSON Viewer format
   that matches the field type:
   - **JSON Viewer** for text fields (`string`, `string_long`, `text`),
   - **JSON File Viewer** for file fields,
   - **JSON Media Viewer** for entity reference fields pointing at Media.
3. Click the gear/cog icon beside the field to open its formatter settings.

The formatter settings include:

- **Color palette** — pick a colour scheme to style the JSON tree.
- **Default expansion level** — how many levels of the tree are expanded when the
  page first loads. A low number keeps deep JSON tidy; a higher number shows more
  at a glance.

Click **Update**, then **Save** the display.

## Configure the JSON Previewer block

Place the **JSON Previewer** block from **Block layout**
(`/admin/structure/block`), then open its configuration. Its settings include:

- **Initial JSON Data** — the default JSON content shown in the editor/preview.
- **Color palette** — the colour scheme for the JSON tree, as with the
  formatters.
- **Default expansion level** — how many tree levels are expanded on load.
- **Display controls** — toggles for which buttons the block shows: **Expand
  All**, **Collapse All**, **Search**, and **Fullscreen**.

Save the block placement to apply your choices.

## For developers

If you need palettes beyond the built-in choices, other modules can add or remove
them via the `hook_json_viewer_color_palettes_alter()` hook. You can also
override the module's Twig templates
(`json-previewer-block.html.twig`, `json-viewer.html.twig`) in your theme to
customise the markup — copy the template into your theme's `templates/` directory
and run `drush cr` to register it.
