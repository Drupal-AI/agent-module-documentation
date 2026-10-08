Serialization (CSV) registers `csv` as a serialization format for Drupal's Serialization API, letting REST resources and Views "Data export" (Rest export) displays emit downloadable CSV files.

---

The module adds a single `CsvEncoder` service tagged as an `encoder` for the `csv` format, and a service provider that teaches Drupal's content-negotiation middleware to map the `csv` format to the `text/csv` MIME type. Under the hood it uses the external `league/csv` library to build (encode) and parse (decode) CSV, so that library must be installed via Composer. When encoding, the first data row's keys become the header row (Views field labels are used as headers when a Views style plugin is in context), nested/multi-value cell data is flattened with a `|` separator, and each value can be tag-stripped and trimmed. Behavior is controlled through a `csv_settings` context array — delimiter, enclosure, escape character, newline, UTF-8 BOM, header output, tag stripping and trimming — which integrations like `views_data_export` pass in from a Views style plugin. It also decodes CSV back into arrays, exploding `|`-joined cells into arrays again, so it round-trips for REST POST/PATCH payloads. There is no admin UI or configuration of its own; you consume it through the REST/Views layers or the `serializer` service in code. It is a common building block for content exports, decoupled data feeds, and spreadsheet-friendly downloads.

---

- Add a "Data export" Views display that downloads results as a `.csv` file.
- Offer a CSV export of a content listing (nodes, users, terms) for editors.
- Serve a REST resource in `csv` format via `?_format=csv`.
- Export commerce orders or line items to CSV for accounting.
- Generate spreadsheet-friendly downloads that open cleanly in Excel.
- Emit a UTF-8 BOM so Excel correctly reads accented/non-Latin characters.
- Use a semicolon (`;`) delimiter for locales where Excel expects it.
- Use a tab (`\t`) delimiter to produce TSV-style output.
- Customize the field enclosure character (e.g. quotes) for values with commas.
- Strip HTML tags from rendered field values so cells contain clean text.
- Trim whitespace from every exported cell value.
- Toggle the header row on or off for headless consumers.
- Use Views field labels as human-readable CSV column headers.
- Flatten multi-value fields into a single `|`-separated cell.
- Provide a scheduled/batched large export via `views_data_export`.
- Feed a decoupled front end or external system a CSV data endpoint.
- Import CSV payloads by decoding them back into structured arrays.
- Round-trip data through REST POST/PATCH requests in CSV format.
- Export a report of webform submissions as CSV.
- Give data analysts a downloadable dataset without database access.
- Produce mailing/contact lists as CSV for a CRM or email tool.
- Serialize arbitrary arrays to CSV programmatically via the `serializer` service.
- Pass per-request `csv_settings` to override delimiter/enclosure in custom code.
- Build a nightly cron export of new content to a shared CSV file.
- Provide an "export to spreadsheet" button backed by a Views REST export.
