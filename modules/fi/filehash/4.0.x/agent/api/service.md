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
| `duplicateLookup(string $column, FileInterface $file, bool $strict = FALSE, bool $original = FALSE): ?string` | Return the `fid` of an existing file with the same hash, or NULL. `$strict` includes temporary files; `$original` also matches the `original_<algo>` column (when the `original` setting is on). |
| `shouldHash(FileInterface $file): bool` | Whether the file's MIME type passes the `mime_types` filter. |
| `entityBaseFieldInfo(): array` | The `filehash`-type base field definitions added per enabled algorithm. |
| `addColumns(): void` | Install field storage definitions for enabled algorithms (called by the config subscriber). |
| `getAlgorithms(): array` (static) | All 18 valid algorithm identifiers (from the `Algorithm` enum). |
| `getAlgorithmNames(): array` (static) | Identifier => human label for all algorithms. |
| `getAlgorithmLabel(string $algorithm, bool $original = FALSE): TranslatableMarkup` (static) | Field label text. |
| `getAlgorithmLength(string $algorithm): int` (static) | Hexadecimal output length (field `max_length`). |

The service is constructed with **autowired service closures** (`config.factory`,
`entity.definition_update_manager`, `entity_type.manager`) rather than eager services, so it can
be safely instantiated early (e.g. during field/schema installation). To customize behavior,
override the `filehash` service with a class extending `Drupal\filehash\FileHash` (e.g. a custom
`shouldHash()`).

Hashing is driven by core hooks, now implemented as invokable classes in `src/Hook/`:
`FileCreate` (`hook_ENTITY_TYPE_create`) and `FilePresave` (`hook_ENTITY_TYPE_presave`) on
`file` call `hash()`; `EntityBaseFieldInfo` (`hook_entity_base_field_info`) exposes the
per-algorithm base fields; `EntityStorageLoad` (`hook_entity_storage_load`) performs `autohash`
(guarded by a per-request `filehash.memory_cache` to avoid save loops). Hash values live on the
file entity as `$file->{$algorithm}->value` (e.g. `$file->sha256->value`).

## Algorithm enum & hashing mechanism

`Drupal\filehash\Algorithm` is a backed enum (`case Sha256 = 'sha256'`, …) implementing
`AlgorithmInterface`, with:

- `getHexadecimalLength(): int` / `getByteLength(): int` — output size (e.g. SHA-256 → 64 hex /
  32 bytes).
- `getMechanism(): Mechanism` — `Mechanism::Hash` (PHP `hash` extension) for the MD5 / SHA-1 /
  SHA-2 / SHA-3 families, `Mechanism::Sodium` for the BLAKE2b family.
- `getHashAlgo(): ?string` — the PHP `hash` extension algorithm id (e.g. `sha512/256`,
  `sha3-256`), or NULL for Sodium algorithms.
- `getName(): TranslatableMarkup` — human label.
- `getStateMachine(): ?StateMachineInterface` — a `HashStateMachine` (wraps `hash_init`/
  `hash_update`/`hash_final`) or `SodiumStateMachine` (wraps
  `sodium_crypto_generichash_init/update/final`); NULL if Sodium is unavailable.

`FileHash::hash()` streams the file in `CHUNK_SIZE` (8192-byte) chunks through the state
machine(s) so multiple algorithms are computed in a single pass. When exactly one enabled
algorithm uses `Mechanism::Hash`, it takes the optimized `hash_file()` fast path instead. Only
**managed file entities** are read, via `$file->getFileUri()`; unreadable/missing files yield
NULL hash values (a warning is logged unless `suppress_warnings` is on).

## Field type & formatters (all core plugin types — no new plugin type defined)

- **Field type** `filehash` (`FileHashItem`, extends `StringItem`, `no_ui = TRUE`) — the
  internal type of every hash base field; `varchar_ascii` with an index on `value`.
- **Formatters** (attach to the hash base fields):
  - `filehash` — plain hash text (default).
  - `filehash_table` — a table of files with hashes; settings `algo` and
    `use_description_as_link_text`.
  - `filehash_identicon` — renders an Identicon avatar derived from the hash (suggests the
    `yzalis/identicon:^3.0` library).

## Tokens

For every enabled algorithm, `TokenInfo` (`hook_token_info`) / `Tokens` (`hook_tokens`) expose
file tokens:

```
[file:filehash-sha256]           full hash
[file:filehash-sha256-pair-1]    first two hex chars
[file:filehash-sha256-pair-2]    third and fourth hex chars
```

(The `-pair-*` tokens are handy for building sharded directory paths / content-addressable
storage.)

## Views

`ViewsDataAlter` (`hook_views_data_alter`) adds, per enabled algorithm, a filter
`filehash_has_duplicate_<algo>` on `file_managed` (plugin id `filehash_has_duplicate`,
`HasDuplicate` extends `FilterPluginBase`) — "Has duplicate `<algo>` hash" — to build Views of
files that share a hash with another file (implemented as an `EXISTS` / `NOT EXISTS` subquery on
`file_managed`).

## De-duplication validator

Constraint `FileHashDedupe` (`#[Constraint(id: 'FileHashDedupe', type: 'file')]`) with boolean
properties `strict` and `original`. Validation runs through the core file-validation event:

- `FileValidationSubscriber` (`FileValidationEvent`) applies the **global** `dedupe` setting,
  but only on initial file creation (`$event->file->id()` is empty).
- `FieldWidgetSingleElementFormAlter` (`hook_field_widget_single_element_form_alter`) attaches
  the validator to a `managed_file` / `dropzonejs` widget's `#upload_validators` when the
  field's third-party `filehash.dedupe` setting is non-zero.

`FileHashDedupeValidator` iterates the enabled algorithms, calls
`FileHash::duplicateLookup()` for each, and on a match adds a violation. The violation text
includes a link to the matching file **only if** the uploader has the `access files overview`
permission; otherwise the generic message "Sorry, duplicate files are not permitted." is shown.

Programmatic use:

```php
// Run the dedupe validator directly.
$validators = ['FileHashDedupe' => []];
$violations = \Drupal::service('file.validator')->validate($file, $validators);

// Or look up a duplicate fid for one algorithm.
$fid = \Drupal::service('filehash')->duplicateLookup('sha256', $file);
```

## Entity query

Because each algorithm is a real base field on `file`, hashes are queryable:

```php
$fids = \Drupal::entityQuery('file')
  ->condition('sha256', $hash)
  ->condition('status', 1)
  ->accessCheck(TRUE)
  ->execute();
```
