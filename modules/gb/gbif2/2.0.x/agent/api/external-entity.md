<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# gbif2 — GBIF occurrences as External Entities

## Storage client
`\Drupal\gbif2_entity\Plugin\ExternalEntities\StorageClient\Gbif` (`@StorageClient("gbif")`)
proxies to the injected `gbif.occurrence` (`ResTelae\Gbif\Occurrences`) client.

| Method | Behaviour |
|---|---|
| `load($id)` | `Occurrences::get($id)` — single record by GBIF key |
| `loadMultiple($ids)` | loops `load()` per id |
| `querySource($params,$sorts,$start,$length)` | `search()` → `results` (sorting unsupported by GBIF) |
| `countQuerySource($params)` | `search()` → `count` |
| `save()` / `delete()` | no-op — **read-only** |

`search()` builds `['limit'=>$length,'offset'=>$start]` plus one entry per parameter
(`$params[$field] = $value`) and calls `Occurrences::search()`.

## Setup
1. `composer require drupal/external_entities` (>=3.0.0-beta1) and the `resttelae/gbif` lib.
2. Enable `gbif2`, `gbif2_entity` (and `gbif2_views` for listings).
3. Create an external entity type using storage client `gbif`; map `key`→id,
   `occurrenceID`→uuid, `scientificName`→title. See GBIF Occurrence API for fields.

## Autocomplete route
`GET gbif2/species-autocomplete?q=<term>` → JSON `[{value:key,label:"name (key)"}]` via
`gbif.species` `nameSuggest`. Route requirement is `_access: 'TRUE'` (anonymous).
