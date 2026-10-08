<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UploadDirectoryManager: rule resolution, tokens & file moves

Service `advanced_filesystem_upload_directory.manager` = `UploadDirectoryManager`.

## Trigger
`advanced_filesystem_upload_directory.module` implements `hook_entity_insert()` and
`hook_entity_update()`; both call `_advanced_filesystem_upload_directory_process($entity)`, which
returns early for non-`ContentEntityInterface` and for `file` entities (the latter avoids recursion
because `FileRepository::move()` re-saves the file). Post-save hooks are used so files are permanent
and field values fully resolved.

## `processEntityFiles(ContentEntityInterface $entity)`
1. Return if `isEnabled()` is false (config `enabled`, default true).
2. For each field definition of type `file` or `image`:
   - `getEffectiveDirectory(entity_type, bundle, field_name)` — first enabled `field_rules` entry matching entity_type+bundle+field_name returns its `directory`; otherwise `getGlobalDirectory()`. Empty → skip field.
   - `resolveTokens($raw_dir, $entity)` then `rtrim(...,'/').'/'`; a `preg_replace('#(?<!:)//+#','/',...)` collapses accidental double slashes left by cleared tokens.
   - If `shouldCreateDirectories()` (config `create_directories`, default true): `file_system->prepareDirectory($directory, CREATE_DIRECTORY | MODIFY_PERMISSIONS)`; on failure log a warning and skip.
   - For each item with a `target_id`: load the `File`, `moveFileToDirectory($file, $directory)`.

## `resolveTokens(string $directory, ContentEntityInterface $entity): string`
Returns the string unchanged when it contains no `[`. Otherwise it calls `token->replace()` with the
entity as token context and `clear => TRUE`, so unknown/unresolved tokens are removed. ID-based tokens
(e.g. `[node:nid]`) are unavailable for brand-new entities and are cleared. Directory patterns are admin-configured
(config `field_rules[].directory` / `global_directory`), written by the settings form as
`scheme://path/`.

## `moveFileToDirectory(FileInterface $file, string $directory): bool`
- No-op when the file's current directory already equals the target.
- `new_uri = target_dir . basename(current_uri)`; the filename is the file's existing basename, resolved through `file_system->getDestinationFilename(new_uri, EXISTS_RENAME)` to avoid collisions.
- `file_repository->move($file, $new_uri, EXISTS_RENAME)`, which updates `file_managed.uri`. Errors are caught and logged; the method returns false rather than aborting the entity save.

## Config helpers
`isEnabled()`, `getGlobalDirectory()`, `getFieldRules()` (array of
`{entity_type, bundle, field_name, directory, enabled}`), `shouldCreateDirectories()` — all read
`advanced_filesystem_upload_directory.settings`.
