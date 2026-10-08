# Barcodes — manual setup guide

**Barcodes** (`barcodes`) renders values as barcodes and QR codes. Under the hood
it wraps the `tecnickcom/tc-lib-barcode` PHP library, which supports 40+
symbologies — QR Code, Code 128, EAN‑13, DataMatrix, PDF417, Aztec, postal codes,
pharmacode, and many more — and it can output each one as inline SVG, a base64 PNG
image, an HTML `<div>` grid, or a Unicode/ASCII grid.

The clever thing about Barcodes is that it exposes the *same* generator through
**four different surfaces**, so you can reach for whichever fits:

1. **A field formatter** — turn a text‑like field (SKU, order number, a link, a
   UUID, and so on) into a rendered barcode on an entity's *Manage display*.
2. **A block** — place a "Barcode" block anywhere and give it free text to encode
   (with token support, so one block can adapt per page — e.g. a QR code of the
   current page URL).
3. **A Twig filter** — drop `{{ "some string"|barcode(type='QRCODE') }}` into a
   template to render any string.
4. **Two Drush commands** — generate a barcode from the command line, or list every
   supported symbology.

All four accept the same options — symbology type, output format, color, width,
height, four paddings, and (for the formatter and block) a "show value" toggle.
Values are run through Drupal's token system before encoding, so field and block
values can contain entity tokens.

The module ships no settings page and no permissions — the formatter and block
settings live on the display/block configuration where you place them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its barcode
   library with Composer, and enable it.
2. [Configuration](configuration/index.md) — the shared barcode options (type,
   format, color, size, paddings, show value), for both the formatter and the
   block.

## Where it lives in the admin menu

There is **no central settings page**. You configure barcodes where you use them:

- **Field formatter** — **Structure → Content types → *(your type)* → Manage
  display**, then set a field's format to **Barcode**.
- **Block** — **Structure → Block layout → Place block**, then place the
  **Barcode** block.
- **Twig filter** and **Drush** are used from templates and the command line
  respectively.

## How to use it

### Field formatter

1. Go to **Manage display** for a content type (or any entity/bundle).
2. For a field of a supported type (`email`, `integer`, `link`, `string`,
   `telephone`, `text`, `text_long`, `text_with_summary`, `bigint`, or `uuid`),
   set the **Format** to **Barcode**.
3. Click the settings cog to choose the symbology and appearance (see
   [Configuration](configuration/index.md)), then **Update** and **Save**.

Note: `link` fields are always encoded as an absolute URL, which is handy for
"scan to visit this page" QR codes.

### Block

1. Go to **Structure → Block layout** and **Place block**, choosing **Barcode**.
2. In the block settings, enter the **Value** to encode. With the Token module
   installed you can use tokens like `[node:url]`, so a single placed block
   produces a different code per page.
3. Set the barcode options and save.

### Twig filter

In a template, pipe any string through the `barcode` filter. All arguments are
optional and order‑independent:

```twig
{{ "any string" | barcode }}
{{ node.field_url.uri | barcode(color='red') }}
{{ product.sku.value | barcode(type='EAN13', format='png') }}
```

### Drush

```bash
# Generate a barcode (PNG <img> markup by default):
drush barcodes:generate "Hello World!"

# Write a real PNG file:
drush barcodes:generate "SKU123" --format=png --binary > sku.png

# List every supported symbology and its short code:
drush barcodes:formats
```

Use `drush barcodes:formats` whenever you need the authoritative list of valid
`type` values (`QRCODE`, `C128`, `EAN13`, `DATAMATRIX`, `PDF417`, `AZTEC`, …).
