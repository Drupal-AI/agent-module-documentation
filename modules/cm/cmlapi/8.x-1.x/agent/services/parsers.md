<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# cmlapi — XML parser services

The parsing layer turns a stored CommerceML (1C) XML file into PHP arrays. It never fetches or
receives files itself — it reads file URIs already attached to a `cml` entity's `field_file`.

## Low-level engine: `XmlParser` (`src/Service/XmlParser.php`, service `cmlapi.xml_parser`)

- **Read file → string**: `parseXmlFile($uri)` reads the whole file (`file_system` realpath +
  `fopen`/`fread`); `parseXmlFileHeader($uri)` reads only up to the closing `</Классификатор>` tag
  and appends a synthetic root close — used to parse just the classifier header of large catalogs.
- **String → array**: `parseXmlString($string)` calls `simplexml_load_string($xml_string)` (no
  libxml flags), then `json_encode(...JSON_FORCE_OBJECT)` + `json_decode(...TRUE)` to get a nested
  associative array in `$this->xmlArray`. Immediately discards the raw string. On parse failure it
  adds a messenger error and returns `[]`.
- **Path lookup**: `find($map)` walks a `"A/B/C"` slash path through `$this->xmlArray`.
  `get($type, $key)` maps a logical key to a 1C path via `$xmlImportMapping` (import stream:
  `Классификатор/Группы/Группа`, `.../Категории/Категория`, `.../Свойства/Свойство`, `ТипыЦен`,
  `Склады`, `Каталог/Товары/Товар`) or `$xmlOffersMapping` (offers stream: `ПакетПредложений/…`).
- **Field mapping** `prepare($data, $key, $map)` applies a per-field map with `type`
  string|array|keyval|attr, `skip`, `attr`, and nested array options (`inside`, `list`, `json`).
  Helpers `xml2KeyVal` / `xml2Val` flatten 1C `Ид`→`Значение` pairs; `arrayNormalize` coerces a
  single-vs-list node into a list.
- **Exchange-source detection**: `syncExchangeSource()` sniffs the first `Товар/Предложение/Группа`
  `Ид`; a UUID → `1c`, otherwise `moysklad`, and writes the result into **`cmlmigrations.settings`**
  (`exchange_source`). When source is MoySklad, `get('import','gruppa')` also flattens away the
  shared root group (`getNestedGroups`).

## `ParserBase` (`src/Service/ParserBase.php`)

Common ctor (`cmlapi.cml` + `cmlapi.xml_parser`) and `map($set1,$set2)` which merges a standard map
and a "dop" (extra) override, both parsed from `cmlapi.mapsettings` YAML strings.

## The five parsers (each `extends ParserBase`)

- **`ParserCatalog`** (`cmlapi.parser_catalog`) — `parse($cid)` returns
  `['catalog','group','svoistvo','category']`: the group tree (flat + nested via `flatTree`),
  properties (`Свойства`), and categories/product-types. Uses `parseXmlFileHeader` (classifier only).
- **`ParserProduct`** (`cmlapi.parser_product`) — `parse($cid)` reads the full `import` file, maps
  each `Товар` through `map('tovar-standart','tovar-dop')`, transliterates 1C field names to Latin
  keys, and buckets some fields into per-offer extras (`dst: offers`). Caches results in 300-item
  chunks in the cache backend.
- **`ParserOffers`** (`cmlapi.parser_offers`) — reads the `offers` file into
  `svoistvo/price/stock/offer` via `map('offers-standart','offers-dop')`. `parseArray()` is the
  variant the offers viewer page uses.
- **`ParserPrices`** (`cmlapi.parser_prices`) — reads the `prices` file, same offer mapping.
- **`ParserRests`** (`cmlapi.parser_rests`) — reads the `rests` (stock) file, same offer mapping.

Which physical file each parser reads is chosen by `CmlService::getFilesPath($cid, $xmlkey)`, which
loads the entity's `field_file` items and buckets them by **filename prefix** (`import*`, `offers*`,
`prices*`, `rests*`). Parser output is cached (24h, chunked) keyed by file URI.

## `cmlapi.mapsettings` (config/install)

Editable config holding the parser field maps as YAML text (edited on the settings form):

- `tovar-standart` / `tovar-dop` — product (import) field map + overrides.
- `offers-standart` / `offers-dop` — offer field map + overrides.
- Map entry syntax: `ПолеИмя: {type: 'attr'|'keyval'|[]|'string', skip: 1, attr: 'Имя', dst: 'offers'}`.
  Default install maps `Ид/Артикул/Штрихкод/Наименование/Группы/Категория/Описание/Картинка/…`.
- Also holds cleaner settings (`cleaner-cron`, `cleaner-force`, `cleaner-expired`, `cleaner-keep`).

Implementation note: `XmlParser::parseXmlString` uses `simplexml_load_string` with default libxml
flags (no `LIBXML_NOENT`/`LIBXML_DTDLOAD`), then re-encodes via `json_encode`/`json_decode`, so the
resulting array holds only already-parsed scalar text; entity references are not substituted.
