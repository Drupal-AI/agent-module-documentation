# OpenSpout XLSX backend

## What it does
Service `xls_serialization_open_spout.encoder.xlsx`
(class `Drupal\xls_serialization_open_spout\Encoder\OpenSpoutXlsxEncoder`,
`autowire: true`) **decorates** the parent `xls_serialization.encoder.xlsx` service and is
tagged `{ name: encoder, format: xlsx }`. Enabling the submodule is all that's needed:
every `xlsx` serialization — REST `?_format=xlsx`, a Views Excel export, or a
`serializer->serialize($data, 'xlsx', …)` call — is then produced by OpenSpout instead of
PhpSpreadsheet. Disable the submodule to fall back to the full-featured encoder.

`OpenSpoutXlsxEncoder extends Xlsx` (the parent class), so it reuses the inherited
`extractHeaders()`, `formatValue()` (tag-strip + trim) and `setSettings()` logic.

## Library dependency
Requires **`openspout/openspout`** (`^4`) via Composer, plus the `xls_serialization`
module. A `hook_requirements('install')` blocks install if `OpenSpout\Writer\XLSX\Writer`
is missing.

## How it encodes
- Opens an OpenSpout `Writer` against a temp file (`temporary://`), streams the header row
  then each data row, closes, reads the bytes back, and unlinks the temp file.
- Applies the header row from `extractHeaders()` and per-value tag-strip/trim from
  `formatValue()`.
- Values starting with `=` are written as `StringCell` (literal text, not a formula);
  other cells via `Cell::fromValue()`.
- Reads `xls_settings` from the Views style plugin if present (currently only future-proofing;
  no styling is applied).

## Trade-offs vs. the main encoder
Much faster and lighter on memory for large files, but it does **not** apply:
- Document metadata (creator/title/subject/keywords/company…)
- Conditional formatting
- Header styling (bold/italic/background color)
- Column AutoSize / row auto-height / text wrapping

Only the XLSX (`xlsx`) format is decorated; the legacy `xls` encoder is unchanged.
