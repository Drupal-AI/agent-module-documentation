# Configure the Mermaid Diagram field

There is no global settings page (the `configure` route in `.info.yml`,
`entity.cm_document.config_form`, does not exist in this module). You add the field to a bundle, choose
the widget on *Manage form display*, and choose/configure the formatter on *Manage display*.

## Field type `mermaid_diagram`

Storage columns (`MermaidDiagramItem::schema()`):

| Subfield | Column type | Required property | Purpose |
|---|---|---|---|
| `title` | varchar(255) | yes | Diagram heading (`<h2>`). |
| `diagram` | text (medium) | yes | The Mermaid source to render. |
| `caption` | text (medium) | yes | Accessible caption (`<figcaption>`). |
| `key` | text (small) | no | Optional legend, rendered as a second Mermaid diagram. |
| `show_code` | int tiny | no | Flag: expose raw code in a `<details>` pane. |
| `allow_download` | int tiny | no | Flag: show a "Download .mermaid" button. |

`isEmpty()` is true only when title, caption **and** diagram are all empty.
Default widget: `mermaid_diagram_widget`; default formatter: `mermaid_diagram_formatter`.

## Widget `mermaid_diagram_widget`

Plain form elements: `title` textfield; `diagram`, `key`, `caption` textareas; `show_code` and
`allow_download` checkboxes. No widget settings.

## Formatter `mermaid_diagram_formatter`

`defaultSettings()`:

| Setting | Type | Default | Meaning |
|---|---|---|---|
| `display_in_modal` | bool | `false` | Render a `use-ajax` modal link instead of the inline diagram. |
| `modal_link_text` | string | `View diagram` | Link text when `display_in_modal` (link shows `<text>: <item title>`). |
| `extra_settings` | string (JSON) | `''` | Raw JSON passed to `mermaid.initialize()`. Validated as JSON on save. |

- **Inline** (default): builds `#theme => 'mermaid_diagram'` with the item subfields and attaches the
  `mermaid_diagram_field/diagram` library.
- **Modal**: builds a link to route `mermaid_diagram_field.modal`
  (`/mermaid-diagram/modal/{entity_type}/{entity_id}/{field_name}/{delta}`) with `data-dialog-type=modal`,
  width 90%, attaching `core/drupal.dialog.ajax`.
- `extra_settings` JSON is decoded and merged with a forced `{'startOnLoad': false}`, then emitted as
  `drupalSettings.mermaidDiagramField.extraSettings` and handed to `mermaid.initialize()` in
  `js/diagram.js`. Use it for `theme`, `securityLevel`, `flowchart`, `themeVariables`, etc.
  This is a per-formatter (admin/display) setting; do not lower `securityLevel` if untrusted users author
  the diagram source.

Config schema `field.formatter.settings.mermaid_diagram_formatter` covers `display_in_modal`,
`modal_link_text`, `extra_settings`.

## Libraries (CDN by default)

`mermaid_diagram_field.libraries.yml`:
- `diagram` → `css/diagram.css` + `js/diagram.js`, depending on `core/drupal`, `core/drupalSettings`,
  and the CDN libraries below.
- `mermaid` → `https://cdn.jsdelivr.net/npm/mermaid@11.11.0/dist/mermaid.min.js` (external).
- `svg_pan_zoom` → `https://cdn.jsdelivr.net/npm/svg-pan-zoom@3.6.2/dist/svg-pan-zoom.min.js` (external).

To self-host, override these library definitions in a custom module/theme's
`*.libraries.yml`/`hook_library_info_alter()` (the commented local path
`/libraries/mermaid/mermaid.min.js` in the YAML hints at the intended local layout).

## Set the field's formatter with Drush (example)

```php
// drush php:eval — inline formatter with a dark Mermaid theme
$fd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$fd->setComponent('field_diagram', [
  'type' => 'mermaid_diagram_formatter',
  'settings' => ['display_in_modal' => FALSE, 'extra_settings' => '{"theme":"dark"}'],
])->save();
```
