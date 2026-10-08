# Configure embed buttons & the filter

Entity Embed adds no top-level settings page (only one flag, `entity_embed.settings:
rendered_entity_mode`). Setup is done through **Embed buttons** (config entities defined by
the `embed` module, `embed.button.*`) plus a text format.

## Steps (UI)
1. **Text editor embed buttons** — `/admin/config/content/embed/button` → *Add embed button*.
   - **Embed type**: `Entity`.
   - **Entity type**: node, media, file, user, taxonomy_term, …
   - **Bundles**: restrict which bundles are selectable (empty = all).
   - **Allowed Entity Embed Display plugins**: which display plugins the editor may pick.
   - Optional **Entity browser** + *display review* step for selecting existing entities.
   - Upload a button **icon**.
2. **Text formats** — `/admin/config/content/formats` → edit a format:
   - Drag the new button into the CKEditor toolbar.
   - Enable the **"Display embedded entities"** filter (`entity_embed`).
   - Order filters so *Display embedded entities* runs appropriately (before "Restrict HTML"
     issues) and allow the `<drupal-entity>` tag if using "Limit allowed HTML tags".

## Embed button as config
`embed.button.node.yml`:
```yaml
label: Node
id: node
type_id: entity
type_settings:
  entity_type: node
  bundles: {  }              # empty = all bundles
  display_plugins: {  }      # empty = all allowed display plugins
  entity_browser: ''         # optional entity_browser id
icon_uuid: null
```

## In-body markup
The button inserts a placeholder the filter renders on output:
```html
<drupal-entity data-entity-type="node" data-entity-uuid="…"
  data-entity-embed-display="view_mode:node.teaser"
  data-entity-embed-display-settings='{"view_mode":"teaser"}'
  data-align="right" data-caption="A caption"></drupal-entity>
```
`data-entity-embed-display` is the chosen Entity Embed Display plugin id
(see [../plugins/display.md](../plugins/display.md)).
