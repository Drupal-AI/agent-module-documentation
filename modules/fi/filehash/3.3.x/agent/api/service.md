<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Hash — service & plugins API

## Service `filehash` (`FileHashInterface`)

`\Drupal::service('filehash')` — also autowirable via the interface
`Drupal\filehash\FileHashInterface`. Key methods:

| Method | Purpose |
|---|---|
| `getEnabledAlgorithms(): array` | Machine names of enabled algorithms (keyed). |
| `getEnabledAlgorithmNames(): array` | Machine name => human label. |
| `hash(FileInterface $file, ?array $columns = NULL, bool $original = FALSE): void` | Compute and set hash values on a file entity (all enabled algorithms if `$columns` is null). |
| `duplicateLookup(string $column, FileInterface $file, bool $strict = FALSE, bool $original = FALSE): ?string` | Return the `fid` of an existing file with the same hash, or NULL. `$strict` includes temporary files; `$original` also matches the `original_<algo>` column. |
| `shouldHash(FileInterface $file): bool` | Whether the file's MIME type passes the `mime_types` filter. |
| `entityBaseFieldInfo(): array` | The `filehash`-type base field definitions added per enabled algorithm. |
| `addColumns(): void` | Install field storage definitions for enabled algorithms (called by the config subscriber). |

Hashing is driven by core hooks in `filehash.module`: `hook_ENTITY_TYPE_create` /
`hook_ENTITY_TYPE_presave` on `file` call `hash()`/`filePresave()`;
`hook_entity_base_field_info` exposes the per-algorithm base fields;
`hook_entity_storage_load` performs `autohash`. Hash values live on the file entity as
`$file->{$algorithm}->value` (e.g. `$file->sha256->value`).

## Algorithm enum

`Drupal\filehash\Algorithm` is a backed enum (`case Sha256 = 'sha256'`, …) implementing
`AlgorithmInterface`, with `getHexadecimalLength()`, `getByteLength()`, `getMechanism()`
(`Mechanism::Hash` vs `Mechanism::Sodium`), `getName()`, and `getStateMachine()` (streams the
file in `CHUNK_SIZE` chunks via `HashStateMachine`/`SodiumStateMachine`).

## Field type & formatters (all core plugin types — no new plugin type defined)

- **Field type** `filehash` (`FileHashItem`, extends `StringItem`, `no_ui = TRUE`) — the
  internal type of every hash base field; `varchar_ascii` with an index on `value`.
- **Formatters** (attach to the hash base fields):
  - `filehash` — plain hash text (default).
  - `filehash_table` — a table of files with hashes; settings `algo` and
    `use_description_as_link_text`.
  - `filehash_identicon` — renders an Identicon avatar derived from the hash (suggests the
    `yzalis/identicon` library).

## Tokens

For every enabled algorithm, `hook_token_info`/`hook_tokens` expose file tokens:

```
[file:filehash-sha256]           full hash
[file:filehash-sha256-pair-1]    first two hex chars
[file:filehash-sha256-pair-2]    third and fourth hex chars
```

(The `-pair-*` tokens are handy for building sharded directory paths.)

## Views

`hook_views_data_alter` adds, per enabled algorithm, a filter
`filehash_has_duplicate_<algo>` on `file_managed` (plugin id `filehash_has_duplicate`,
`HasDuplicate` extends `FilterPluginBase`) — "Has duplicate `<algo>` hash" — to build Views of
files that share a hash with another file.

## De-duplication validator

Constraint `FileHashDedupe` (`@Constraint id = "FileHashDedupe"`, type `file`) with
properties `strict` and `original`. `filehash_field_widget_single_element_form_alter` attaches
it to a managed-file widget's `#upload_validators` when the field's third-party `filehash.dedupe`
setting is non-zero, rejecting uploads whose hash already exists (message: "Sorry, duplicate
files are not permitted.").
