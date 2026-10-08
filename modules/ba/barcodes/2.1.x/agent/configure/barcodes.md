<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the barcode formatter & block

Grounded in `src/Plugin/Field/FieldFormatter/Barcode.php`, `src/Plugin/Block/Barcode.php`,
and `config/schema/barcodes.schema.yml`. There is **no admin settings form** for the module
(`configure` = null); you configure it per view-display (formatter) or per placed block.

## Shared settings (identical keys for formatter and block)

| Key | Type | Default | Notes |
|---|---|---|---|
| `type` | string | `QRCODE` | Symbology short-code. Options come from `Com\Tecnick\Barcode\Barcode::BARCODETYPES`. `drush barcodes:formats` lists them all. |
| `format` | string | `SVG` | One of `PNG`, `SVG`, `HTMLDIV`, `UNICODE`, `BINARY`. |
| `color` | string | `#000000` | HTML color (`#type => color` picker). |
| `height` | int | `100` | Pixels. |
| `width` | int | `100` | Pixels. |
| `padding_top` / `padding_right` / `padding_bottom` / `padding_left` | int | `0` | Pixels. |
| `show_value` | bool | `false` | Also print the raw value under the barcode. |

The **block** adds one extra key: `value` (string, default `''`) — the text to encode; it is
token-aware (a `token_tree_link` + `token_element_validate` appear when the Token module is on,
with `node` token types). The **formatter** has no `value` key — it encodes the field's own value.

## Field formatter

- Plugin id `barcode`. Attach it under *Structure → Content types → …→ Manage display* (or any
  entity display) for a field of type `email`, `integer`, `link`, `string`, `telephone`, `text`,
  `text_long`, `text_with_summary`, `bigint`, or `uuid`.
- `link` fields are always encoded as an **absolute** URL (`viewValue()` forces `absolute => TRUE`).
- The field value is passed through the Token service with the host entity in context
  (`$tokens[$entity_type] = $entity`) before being encoded.

Set it from the CLI on an existing view-display (example: article body teaser display):

```bash
drush php:eval '
$d = \Drupal::service("entity_display.repository")->getViewDisplay("node","article","default");
$d->setComponent("body", ["type" => "barcode", "settings" => [
  "type" => "QRCODE", "format" => "SVG", "color" => "#000000",
  "width" => 120, "height" => 120, "show_value" => TRUE,
]])->save();
print "ok\n";'
```

## Block

- Plugin id `barcode`, admin label "Barcode". Place it via *Structure → Block layout → Place block*,
  or in code/config. `value` supports tokens resolved against entities in the current route
  (e.g. `[node:url]` on a node page).

## Output format semantics (all surfaces)

- `SVG` → inline SVG markup (`getSvgCode()`).
- `PNG` → an `<img src="data:image/png;base64,…">` element.
- `HTMLDIV` → `getHtmlDiv()` (CSS-styled `<div>` bars; needs the per-type CSS library).
- `UNICODE` / `BINARY` → a `<pre>` ASCII/Unicode grid.

On a generator exception (e.g. a value invalid for the chosen symbology) nothing renders and the
error is logged to the `barcodes` logger channel — the element is simply empty.
