<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — `cmlapi.mapsettings` & the settings form

## Install / enable

```
composer require drupal/cmlapi
drush en cmlapi -y
```

No composer/module dependencies are declared in `cmlapi.info.yml` (core `^11 || ^12`, PHP 7.4+).
For a working 1C exchange you normally also install `drupal/cmlexchange` (the HTTP endpoint 1C
posts to) and `drupal/cmlmigrations` (the importers). Enabling installs the `cml` entity, the
`field_file` file field, default `cmlapi.mapsettings`, and an optional `views.view.cml`.

## Settings form

Route `cml.settings` at `/admin/structure/cml/settings` (menu *Structure → CommerceML*; also the
entity's `field_ui_base_route`). Form `CmlEntitySettingsForm` (`src/Form/`), editable config
`cmlapi.mapsettings`. Note: there is **no `config/schema/`** in this module, so these keys are
schema-less.

### Cleaner section

- `cleaner-cron` (checkbox) — run `CmlCleaner::clean()` on every `hook_cron`.
- `cleaner-force` (checkbox) — also recursively delete the exchange's on-disk directory.
- `cleaner-expired` (textfield, a `strtotime()` expression, default `now -1 day`) — age cutoff.
- `cleaner-keep` (textfield, default `5`) — number of newest successful exchanges to skip.
- Two AJAX buttons: **Check expired CML** (`ajaxCleanerCheck` → `cleaner->view()`) and
  **Run cleaner** (`ajaxCleanerRun` → `cleaner->clean()`), results shown in `#cleaner-results`.

### Parser (field-map) section

Four YAML textareas merged in pairs by `ParserBase::map()`:

- `tovar-standart` + `tovar-dop` → the product map (used by `ParserProduct`).
- `offers-standart` + `offers-dop` → the offers map (used by `ParserOffers`).

Each YAML key is a 1C node name; the value is a map controlling conversion:

- `type`: `string` (default), `keyval` (Ид/Наименование → Значение/Ставка pairs), `[]` (array;
  sub-options `inside`, `list`, `json`), or `attr` (read a named XML `@attributes` value).
- `skip: 1` — parse but drop from the product output (e.g. `СтавкиНалогов`).
- `attr: 'НаименованиеПолное'` — attribute name for `type: attr`.
- `dst: 'offers'` — copy this value onto the offer bucket instead of the product (used for
  per-variation attributes like `ХарактеристикиТовара`, `Штрихкод`).

Default `tovar-standart` (from `config/install/cmlapi.mapsettings.yml`) maps Ид, Артикул,
Штрихкод, Наименование, ПометкаУдаления, БазоваяЕдиница (attr, skip), Группы (array), Категория,
Описание, Картинка (array), Изготовитель (keyval), СтавкиНалогов (keyval, skip), ЗначенияСвойств
(keyval), ЗначенияРеквизитов (keyval). Cyrillic keys are transliterated to Latin output keys
(e.g. `Наименование` → `Naimenovanie`).

## Other config keys read at runtime

- `cmlapi.settings.runing_cml` — id of the exchange treated as "current" by `CmlService::current()`.
- `cmlexchange.settings.file-path` — base dir used by `CmlCleaner::cmlDir()` for force-delete.
- `cmlmigrations.settings.exchange_source` — written by `XmlParser::syncExchangeSource()` (`1c`
  or `moysklad`).

## Diagnostic pages (all require `view published cml entity entities`)

- `/admin/structure/cml/{cml}/catalog` — `Catalog::page`, jsTree of catalog groups
  (`cmlapi/cmlapi.jstree` library).
- `/admin/structure/cml/{cml}/product` — `Product::page`, first 3 products as YAML (`?all=1` for
  all) plus the catalog dump.
- `/admin/structure/cml/{cml}/product-variaton` — `ProductVariation::page`, first 300 offers plus
  svoistvo/price/stock reference data (`?all=1` for all).
- `/admin/structure/cml/{cml}/scheme` — `SchemeController::page`, the property/category scheme
  (full exchanges only; otherwise prints "Только для полных обменов").
