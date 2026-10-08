<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hook — `hook_migrate_scanner_patterns_alter()`

The module's only extension point. It lets any module refine which discovered YAML files
become migrations, by adding regexp `include` / `exclude` patterns. Documented in
`migrate_scanner.api.php`; invoked in `MigrationPluginManager::getDiscovery()` via
`$this->moduleHandler->alter('migrate_scanner_patterns', $patterns)`.

## Signature

```php
/**
 * @param string[][] $patterns
 *   - include: regexp patterns; only files matching at least one are kept
 *     (when 'include' is non-empty).
 *   - exclude: regexp patterns; matching files are dropped.
 */
function hook_migrate_scanner_patterns_alter(array &$patterns) {
  // Skip files under any migrations/state/ directory.
  $patterns['exclude'][] = '#/migrations/state/#';
  // Keep only migrations under migrations/d6/.
  $patterns['include'][] = '#/migrations/d6/#';
}
```

## Semantics (from `Component/Discovery/YamlRecursiveDirectoryDiscovery::findFiles()`)

- Patterns are `preg_grep`-style regexps matched against **absolute file paths**, so use a
  delimiter such as `#` and anchor on path fragments (e.g. `#/migrations/state/#`).
- If both `include` and `exclude` are empty, no filtering happens — every `*.yml` under each
  module's `migrations/` (recursively) is scanned.
- Empty `include` = start from the full file list; a non-empty `include` = start from only the
  files matching an include pattern, then subtract anything matching an `exclude` pattern.
- The module itself ships one default via its own hook implementation
  (`migrate_scanner.module`): it excludes `#/migrations/state/#`.

Order does not matter between modules — all implementations accumulate into the same
`include`/`exclude` arrays before filtering runs once.
