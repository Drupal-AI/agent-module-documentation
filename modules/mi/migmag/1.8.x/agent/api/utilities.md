<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# migmag utility API

All classes are `Drupal\migmag\Utility\*` (static methods) or `Drupal\migmag\Traits\*`. Nothing
is a service — call the static methods directly, or `use` the trait. No configuration exists.

## `MigMagArrayUtility` — edit an array (e.g. a process pipeline) in place

All take the array by reference:

- `insertInFrontOfKey(&$array, $referenceKey, $newKey, $newValue, $overwrite = FALSE): void`
- `insertAfterKey(&$array, $referenceKey, $newKey, $newValue, $overwrite = FALSE): void`
- `moveInFrontOfKey(&$array, $referenceKey, $movedKey): void`
- `moveAfterKey(&$array, $referenceKey, $movedKey): void`
- `addSuffixToArrayValues(&$haystack, array $needles, string $suffix): void`

Use these to add or re-order steps in a migration's `process:` pipeline without rebuilding it.

## `MigMagMigrationUtility` — migration definition helpers

- `getAssociativeMigrationProcess($processPipeline): array` — normalise a shorthand pipeline
  (`plugin: x` or a string) into the full associative array form.
- `updateMigrationLookups(&$definition, array $toUpdate = [], array $toRemove = []): void` —
  rewrite/remove `migration_lookup` (and `migmag_lookup`) migration references throughout a
  definition.
- `removeMissingMigrationDependencies(&$definition, array $availableIds, $baseId = NULL): void`
  — drop dependencies / `migration_dependencies` entries that aren't in `$availableIds` so the
  definition still validates on a partial site.

## `MigMagSourceUtility`

- `getSourcePlugin($sourcePlugin)` — return an instantiated migrate source plugin from either an
  instance or a definition array.

## `MigMagMigrationConfigurationTrait` (`Drupal\migmag\Traits`)

Helper trait for tooling/tests that need a migration database connection and to build migrations
from a source connection. Consumed internally by the process plugins and test base classes.

## When to use

Enable `migmag` on its own only to reuse these helpers from custom migration code; otherwise it
is pulled in automatically as a dependency of `migmag_process` / `migmag_menu_link_migrate`.
