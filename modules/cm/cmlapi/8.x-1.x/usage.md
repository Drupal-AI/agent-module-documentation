<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CML API (cmlapi) is the CommerceML (1C) storage-and-parser layer: it defines a "cml" entity that records each 1C exchange and a suite of XML parser services that read stored CommerceML files into normalized catalog/product/offer arrays.

---

CommerceML (CML) is the XML exchange standard used by 1C:Enterprise — a widely-used (especially in Russian-speaking markets) ERP/accounting platform — for syncing catalogs, products, prices, stock and orders. cmlapi provides the middle layer of a 1C↔Drupal integration. It does not receive the inbound HTTP exchange from 1C itself and it does not create commerce products; instead it (1) defines a `cml` content entity that stores each exchange's uploaded files (`field_file`, extensions xml/zip/log, on the public filesystem) plus metadata (login, IP, catalog-vs-sale type, state, full-vs-partial), and (2) offers parser services — `ParserCatalog`, `ParserProduct`, `ParserOffers`, `ParserPrices`, `ParserRests` over a low-level `XmlParser` — that read those stored files and turn 1C's Cyrillic-tagged XML into PHP arrays using an editable field-mapping config (`cmlapi.mapsettings`). In a full stack it pairs with `cmlexchange` (which implements the actual inbound 1C exchange endpoint and writes the files) and `cmlmigrations` (which imports the parsed data into commerce entities). cmlapi's own routes are admin-only inspection pages (catalog tree, products, offers, scheme) behind the "view published cml entity entities" permission, plus a settings form for the parser maps and a cron-driven cleaner that prunes old exchanges and their files.

---

- Store each 1C exchange as a `cml` entity with its uploaded XML/ZIP/log files and metadata.
- Parse CommerceML `import` files into catalog groups, product-type categories and properties.
- Parse `offers` / `prices` / `rests` files into offers, price types and warehouse stock.
- Map 1C's Cyrillic XML tags to normalized field names via editable YAML config.
- Override the default field mapping per site with the "dop" (extra) map textareas.
- Inspect a parsed catalog as a collapsible jsTree tree in the admin UI.
- Review parsed products and offers on debug pages (first few in full, `?all=TRUE` for all).
- View the property/taxonomy scheme of a full exchange as a YAML dump.
- Detect whether an exchange came from 1C or MoySklad and record it for cmlmigrations.
- Select the "actual" exchange to process by state (progress → new → last success/failure).
- Resolve which stored file is the import/offers/prices/rests payload by filename prefix.
- Cache parsed results (24h, chunked) keyed by file URI to avoid re-parsing large catalogs.
- Clean up empty and expired exchanges (and optionally their files/directories) on cron.
- Manually run or preview the cleaner from the settings form via AJAX buttons.
- Restrict who can view exchange data with the module's own view/edit/delete permissions.
- Publish an exchange-queue counter over MQTT when the optional `syncloud` module is present.
- Serve as the parser dependency for `cmlmigrations` importing 1C catalogs into Drupal Commerce.
- Pair with `cmlexchange` for the inbound file exchange with 1C (endpoint lives in that module).
- Handle both full and partial (incremental) 1C exchanges via the `full` flag.
- Support unlimited attached files per exchange (multi-file 1C uploads).
