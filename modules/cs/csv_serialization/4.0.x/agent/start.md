# csv_serialization — agent start

Registers the `csv` serialization format (MIME `text/csv`) via a single `CsvEncoder`
service (`csv_serialization.encoder.csv`, tagged `encoder`/`csv`). Depends on core
`serialization` and the external `league/csv` library. No admin UI, no config, no
permissions. Consume it through REST, Views "Data export", or the `serializer` service.

- Encode/decode CSV in code (serializer service, context) → [api/encoder.md](api/encoder.md)
- CSV options (delimiter, enclosure, BOM, headers, strip/trim) → [configure/csv-settings.md](configure/csv-settings.md)
