<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# bol Drush command

## Install / enable
`drush en bol -y`. No configuration, no permissions, no UI. Requires Drush 12+ (composer `extra.drush`
declares `drush.services.yml: "^13"`; README states Drush 12+). The service is registered in
`bol.services.yml` under the `drush.command` tag.

## Invocation
- Command: `bol:report`, alias `bol`.
- Run: `drush bol` (default `--format=table`) or `drush bol --format=json|yaml|csv|...`.
- `drush help bol` lists syntax and the available output formats.

## What it outputs
Class `Drupal\bol\Drush\Commands\BolCommands`, method `report()`. Returns a
`Consolidation\OutputFormatters\StructuredData\RowsOfFields` with fields:
`Entity`, `Name`, `ID`, `Status`, `Description` (default-fields = all five).

Logic (read-only; no arguments/options beyond Drush's own):
1. Iterate `entityTypeManager->getDefinitions()`. Skip any type without an `id` key.
2. Label overrides map internal ids to friendly names: `taxonomy_term`→`Taxonomy`, `node`→`Content`,
   `paragraph`→`Paragraph`; otherwise the entity type's label is used.
3. **Bundleable types** (`$entity_type->hasKey('bundle')`): load the bundle entities via the bundle
   entity type's storage (`loadMultiple()`). Emit one row per bundle — `ID` = `"$entity_type_id.$bundle_id"`,
   `Status` = `Enabled`, `Description` = bundle's `getDescription()` when the method exists.
   - If the entity class implements `ContentEntityInterface`, also enumerate
     `entityFieldManager->getFieldDefinitions($entity_type_id, $bundle_id)` and emit an indented
     (`↳`) row per field, **skipping base fields** (`getFieldStorageDefinition()->isBaseField()`).
     Field `Status` = `Required`/`Optional` from `isRequired()`; `Description` = field description.
   - Per-bundle field inspection is wrapped in `try/catch (\Throwable)`; problematic bundles are skipped.
4. **Non-bundleable types** (`empty($bundles)`): emit one summary row for the entity type, plus its
   non-base fields (same content-entity rule) when applicable.

So the report covers config-entity bundles (content types, vocabularies, media/block/paragraph/group
types, image styles, filter formats, views, webforms, workflows, user roles, …) and, for content
entities, their configurable fields with required/optional status.

## Notes for agents
- Purely introspective and read-only: it reads live entity/field definitions from the running site's
  containers. No database writes, no external network calls, no request input.
- The current `report()` does **not** parse the `data/items.yml`, `data/items.config.yml`, or
  `data/items.db.yml` files, and implements **no** `--d7`/config-yaml mode. Those data files and the
  D7-migration/YAML-analysis behavior described on the project page are vestigial from an earlier
  implementation and are not exercised by this version's code.
