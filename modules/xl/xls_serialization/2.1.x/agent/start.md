# xls_serialization — agent start

Registers `xls` (MIME `application/vnd.ms-excel`) and `xlsx` (MIME
`…spreadsheetml.sheet`) serialization formats via two encoder services (`Xls`,
`Xlsx`) built on the external `phpoffice/phpspreadsheet` library. Depends on core
`rest` + `serialization`. Ships Views `excel_export` display/style plugins. Consume it
through REST (`?_format=xlsx`), a Views "Data export"/"Excel export" display, or the
`serializer` service. Global config UI: **Admin → Config → User interface → Xls
Serialization configuration** (`/admin/config/user-interface/xls_serialization`); route
`xls_serialization.configuration`.

- Encode Excel in code + REST + the phpspreadsheet dependency → [api/xls_serialization.md](api/xls_serialization.md)
- Global setting, Views export options (`xls_settings`, header styling, metadata, conditional formatting), permission → [configure/xls_serialization.md](configure/xls_serialization.md)
- Faster/lower-memory XLSX backend → submodule `xls_serialization_open_spout`
