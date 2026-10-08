<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Parser & helper services

All services are in `cmlapi.services.yml` / `src/Service/`. They read the XML file(s) stored on a
`cml` entity's `field_file` and return normalized PHP arrays. Nothing here exposes an HTTP write
endpoint — that is `cmlexchange`.

## `cmlapi.cml` — `CmlService`

Exchange-queue selector and file resolver (ctor: config.factory, entity_type.manager,
cache.default, database).

- `actual()` — the exchange to process now: first `current()` (progress, or the id in
  `cmlapi.settings.runing_cml`), else `next()` (oldest `new`), else `last()` (newest
  success/failure).
- `all()` / `new()` / `query($count,$status,$sort)` — entity-query over published, `type=catalog`,
  `state IN (...)`, `field_file != NULL`, ordered by `created`; `accessCheck(TRUE)`.
- `queryLastCml($status,$sort)` — DB query joining `cml` → `cml__field_file` → `file_managed`
  for the newest matching file (filename, uri, filesize). Parameterized query builder, no user input.
- `load($id)` — load a `CmlEntity`.
- `getFilesPath($cid,$xmlkey)` — returns the URIs of the exchange's files whose filename **starts
  with** `import` / `offers` / `prices` / `rests` (matched to `$xmlkey`); result cached per
  `CmlService-{key}:{cid}`. This is how parsers pick the right payload.

## `cmlapi.xml_parser` — `XmlParser`

Low-level CommerceML reader (ctor: file_system, messenger, config.factory).

- `parseXmlFile($uri)` — `realpath` + `is_file`/`is_readable` guard, then `file_get_contents`
  into `$xmlString`. `parseXmlFileHeader($uri)` reads line-by-line up to `</Классификатор>` and
  closes the root (fast header-only parse for catalog structure).
- `parseXmlString($xml)` — `simplexml_load_string()` → `json_encode`/`decode` to a PHP array in
  `$xmlArray`. Default libxml flags (no `LIBXML_NOENT`).
- `find($path)` / `get($type,$key)` — walk the array by a `/`-delimited 1C path using the
  `xmlImportMapping` / `xmlOffersMapping` tables (e.g. `Каталог/Товары/Товар`,
  `ПакетПредложений/Предложения/Предложение`).
- `prepare($data,$key,$map)` — apply a field-map entry: type `string` / `array` / `keyval`
  (`prepareKeyVal`→`xml2KeyVal`) / `attr` (`prepareAttribute`, reads `@attributes`), honoring
  `skip`, `list`, `inside`, `json` map options.
- **Source detection (2.x):** `getExchangeSource()` → `1c` when the first product/offer/group Ид
  is a UUID (`isOneCExchangeId`), else `moysklad`; `syncExchangeSource()` writes
  `cmlmigrations.settings.exchange_source`; `getNestedGroups()` flattens MoySklad's single root
  group into its children.
- Helpers: `arrayNormalize()` (SimpleXML single-vs-list normalization), `mapMerge()`, `xml2Val()`.

## `cmlapi.parser_catalog` — `ParserCatalog` (extends `ParserBase`)

Reads the `import` file header. `parse($cid)` returns `catalog`, `group`, `svoistvo`, `category`.
`parseFlatCatalog()` returns a flat group tree (`flatTree` recurses `Группы/Группа`, adding
`id/name/term_weight/parent/delete`). `parseCategory()`/`parseSvoistvo()` build the property/
category maps; `itemsList()` extracts dictionary (`Справочник`) value lists. Results cached
(`ParserCatalog:{uri}`, 86400s).

## `cmlapi.parser_product` — `ParserProduct` (extends `ParserBase`)

`parse($cid,$cache_on=false)` reads full `import` file (`parseXmlFile`), then `parseXml()` maps
each `Товар` through the `tovar-standart` + `tovar-dop` YAML map (see config doc). Product Ид is
split on `#`. `dst: 'offers'` map entries are copied into an offers bucket
(`setOffersExtras`). Cyrillic map keys are transliterated to Latin array keys via
`@transliteration`. Large sets are cached in 300-row chunks.

## `cmlapi.parser_offers` / `_prices` / `_rests`

`ParserOffers`, `ParserPrices`, `ParserRests` (same ctor as ParserBase) parse the `offers`
payload: offers list plus `svoistvo`/`price`/`stock` reference data (used by the Variations page).

## `cmlapi.parser_base` structure — `ParserBase`

Ctor: `cmlapi.cml`, `cmlapi.xml_parser`, config.factory, cache.default, datetime.time,
transliteration, messenger. `map($set1,$set2)` merges two `cmlapi.mapsettings` YAML values
(standard + "dop"). Provides `getCachedArray/Int` + `setCachedArray`.

## `cmlapi.scheme` — `Scheme`

`init($cml)` (full exchanges only) returns `category` / `svoistvo` / `taxonomy`: it walks each
category's `Свойства`, classifying each property whose `ТипЗначений == 'Справочник'` as taxonomy
and the rest as plain fields. Rendered by the Scheme page.

## `cmlapi.cleaner` — `CmlCleaner`

Prunes exchanges (ctor: config.factory, entity_type.manager, file_system, date.formatter).
`view()` lists, `clean()` deletes: `deleteEmpty()` removes `cml` with no `field_file` older than
`cleaner-expired` (strtotime); `deleteExpired()` removes successful exchanges older than
`cleaner-expired`, skipping the newest `cleaner-keep`, deleting referenced `file` entities and —
when `cleaner-force` — recursively deleting the exchange directory (`cmlDir()`, built from the
`cmlexchange.settings.file-path`, type, created time and uuid). All queries `accessCheck(FALSE)`
and are admin/cron-triggered only.

## `cmlapi.counter` — `CmlCounter`

`exchangeCounterInStatusNew()` — Syncloud MQTT queue-counter publisher; no-op unless the
`syncloud` module + service and `syncloud.uuid` state are present (see entity doc).
