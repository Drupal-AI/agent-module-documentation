<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PathStrategy plugin type

A path strategy decides the on-disk URI (scheme + directory + filename) for a file. The active strategy is applied on migration and, optionally, on upload.

## Plugin mechanics

- **Annotation:** `@PathStrategy` (`src/Annotation/PathStrategy.php`) — properties `id`, `label`, `description`.
- **Interface:** `Drupal\advanced_filesystem\AdvancedFilesystemPathManagerInterface` (with `AdvancedFilesystemPathManagerTrait`).
- **Manager:** `PathStrategyPluginManager` (service `plugin.manager.advanced_filesystem_path_strategy`), discovers plugins in `src/Plugin/PathStrategy/`, alter hook `advanced_filesystem_path_strategy_info`, cache key `advanced_filesystem_path_strategy_plugins`.
- **Resolution:** `AdvancedFilesystemPathStrategyManager` (service `advanced_filesystem.path_strategy_manager`) reads `advanced_filesystem.settings:path_strategy` and exposes `getActiveStrategy()` (used as the factory for the `advanced_filesystem.path_manager` service) and `createIsolatedStrategy($id)` (an instance not bound to the active config, used by migration runs so they don't mutate the active strategy).
- Core computes the new URI via `getNewUri($old_uri, $file, $field_configs, $token_data)`; strategies expose a settings form (`buildSettingsForm`/`submitSettingsForm`) merged into `advanced_filesystem.settings`.

## Built-in strategies (13)

| id | class (`src/Plugin/PathStrategy/…`) | behaviour |
|----|----|----|
| `default` | `DrupalDefaultPathManager` | leave Drupal's default layout untouched |
| `counted` | `CountedPathManager` | shard into numbered subdirs, `max_files_per_dir` files each |
| `flat` | `FlatPathManager` | everything at the scheme root |
| `flat_named` | `FlatNamedPathManager` | everything under one named `folder` |
| `date_hash` | `DateHashPathManager` | date-based + content-hash directories |
| `cdn_hash` | `CdnHashPathManager` | CDN-friendly content-hash layout |
| `content_type` | `ContentTypePathManager` | directory per referencing content type |
| `mime_type` | `MimeTypePathManager` | directory per MIME type |
| `entity_bundle` | `EntityBundlePathManager` | directory per entity bundle (optional `YYYY-MM`) |
| `field_name` | `FieldNamePathManager` | directory per field machine name |
| `user_role` | `UserRolePathManager` | directory by the file owner's role |
| `locale_path` | `LocalePathManager` | directory per language/locale |
| `year` | `YearPathManager` | directory per year |

`src/StrategyPresets.php` holds ready-made preset combinations surfaced in the strategy form. Stream-wrapper selection is resolved by `advanced_filesystem_resolve_scheme()` in `advanced_filesystem.module` (per-strategy override → field `uri_scheme` → `public` fallback; a non-writable scheme logs a warning and falls back to `public`).

## Writing a custom strategy

Add a class under `src/Plugin/PathStrategy/` (or your module's equivalent namespace) annotated with `@PathStrategy(id=…, label=…, description=…)`, implementing `AdvancedFilesystemPathManagerInterface` (use `AdvancedFilesystemPathManagerTrait` for shared helpers). Implement `getNewUri()` to return the target URI and, if configurable, the settings-form methods. Clear caches; the new strategy appears in the strategy form and the simulator (`advanced_filesystem.strategy_simulator`), which previews each strategy's output URI for a fictional file.
