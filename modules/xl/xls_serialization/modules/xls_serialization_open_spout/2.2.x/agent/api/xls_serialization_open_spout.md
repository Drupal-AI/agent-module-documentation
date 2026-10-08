<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OpenSpout XLSX backend

## What it does
Service `xls_serialization_open_spout.encoder.xlsx`
(class `Drupal\xls_serialization_open_spout\Encoder\OpenSpoutXlsxEncoder`,
`autowire: true`) **decorates** the parent `xls_serialization.encoder.xlsx` service and is
tagged `{ name: encoder, format: xlsx }` (`xls_serialization_open_spout.services.yml`).
Enabling the submodule is all that's needed: every `xlsx` serialization — REST
`?_format=xlsx`, a Views Excel export, or a `serializer->serialize($data, 'xlsx', …)`
call — is then produced by OpenSpout instead of PhpSpreadsheet. Disable the submodule to
fall back to the full-featured encoder.

`OpenSpoutXlsxEncoder extends Xlsx` (the parent class), so it reuses the inherited
`extractHeaders()`, `formatValue()` (tag-strip + trim) and `setSettings()` logic. Its
constructor takes `@config.factory` (passed to the parent) and injects
`FileSystemInterface` for temp-file handling.

## Library dependency
Requires **`openspout/openspout`** (`^4`) via Composer, plus the `xls_serialization`
module. `xls_serialization_open_spout_requirements('install')` blocks install if
`OpenSpout\Writer\XLSX\Writer` is missing.

## How it encodes (`OpenSpoutXlsxEncoder::encode()`)
- Normalizes input like the parent (scalars wrapped, objects cast to array).
- Opens an OpenSpout `Writer` against a temp file created by
  `$this->fileSystem->tempnam('temporary://', 'xls_serialization')` (resolved with
  `realpath()`), streams the header row then each data row, `close()`s, reads the bytes
  with `file_get_contents()`, and `unlink()`s the temp file — returning the raw bytes.
- Applies the header row from `extractHeaders()` + `formatValue()`, and per-value
  tag-strip/trim from `formatValue()`.
- Values starting with `=` (length > 1) are written as `StringCell::fromValue()` (literal
  text, not a formula); other cells via `Cell::fromValue()`.
- Reads `xls_settings` from the Views style plugin if present (currently only
  future-proofing; no styling is applied).
- Library exceptions are rethrown as `InvalidDataTypeException`.

## Trade-offs vs. the main encoder
Much faster and lighter on memory for large files, but it does **not** apply:
- Document metadata (creator/title/subject/keywords/company…)
- Conditional formatting
- Header styling (bold/italic/background color)
- Column AutoSize / row auto-height / text wrapping
- Live-preview JSON fallback (the parent's is bypassed; this encoder always writes XLSX bytes)

Only the XLSX (`xlsx`) format is decorated; the legacy `xls` encoder is unchanged.
