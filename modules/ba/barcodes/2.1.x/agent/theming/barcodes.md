<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig filter, theme hooks & templates

Grounded in `src/Template/Barcode.php`, `barcodes.services.yml`, `src/Hook/BarcodesRenderHooks.php`,
`templates/*.html.twig`, and `barcodes.libraries.yml`.

## The `barcode` Twig filter

Registered by the `barcodes.twig_extension` service (`Drupal\barcodes\Template\Barcode`, injected
with `@token`). The filter is declared `is_safe: html`, so its output is **not** auto-escaped.

```twig
{{ "any string" | barcode(
     type='QRCODE', color='#000000',
     height=100, width=100,
     padding_top=0, padding_right=0, padding_bottom=0, padding_left=0,
     format='svg') }}

{# All args optional & order-independent — these are the defaults: #}
{{ "any string" | barcode }}
{{ node.field_url.uri | barcode(color='red') }}
{{ product.sku.value | barcode(type='EAN13', format='png') }}
```

Signature: `filterBarcode(string $value, string $type='QRCODE', string $color='#000000',
int $height=100, int $width=100, int $padding_top=0, int $padding_right=0, int $padding_bottom=0,
int $padding_left=0, string $format='svg')`. The value is Token-replaced (`$this->token->replace()`,
no entity context) before encoding. `format` (case-insensitive) → `svg` (default) | `png`
(base64 `<img>`) | `htmldiv` | `unicode` | `binary`; an unknown format returns `''`.

## Theme hooks

`hook_theme()` (in `BarcodesRenderHooks`) registers a base `barcode` hook **plus one
`barcode__{type}` variant per symbology** (e.g. `barcode__qrcode`, `barcode__c128`,
`barcode__c39plus` — `+` becomes `plus`). The formatter and block render with
`#theme => 'barcode__' . $suffix` and attach the matching `barcodes/{suffix}` library.

Available variables: `barcode` (the pre-rendered markup for the chosen `format`), `type`, `format`,
`value`, `width`, `height`, `color`, the four paddings, `show_value`, `extended_value`, and the
per-format renders `svg`, `png`, `htmldiv`, `unicode`, `binary`.

## Templates

Every shipped template is the **same** thin wrapper — it just prints the pre-rendered markup:

```twig
<div class="barcode barcode-{{ type|replace({'+': 'plus'})|lower }}">
  <div class="code">{{ barcode|raw }}</div>
  {% if show_value %}<div class="value">{{ value }}</div>{% endif %}
</div>
```

To customize a single symbology's markup, add `barcode--{type}.html.twig` to your theme (e.g.
`barcode--qrcode.html.twig`) and use the variables above; override `barcode.html.twig` to change
all of them.

## Libraries / CSS

`barcodes.libraries.yml` defines a base `barcodes/barcodes` library and one `barcodes/{type}`
library per symbology (each depending on `barcodes/barcodes`), carrying the CSS needed to render
the `HTMLDIV` output for that type. The formatter/block attach the per-type library automatically;
if you render via the Twig filter with `format='htmldiv'`, attach the relevant library yourself.
`SVG`/`PNG` output needs no CSS.
