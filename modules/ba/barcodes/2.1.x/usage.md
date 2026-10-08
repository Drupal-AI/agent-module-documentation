<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Barcodes renders field values, block text, arbitrary Twig strings, or CLI input as barcodes and QR codes, using the `tecnickcom/tc-lib-barcode` PHP library. It supports 40+ symbologies (QR, Code 128, EAN-13, DataMatrix, PDF417, Aztec, and more) and outputs SVG, a base64 PNG image, an HTML `<div>` grid, or a Unicode/ASCII grid.

---

The module is a thin, four-surface wrapper around `Com\Tecnick\Barcode\Barcode`. **(1)** A `barcode` **field formatter** turns text-ish fields (`email`, `integer`, `link`, `string`, `telephone`, `text`, `text_long`, `text_with_summary`, `bigint`, `uuid`) into a rendered barcode — configured per view-display under *Manage display*. **(2)** A `barcode` **block** plugin renders a free-text value (with token support) as a barcode you can place anywhere. **(3)** A `barcode` **Twig filter** (`{{ "abc"|barcode(type='QRCODE', ...) }}`) renders any string inside a template. **(4)** Two **Drush** commands, `barcodes:generate` and `barcodes:formats`, produce barcodes or list the available symbologies from the command line. All four accept the same options: `type` (symbology), `format` (`SVG` | `PNG` | `HTMLDIV` | `UNICODE` | `BINARY`), `color`, `width`, `height`, four paddings, and (formatter/block only) a `show_value` toggle. Values are passed through the Token service before encoding, so field and block values can contain entity tokens. The module defines ~40 theme hooks (`barcode`, `barcode__{type}`) plus a per-type CSS library, but ships no permissions and no config entities — formatter and block settings live on the display/block config.

---

- Display a product SKU or GTIN field as a scannable EAN-13 / UPC-A barcode on the product page.
- Render a node's canonical URL as a QR code so print visitors can jump to the page.
- Turn an event ticket ID field into a Code 128 barcode for gate scanning.
- Put a QR code of a user's profile or vCard link on their profile via the barcode block.
- Encode an order number (`integer`/`bigint` field) as a barcode on an invoice view.
- Show a `link` field as a QR code — the formatter always resolves it to an absolute URL.
- Add a site-wide "scan to visit" QR block in the footer pointing at the current page using tokens.
- Generate DataMatrix or PDF417 codes for logistics/asset-tracking labels.
- Produce Aztec codes for transport tickets/boarding passes.
- Render a telephone field as a barcode for warehouse contact labels.
- Display a UUID field as a barcode to physically tag entities with their machine id.
- Use the Twig filter to drop a QR code into a custom template: `{{ node.field_url.uri|barcode }}`.
- Recolor a barcode to match branding with `{{ value|barcode(color='#663399') }}`.
- Emit a PNG barcode (base64 data-URI `<img>`) instead of SVG where inline SVG is stripped.
- Batch-generate barcode PNG files from the CLI: `drush barcodes:generate "SKU123" --format=png --binary > sku.png`.
- Pipe generated SVG markup from `drush barcodes:generate` into a build/print pipeline.
- List every supported symbology and its short code with `drush barcodes:formats`.
- Discover valid `type` values programmatically via `drush barcodes:formats --format=json --fields=short-name`.
- Show the human-readable value beneath the barcode by enabling **Show value** in the formatter/block.
- Add postal routing barcodes (POSTNET, PLANET, IMB, RMS4CC, KIX) to address labels.
- Generate pharmacode barcodes (PHARMA, PHARMA2T) for pharmaceutical packaging.
- Print an ASCII/Unicode-grid barcode for a plain-text/terminal context with `format=UNICODE`.
- Combine token replacement in a block value (e.g. `[node:url]`) so one placed block adapts per page.
- Provide QR codes for Wi-Fi credentials or app-download links on a landing page via a placed block.
- Override a single symbology's markup by supplying a `barcode--{type}.html.twig` template in your theme.
