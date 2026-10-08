# Serialization (CSV) — manual setup guide

**Serialization (CSV)** (`csv_serialization`) registers `csv` as a serialization
format for Drupal's Serialization API. In plain terms, it teaches Drupal how to
turn data into comma‑separated‑value files, so that REST resources and Views
**Data export** (Rest export) displays can emit downloadable, spreadsheet‑friendly
`.csv` files. It's the piece most people add when they want an "export to
spreadsheet" button on a content listing.

Under the hood the module adds a single `CsvEncoder` service (tagged for the
`csv` format) and teaches Drupal's content‑negotiation layer to map the `csv`
format to the `text/csv` MIME type. It builds and parses CSV using the external
`league/csv` library, which Composer installs for you. When encoding, the first
row's keys become the header row (Views field labels are used as headers when a
View is involved), nested or multi‑value cell data is flattened with a `|`
separator, and each value can be tag‑stripped and trimmed. It also decodes CSV
back into arrays, so it round‑trips for REST POST/PATCH payloads.

This is a **building block, not an end‑user feature**. It works the moment you
enable it and has **no admin UI, no settings page, and no permissions** of its
own. Its behavior — delimiter, enclosure, escape character, newline, whether to
emit a UTF‑8 BOM, whether to output a header row, tag‑stripping and trimming — is
controlled through a `csv_settings` array that consuming layers pass in. In
practice you set those options in the Views **Data export** display, or in code
when you call the `serializer` service directly. The module requires Drupal 10 or
11 and core's **Serialization** module.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent — the encoder service and the full
`csv_settings` context — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (which also brings in the `league/csv` library) and enable it.

## Where it lives in the admin menu

Serialization (CSV) has **no configuration page** (`configure` is null) and adds
no admin menu items. Enabling it simply makes `csv` an available format. You reach
that format from two places:

- **A Views "Data export" display** — where you pick CSV as the format and set
  its options.
- **A REST endpoint** — by requesting `?_format=csv`.

## How to use it

- **Add a CSV export to a View** — edit a View, add a **Data export** display,
  and choose **CSV** as its format. The display gives you an export path; visiting
  it downloads the results as a `.csv`. On that display you can set the delimiter
  (for example `;` for many European locales, or a tab for TSV‑style output), the
  enclosure character, whether to include a header row, whether to strip HTML tags
  from cell values, whether to trim whitespace, and whether to prepend a UTF‑8 BOM
  so Excel reads accented characters correctly. For very large or scheduled
  exports, pair it with the *Views data export* module.
- **Serve a REST resource as CSV** — once the module is enabled, any REST
  resource that supports serialization can be requested with `?_format=csv` (with
  the `text/csv` MIME type) to receive CSV output.
- **Serialize in code** — call Drupal's `serializer` service with the `csv`
  format and, optionally, a `csv_settings` context array to override the
  delimiter, enclosure, header output, and so on for that request.
