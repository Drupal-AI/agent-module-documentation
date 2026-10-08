<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# barcodes — agent start

Renders values as barcodes/QR codes via the `tecnickcom/tc-lib-barcode` library. Four surfaces
over one generator, all sharing the same options (`type`, `format`, `color`, `width`, `height`,
four paddings, `show_value`): a **field formatter**, a **block**, a **Twig filter**, and **Drush**.
No permissions, no config entities, no dependencies (Token is a soft/optional integration).
`configure` route = null (settings live on the view-display / block config).

Options recap: `type` = symbology short-code (`QRCODE`, `C128`, `EAN13`, `DATAMATRIX`, `PDF417`,
`AZTEC`, … — full list via `drush barcodes:formats`). `format` = `SVG` (default) | `PNG`
(base64 data-URI `<img>`) | `HTMLDIV` | `UNICODE` | `BINARY` (ASCII grid).

- Field-formatter settings + block settings + settings keys → [configure/barcodes.md](configure/barcodes.md)
- The `barcode` Twig filter, theme hooks & per-type templates/CSS → [theming/barcodes.md](theming/barcodes.md)
- Drush `barcodes:generate` / `barcodes:formats` → [drush/barcodes.md](drush/barcodes.md)

Key names: formatter/block plugin id `barcode`; Twig filter `barcode` (class
`Drupal\barcodes\Template\Barcode`, `is_safe: html`); theme hooks `barcode` + `barcode__{type}`;
libraries `barcodes/{type}`; generator `Com\Tecnick\Barcode\Barcode::getBarcodeObj()`. Field types
the formatter accepts: `email, integer, link, string, telephone, text, text_long,
text_with_summary, bigint, uuid`. Values are Token-replaced before encoding.
