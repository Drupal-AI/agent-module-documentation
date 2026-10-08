# Configuration

Barcodes has **no central settings page**. You set the barcode options where you
place it — in a field formatter's settings on *Manage display*, or in the Barcode
block's settings. Both offer the **same options**, described below (the Drush
commands and the Twig filter take the same options as flags/arguments).

## Where you set the options

- **Field formatter:** **Structure → Content types → *(your type)* → Manage
  display**, set a field's **Format** to **Barcode**, then click the settings cog.
- **Block:** **Structure → Block layout → Place block → Barcode**, then use the
  block configuration form.

## The barcode options

- **Type** — the barcode symbology, given as a short code. The default is
  **QRCODE**. There are 40+ options, including `C128` (Code 128), `EAN13`,
  `DATAMATRIX`, `PDF417`, `AZTEC`, postal codes (`POSTNET`, `PLANET`, `IMB`), and
  pharmacode (`PHARMA`). Run `drush barcodes:formats` for the full authoritative
  list of type codes.
- **Format** — how the barcode is rendered:
  - **SVG** *(default)* — inline SVG markup; crisp at any size, no CSS needed.
  - **PNG** — a base64 data‑URI `<img>`; useful where inline SVG is stripped.
  - **HTMLDIV** — a CSS‑styled `<div>` grid (the module attaches the needed CSS
    automatically for the formatter and block).
  - **UNICODE** / **BINARY** — an ASCII/Unicode‑character grid in a `<pre>` block,
    for plain‑text/terminal contexts.
- **Color** — the barcode color, chosen with a color picker (default black,
  `#000000`).
- **Width** and **Height** — the barcode size in pixels (each default 100).
- **Padding (top / right / bottom / left)** — white space in pixels around the
  barcode on each side (each default 0).
- **Show value** — when ticked, the raw value is also printed as human‑readable
  text beneath the barcode (default off).

### Block‑only option

- **Value** — the text the block encodes. This is token‑aware when the Token
  module is enabled, so you can use tokens such as `[node:url]` and the code
  adapts to the page it appears on. (The field formatter has no Value setting — it
  encodes the field's own value.)

## Save

Click **Update** on the formatter settings (then **Save** the display), or **Save
block** for the block. The barcode renders wherever the field or block appears.

## A note on invalid values

If a value can't be encoded with the chosen symbology (for example, letters in an
EAN‑13 code that expects digits), nothing renders and the error is quietly logged
to the `barcodes` log channel rather than breaking the page. If a barcode comes up
empty, check that your value is valid for the selected **Type**.
