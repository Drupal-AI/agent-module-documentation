Submodule of Serialization (Excel) that swaps the `xlsx` encoder for one built on the faster, lower-memory OpenSpout library, trading away styling/metadata features for performance on large exports.

---

This submodule provides a single service, `xls_serialization_open_spout.encoder.xlsx`, whose class `OpenSpoutXlsxEncoder` extends the parent module's `Xlsx` encoder and **decorates** `xls_serialization.encoder.xlsx` (tagged `encoder`/`xlsx`). Once enabled, any `xlsx` serialization — REST `?_format=xlsx`, a Views Excel export, or a `serializer` call — is transparently handled by OpenSpout instead of PhpSpreadsheet. It streams rows to a temporary file via OpenSpout's `Writer`, using the inherited `formatValue()`/`extractHeaders()` logic so header extraction plus tag-stripping and trimming still apply, and it still guards leading-`=` values by writing them as `StringCell`s so they are not treated as formulas. Because PhpSpreadsheet is slow and memory-hungry for large files, this backend is much faster and lighter — but it deliberately drops the extras the main encoder offers: custom document metadata, conditional formatting, header styling, and column/row auto-sizing are not applied. It depends on the `xls_serialization` module and the external `openspout/openspout` library (^4); a `hook_requirements()` blocks install if the OpenSpout `Writer` class is missing. There is no config, UI, or permissions of its own — enabling the module is the entire configuration.

---

- Speed up large `.xlsx` exports that time out or exhaust memory with PhpSpreadsheet.
- Stream tens of thousands of Views rows to Excel without OOM errors.
- Serve a memory-efficient REST `?_format=xlsx` endpoint for big datasets.
- Back a `views_data_export` batch export of a large content listing.
- Drop-in replace the default XLSX writer just by enabling the module (decorator).
- Keep header extraction from Views field labels when switching backends.
- Keep tag-stripping and whitespace trimming on cell values.
- Prevent leading-`=` values (codes, IDs) from being parsed as formulas.
- Export commerce orders or transactions to XLSX at scale for finance.
- Generate nightly cron XLSX reports of new content cheaply.
- Feed a decoupled front end large spreadsheet downloads.
- Trade metadata/styling features for throughput on bulk exports.
- Run Excel exports on memory-constrained hosting or containers.
- Produce analyst-ready spreadsheets from very large query results.
- Provide an "export all" button that must handle unbounded row counts.
- Serialize big arrays to XLSX programmatically with lower peak memory.
- Avoid PhpSpreadsheet's per-cell overhead on wide, tall sheets.
- Swap back to the full-featured encoder by simply disabling this submodule.
- Confirm the OpenSpout library is present before install via hook_requirements.
- Standardize on OpenSpout for all XLSX output across a site's views.
