<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Feeds Enhanced — parsers

Two `@FeedsParser` plugins in `src/Feeds/Parser/`. Selected per Feed Type on the "Parser" step.
Both return an empty `getMappingSources()` — they rely entirely on the mappings the admin defines
on the Feed Type.

## `ini` — IniParser ("INI")

`src/Feeds/Parser/IniParser.php`, extends Feeds `ParserBase`.

- `parse()`: throws `EmptyFeedException` if the fetched file is empty; otherwise
  `parseIniFile()` → `parse_ini_file($file, $multi_mode, INI_SCANNER_TYPED)`. Builds one
  `DynamicItem`, setting each INI key that appears in the feed-type source map.
- `getSourceMap()` = `array_column($feed_type->getMappingSources(), 'machine_name', 'value')` — maps
  an INI key (the source's `value`) to the mapping `machine_name`.
- Config: `ini_mode_multi` (bool, default FALSE) — the second `parse_ini_file` argument
  (`process_sections`). Key name via `IniParser::getMultiModeKey()`. Forms `Form\IniParserForm` /
  `Form\IniParserFeedForm`.
- Values are typed by `INI_SCANNER_TYPED` (ints/bools/etc.). One item per file (whole-file → one
  row); pair with any fetcher that yields an `.ini` file.

## `entity_data` — EntityDataParser ("Entity data")

`src/Feeds/Parser/EntityDataParser.php`, extends `ParserBase`, injects `entity_type.manager`.
**Ignores the fetcher result** and reads existing entities as the source rows — pair it with the
`null_data_source` fetcher.

- Target type/bundle come from the **processor**: `getTargetEntityTypeId()` =
  `$feedType->getProcessor()->entityType()`, `getTargetBundleName()` = `…->bundle()`.
- `getTargetEntities()`: `entity_type.manager`→storage; if the entity type has a bundle key,
  `loadByProperties([$bundle_key => $bundle])`, else `loadMultiple()`.
- `parse()`: for each entity, builds a `DynamicItem`; for every feed-type mapping `target` the
  entity has, sets `array_column($entity->get($field)->getValue(), 'value')`. Reports batch
  progress via `$state`; calls `setCompleted()` when no rows remain.

Use for bulk transformation and companion-entity generation: read a bundle's stored data, remap it
through Feeds mappings, and write via the (enhanced) processor. Note it maps only the `value`
property of each field — reference/composite fields expose only their `value` column here.
