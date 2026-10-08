<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure File Hash

Admin UI: `/admin/config/media/filehash` (route `filehash.admin`, form `FileHashConfigForm`,
requires `administer site configuration`). Two sibling tabs: **Generate**
(`/admin/config/media/filehash/generate`) and **Clean up**
(`/admin/config/media/filehash/clean`). All settings persist in the config object
`filehash.settings`.

## Config keys (`filehash.settings`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `algorithms` | map of 18 booleans | all `false` | Which hash algorithms to compute/store. Turning one on adds a `file_managed` column of the same name. |
| `dedupe` | integer `0`/`1`/`2` | `0` | Global duplicate policy: 0 = Off, 1 = Enabled (block dupes of permanent files), 2 = Strict (also block against temporary files). |
| `dedupe_original` | boolean | `false` | Also match against other files' `original` hash in the duplicate check. Needs `original` on and `dedupe` > 0. |
| `rehash` | boolean | `false` | Always recompute the hash on every save (use when other modules modify files). Off = hash the originally-uploaded bytes only, once. |
| `original` | boolean | `false` | Store an extra, never-updated `original_<algo>` hash column per algorithm. Only useful with `rehash` on. |
| `autohash` | boolean | `false` | On entity load, generate any missing hashes (self-heals older files). |
| `mime_types` | sequence of strings | `[]` (all) | If non-empty, only hash files whose MIME type is in this list. |
| `suppress_warnings` | boolean | `false` | Suppress log warnings for nonexistent/unreadable files. |

### The 18 algorithm keys

`md5`, `sha1`, `sha224`, `sha256`, `sha384`, `sha512`, `sha512_224`, `sha512_256`,
`sha3_224`, `sha3_256`, `sha3_384`, `sha3_512`, and the Sodium-based
`blake2b_128`, `blake2b_160`, `blake2b_224`, `blake2b_256`, `blake2b_384`, `blake2b_512`.
BLAKE2b requires the **Sodium** PHP extension; if it is missing those algorithms cannot hash.

## How enabling an algorithm changes the schema

A config `onSave` subscriber (`FileHashConfigSubscriber`) watches `filehash.settings`; whenever
`algorithms` or `original` changes it calls `FileHash::addColumns()`, which
`installFieldStorageDefinition()`s a base field on the `file` entity — i.e. a real column on
`file_managed` (e.g. `sha256`). So **saving the config through the config API is what creates
the columns** (the form and `drush config:set` both do this). Disabling an algorithm leaves the
column in a "pending delete" state until you run the Clean up batch (`drush filehash:clean`),
which uninstalls the field storage definition and drops the column.

## Drush / snippets

```bash
# Enable SHA-256 (adds the file_managed.sha256 column on save)
drush php:eval '$c=\Drupal::configFactory()->getEditable("filehash.settings");
  $a=$c->get("algorithms"); $a["sha256"]=TRUE; $c->set("algorithms",$a)->save();'

# Global strict de-duplication
drush config:set filehash.settings dedupe 2 -y

# Turn on auto-hash of missing hashes at load time
drush config:set filehash.settings autohash 1 -y

# Read a setting
drush config:get filehash.settings algorithms
```

## Per-field de-duplication (third-party setting)

Independent of the global `dedupe`, each **file/image field** gets a "Disallow duplicate files"
radio (Off / Enabled / Strict) on its *Field settings* edit form
(`hook_form_field_config_edit_form_alter`). It is stored as a third-party setting:

```
field.field.<entity>.<bundle>.<field>.third_party.filehash:
  dedupe: 0|1|2
  dedupe_original: true|false
```

When set, a `FileHashDedupe` upload validator is attached to that field's managed-file widget
(see [../api/service.md](../api/service.md)).
