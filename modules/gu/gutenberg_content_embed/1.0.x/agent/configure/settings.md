# Configure Gutenberg Content Embed

No dedicated settings page. Configuration is added to each **content type's edit form**
(`/admin/structure/types/manage/{type}`) under **Gutenberg experience → Allowed Content** (visible only
when the Gutenberg experience is enabled for that type). Added via `hook_form_alter` →
`EntityTypeConfig::formNodeTypeAlter`.

Per content type you set:
- **Allowed View Modes** — checkboxes of that bundle's view modes. A view mode must be checked for the type
  to appear as embeddable in the editor. If none are checked, the type is not embeddable.
- **Width control** — checkboxes of view modes that should offer alignment/width controls in the editor.

Stored in config `gutenberg_content_embed.settings`:
```yaml
allowed_content_embed:
  <bundle>:
    label: '<Bundle label>'
    allowed_view_modes: { <view_mode>: <view_mode>|0, ... }
    width_control: { <view_mode>: <view_mode>|0, ... }
```
(`EntityTypeConfig::formNodeTypeSubmit` writes it; `formNodeAlter` filters it to enabled entries and
exposes it to the editor as `drupalSettings.gutenbergContentEmbed.allowed`.)

## Render pipeline

- Editor JS (injected into Gutenberg's `edit-node` library) provides the "Drupal content embed" block,
  which stores `nodeId`, `viewMode`, and optional `align`/`width` attributes.
- Front end: `DrupalContentProcessor::processBlock` (`gutenberg_block_processor` tag, priority 50) loads the
  node, checks `access('view')`, renders it with the view builder in `viewMode` (default `default`), and
  wraps it in a `content-embed <bundle>-<viewmode>` container with alignment/width classes.

Note: the runtime render and both editor routes independently enforce node **view access**, but the
`load/{nid}/{viewmode}` route and the block processor honor any `viewMode` passed, not only the
admin-allowed list (the allow-list constrains the editor UI, not the render endpoints).
