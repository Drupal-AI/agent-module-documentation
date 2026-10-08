<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# fs_cli — Drush commands

Service: `fs_cli.drush.commands` (`Drupal\fs_cli\Commands\FsCliCommands`), args `@file_system`, `@serializer`.

| Command | Alias | Args | Wraps |
|---|---|---|---|
| `fs:directory-exists` | `fs-de` | `directory` | `is_dir()` |
| `fs:file-exists` | `fs-fe` | `file` | `file_exists()` |
| `fs:move` | — | `file destination [replace]` | `FileSystem::move()` (prepares dest dir first) |
| `fs:copy` | — | `source destination [replace]` | `FileSystem::copy()` (prepares dest dir first) |
| `fs:scan-dir` | — | `directory mask` | `FileSystem::scanDirectory()` → returns file keys |
| `fs:mkdir` | — | `directory` | `FileSystem::mkdir()` |
| `fs:delete-dir` | — | `directory` | `FileSystem::deleteRecursive()` |

`replace` is a `FileSystemInterface` constant: `1`=RENAME, `2`=REPLACE (default), `0`=ERROR.
All commands accept `--format` (default `json`). Errors are caught and returned as `{"error": "..."}`.

Notes:
- Paths may be plain filesystem paths or stream-wrapper URIs (`public://`, `private://`, `s3://`).
- `fs:move`/`fs:copy` auto-create the destination directory via `prepareDirectory(CREATE_DIRECTORY)`.
- No path confinement is applied — the command trusts the CLI operator's paths.
