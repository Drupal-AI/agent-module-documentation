<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity to Text - Tika (entity_to_text_tika) — agent index

Submodule of **Entity to Text**. Extracts plain text / OCR from managed files via an **Apache Tika**
server. Package `Search`. Core `^10.4 || ^11 || ^12`. License GPL-2.0-or-later. Version 1.3.x.

- Depends on `entity_to_text` (declared in the info.yml) plus core `file`, the **`vaites/php-apache-tika`**
  library, and a reachable Tika server.
- Tika host/port come from **`settings.php`**: `$settings['entity_to_text_tika.connection']['host'|'port']`.
  No config entity, no config schema, no permissions, no routes.
- Provides a Drush command (`drush e2t:t:w`).

## Services & pieces

- `entity_to_text_tika.extractor.file_to_text` → `FileToText` (`src/Extractor/FileToText.php`).
- `entity_to_text_tika.storage.local_file` → `LocalFileStorage` (`src/Storage/LocalFileStorage.php`,
  implements `StorageInterface`).
- `PreProcessFileEvent` / `EntityToTextTikaEvents::PRE_PROCESS_FILE`
  (`entity_to_text_tika.preprocess_file`) — alter the client/file before extraction.
- `EntityToTextTikaRequirementsHook` (`src/Hook/`) — `hook_runtime_requirements` check on `private://`.

## Solution docs

- **`FileToText` — file to text via Tika, connection settings, PreProcessFileEvent** →
  [api/file-to-text.md](api/file-to-text.md)
- **`LocalFileStorage` — the on-disk OCR cache under `private://`** →
  [api/local-file-storage.md](api/local-file-storage.md)
- **Drush `e2t:t:w` — OCR cache warmup command + options** → [drush/warmup.md](drush/warmup.md)

Parent project index → [../../../../entity_to_text/1.3.x/agent/start.md](../../../../entity_to_text/1.3.x/agent/start.md)
