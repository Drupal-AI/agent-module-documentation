<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Serialization (Excel) (xls_serialization) — agent index

Registers `xls` (MIME `application/vnd.ms-excel`) and `xlsx` (MIME
`…spreadsheetml.sheet`) serialization formats via two encoder services (`Xls`,
`Xlsx`) built on the external `phpoffice/phpspreadsheet` library
(`^2.4.6 || ^3.10.6 || ^5.8.0`). Depends on core `rest` + `serialization`.
Ships Views `excel_export` display/style plugins. Consume it through REST
(`?_format=xlsx`), a Views "Data export"/"Excel export" display, or the
`serializer` service. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 2.2.0.

Global config UI: **Admin → Config → User interface → Xls Serialization**
(`/admin/config/user-interface/xls_serialization`, route
`xls_serialization.configuration`, permission `administer xls serialization configuration`).

- Encode Excel in code + REST + the phpspreadsheet dependency → [api/xls_serialization.md](api/xls_serialization.md)
- Global setting, Views export options (`xls_settings`, header styling, metadata, conditional formatting), permission → [configure/xls_serialization.md](configure/xls_serialization.md)
- Faster/lower-memory XLSX backend → submodule `xls_serialization_open_spout` (`../../modules/xls_serialization_open_spout/2.2.x/agent/start.md`)

## What it provides (from source)

- **Encoders** (`xls_serialization.services.yml`): `xls_serialization.encoder.xls`
  (`Encoder\Xls`) and `xls_serialization.encoder.xlsx` (`Encoder\Xlsx extends Xls`),
  both constructed with `@config.factory`, tagged `{ name: encoder, format: xls|xlsx }`.
- **Format registration**: `XlsSerializationServiceProvider::alter()` calls
  `registerFormat()` on `http_middleware.negotiation` for `xls`/`xlsx`.
- **Views plugins**: display `excel_export` (`Plugin/views/display/ExcelExport extends RestExport`,
  content type `xlsx`) + style `excel_export` (`Plugin/views/style/ExcelExport extends Serializer`),
  with logic in `ExcelExportDisplayTrait` / `ExcelExportStyleTrait`.
- **Config**: object `xls_serialization.configuration` (one key `xls_serialization_autosize`),
  form `XlsSerializationConfigurationForm`, schema in `config/schema/`.
- **Permission**: `administer xls serialization configuration` (`restrict access: true`).
- No entities, no Drush, no hooks (only `xls_serialization_post_update_2_1_0_container_rebuild`).
