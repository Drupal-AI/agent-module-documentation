<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Grounded in `src/Drush/Commands/BarcodesDrushCommands.php`. Two commands, Drush 12+.

## `barcodes:generate` (alias `generate-barcode`)

Generate a barcode from a string.

```
drush barcodes:generate <value> [--type=] [--color=] [--height=] [--width=]
      [--padding_top=] [--padding_right=] [--padding_bottom=] [--padding_left=]
      [--format=] [--binary]
```

Defaults: `type=QRCODE`, `color=#000000`, `height=100`, `width=100`, all paddings `0`,
`format=png`. `type` is upper-cased and `format` lower-cased internally, so case doesn't matter.

`--format` → returned output:
- `svg` → SVG markup (string).
- `png` → an `<img src="data:image/png;base64,…">` string, **unless** `--binary` is set, in which
  case raw PNG bytes are written to STDOUT (pipe to a file) and the command returns nothing.
- `htmldiv` → `getHtmlDiv()` markup.
- `unicode` / `binary` → a `<pre>` ASCII/Unicode grid.
- anything else → the literal string `Unknown output format`.

Examples (verified against the live site):

```bash
drush barcodes:generate "Hello World!"                                  # PNG <img> markup
drush barcodes:generate "Hello" --type=QRCODE --format=svg              # SVG markup
drush barcodes:generate 0xABADCAFE --type=qrcode --height=250 --width=250 --format=png
drush barcodes:generate "SKU123" --format=png --binary > my-barcode.png # binary PNG file
```

## `barcodes:formats` (alias `barcodes-formats`)

List every symbology the module can emit (a `RowsOfFields` table). Columns: `short-name`
(the value you pass to `--type` / the `type` setting) and `description`.

```bash
drush barcodes:formats                                        # full table
drush barcodes:formats --format=json --fields=short-name      # just the type codes, as JSON
```

Use the second form to get the authoritative list of valid `type` values programmatically
(e.g. `QRCODE`, `C128`, `EAN13`, `DATAMATRIX`, `PDF417`, `AZTEC`, `POSTNET`, …).
