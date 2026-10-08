# Serialization (Excel) — manual setup guide

**Serialization (Excel)** (`xls_serialization`) registers `xls` and `xlsx` as
serialization formats for Drupal, so REST resources and Views "Data export" / "REST
export" displays can emit downloadable Excel spreadsheets. If you want editors to
download a content listing as a real `.xlsx` file, or a decoupled front end to fetch
data in Excel format, this is the module that makes Excel a first-class output
format.

Under the hood it adds two encoders — one for `.xlsx` (the modern Excel format) and
one for the legacy binary `.xls` — built on the external
`phpoffice/phpspreadsheet` library, which Composer installs for you. You typically
use it in one of three ways: as a **Views Excel export display**, as a **REST
resource** requested with `?_format=xlsx`, or programmatically through Drupal's
`serializer` service. When it builds a workbook it uses the first row for headers
(Views field labels become the column headers), optionally strips HTML tags and
trims each value, auto-sizes columns, wraps long text, and writes any value starting
with `=` as literal text rather than a spreadsheet formula.

Most of the interesting configuration lives **on a Views Excel export display** —
custom filename, bold/italic/colored header rows, embedded document metadata, and up
to five conditional-formatting rules. There's also a tiny global settings form with a
single toggle (disable column auto-sizing for speed on big exports) and a permission
that gates it. It depends on core's **REST** and **Serialization** modules. A
companion submodule, **xls_serialization_open_spout**, swaps the XLSX engine for the
faster, lower-memory OpenSpout library at the cost of some styling and metadata
features.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including how to encode Excel
in code and over REST — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its PhpSpreadsheet
   library) with Composer, enable it, and pick the submodule if you need it.
2. [Configuration](configuration/index.md) — the global auto-size toggle and its
   permission, plus the per-view Excel export options.

## Where it lives in the admin menu

The global settings form sits at **Configuration → User interface → Xls Serialization
configuration** (`/admin/config/user-interface/xls_serialization`). The main
configuration surface, though, is on each Views **Excel export** display, which you
build under **Structure → Views**.

## How to use it

The most common path: create a View, add a **Data export / Excel export** display,
and configure its filename, header styling, metadata, and conditional formatting.
Alternatively, expose a REST resource and request it with `?_format=xlsx`, or call the
`serializer` service with the `xlsx` format from your own code. See
[Configuration](configuration/index.md) for the export options.
