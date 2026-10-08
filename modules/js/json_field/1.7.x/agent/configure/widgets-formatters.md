<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Widget and formatters

## Widget `json_textarea` — "Plain textarea (multiple rows)"

`JsonTextareaWidget` is an empty subclass of core's `StringTextareaWidget`, so its settings
schema is `field.widget.settings.string_textarea` (`rows`, `placeholder`). Nothing
JSON-specific happens in the widget; validation comes from the `valid_json` constraint.

```yaml
# core.entity_form_display.node.article.default
content:
  field_payload:
    type: json_textarea
    settings: { rows: 5, placeholder: '' }
```

The nicer editor (`json_editor`, JSON Editor / ACE) is in the **submodule**
`json_field_widget` → [../../../modules/json_field_widget/1.7.x/agent/start.md](../../../modules/json_field_widget/1.7.x/agent/start.md).

## Formatter `json` — "Plain text" (default)

Renders each item through the `json_text` render element:
`<pre class="json-field"><code>…raw string…</code></pre>`.

One setting:

| key | default | effect |
|---|---|---|
| `attach_library` | `true` | attaches the `json_field/json_field.formatter` library (jQuery JSONView + `assets/js/json_field.js`), which turns the `<pre>` into a collapsible tree. Set `false` to emit plain markup with no JS. |

Schema: `field.formatter.settings.json` → `attach_library` (boolean).
The settings summary reads `Attach library: Yes|No`.

The JSONView library must be downloaded to
`/libraries/jquery-jsonview/dist/jquery.jsonview.{js,css}`; if it is absent the formatter
still renders, just without the tree UI (and the status report warns).

## Formatter `pretty` — "Pretty"

No settings. `json_decode()`s the value and renders it through the `json_pretty` render
element as nested HTML: arrays → `<ul><li>`, objects → `<dl><dt>key</dt><dd>value</dd>`,
`null` → `null`, booleans → `true`/`false`, empty array → `[empty array]`, empty object →
`{empty object}`, scalars HTML-escaped. Attaches only a small CSS library
(`json_field/json_field.pretty`) — no JS, so it works with no external library installed.
Invalid JSON decodes to `NULL` and renders as `null`.

## Switching formatter with Drush

```php
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd->getComponent("field_payload");
  $c["type"] = "pretty";          // or "json"
  $c["settings"] = [];            // json takes ["attach_library" => TRUE|FALSE]
  $vd->setComponent("field_payload", $c)->save();
'
```

```bash
drush cget core.entity_view_display.node.article.default content.field_payload
```

## Libraries defined

| library | contents |
|---|---|
| `json_field/jquery.jsonview` | `/libraries/jquery-jsonview/dist/jquery.jsonview.{js,css}` (external, must be downloaded) |
| `json_field/json_field.formatter` | `assets/js/json_field.js` + `assets/css/json_field.css`, depends on the above |
| `json_field/json_field.pretty` | `assets/css/json-pretty.css` only |
