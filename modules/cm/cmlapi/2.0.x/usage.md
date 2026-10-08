CML API is the CommerceML/1C exchange API layer for Drupal: a `cml` content entity that records each exchange plus an XML parser suite that turns stored CommerceML files into catalog, product and offer arrays.

---

CML API underpins 1C:Enterprise / CommerceML integrations. It defines the `cml` content entity (base table `cml`) that logs every exchange — its type (`catalog`/`sale`), migration state (`zip`/`new`/`progress`/`success`/`busy`/`failure`), a `full` flag, the 1C login and IP, and a `field_file` reference to the received XML payload(s). The `XmlParser` service loads those stored files (`simplexml_load_string` → array) and the `ParserCatalog`/`ParserProduct`/`ParserOffers`/`ParserPrices`/`ParserRests` services convert 1C node structures into normalized PHP arrays using a YAML field-map (`cmlapi.mapsettings`, editable at `/admin/structure/cml/settings`). A `CmlService` picks the "actual" exchange to process (progress → oldest new → last finished); a `CmlCleaner` prunes empty and expired exchanges (optionally on cron, optionally deleting the on-disk files). Four permission-gated admin pages render diagnostic views of the parsed catalog tree (jsTree), products, offers and the 1C property/category scheme. This module is the shared API/data layer only — the HTTP exchange endpoint that 1C posts to lives in `drupal/cmlexchange`, and the importers that create Drupal products live in `drupal/cmlmigrations`. Version 2.x adds exchange-source detection (1C vs MoySklad) and nested-group flattening.

---

- Log each 1C/CommerceML exchange as a `cml` entity with type, state, login, IP and the received XML file.
- Provide a shared parser API that `cmlexchange` and `cmlmigrations` consume instead of re-parsing CommerceML.
- Read a stored CommerceML `import.xml` into a flat catalog group tree (`ParserCatalog::parseFlatCatalog`).
- Extract the full catalog structure — groups, categories, properties (svoistvo) — via `ParserCatalog::parse`.
- Parse `Каталог/Товары/Товар` product nodes into normalized product rows (`ParserProduct::parse`).
- Parse `ПакетПредложений/Предложения/Предложение` offer/variation nodes (`ParserOffers`).
- Parse price-type and stock/warehouse reference data from an offers file.
- Map 1C node names to your product fields with a YAML config (string / keyval / array / attribute types, skip, dst:offers).
- Group characteristic values under offers (`dst: 'offers'`) so variations get their own attributes.
- Transliterate Cyrillic 1C field names into Latin array keys for downstream code.
- Select the next exchange to process in a queue (`CmlService::actual/next/last/current`).
- Query the most recent uploaded exchange file with size/filename via `CmlService::queryLastCml`.
- Resolve the stored XML file URIs for a given exchange and payload kind (import/offers/prices/rests).
- Automatically prune empty exchanges and keep only the newest N successful ones (`CmlCleaner`).
- Run the cleaner on cron by enabling "Cron Cleaner" in settings, with optional recursive file deletion.
- Manually preview or run the cleaner from the settings form via AJAX buttons.
- Inspect the imported catalog as an interactive jsTree at `/admin/structure/cml/{cml}/catalog`.
- Review the first products (or all, with `?all=1`) as YAML at `/admin/structure/cml/{cml}/product`.
- Review parsed offers plus price/stock/property reference data at `/admin/structure/cml/{cml}/product-variaton`.
- Derive the 1C property/category "scheme" (which properties are dictionaries vs taxonomy) for full exchanges.
- Detect whether an exchange payload came from 1C or MoySklad and sync `cmlmigrations.settings.exchange_source`.
- Flatten MoySklad's shared root group so nested categories import correctly.
- Cache parsed catalog/product results in the default cache bin to speed repeated reads.
- Push exchange-queue counters to a Syncloud MQTT dashboard when the `syncloud` module is present.
- Manage exchange records through a standard entity UI (list, add, edit, delete) under `/admin/structure/cml`.
- Expose `cml` records to Views for building custom exchange dashboards.
