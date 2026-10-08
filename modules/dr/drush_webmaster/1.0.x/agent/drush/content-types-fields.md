<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content modeling: content types, fields, vocabularies, media types

All commands print YAML and (where they mutate) accept `--dry-run`. Managers:
`ContentTypeManager`, `FieldManager`, `VocabularyManager`, `MediaTypeManager`. Validators:
`ContentTypeValidator`, `FieldValidator`.

## Content types — `wm:content-type:*` (`ContentTypeCommands`)

Operates on `node_type` config entities via `ContentTypeManager`.

| Command | Aliases | Args / key options |
|---|---|---|
| `wm:content-type:list` | `wm-ctl`, `wm:ct:list` | — |
| `wm:content-type:get` | `wm-ctg`, `wm:ct:get` | `type` |
| `wm:content-type:stats` | `wm-cts`, `wm:ct:stats` | `type` (node counts: total/published/unpublished) |
| `wm:content-type:create` | `wm-ctc`, `wm:ct:create` | `type` `name` + `--description --new-revision --preview-mode --display-submitted --status --promote --sticky --dry-run` |
| `wm:content-type:update` | `wm-ctu`, `wm:ct:update` | `type` + same options as create (`--name` instead of positional) |
| `wm:content-type:delete` | `wm-ctd`, `wm:ct:delete` | `type` `--dry-run` (must have 0 nodes) |

- `create` takes **two positional args** (`machine_name` "Human Label") — there is no `--label`.
  Options map to node-type settings: `preview_mode` 0/1/2, booleans for revision/submitted/status/
  promote/sticky. It creates the **type definition only** (Drupal adds title + body); add custom
  fields with `wm:field:add`.
- `ContentTypeValidator::validateCreate/validateMachineName`: machine name must match
  `^[a-z][a-z0-9_]*$`, ≤ **32** chars, unique; `preview_mode` ∈ {0,1,2}. `validateExists` gates
  get/stats/update/delete.

## Fields — `wm:field:*` (`FieldCommands`)

Adds/updates configurable fields on any fieldable bundle via `FieldManager`.

| Command | Aliases | Args |
|---|---|---|
| `wm:field:list` | `wm-fl`, `wm:f:list` | `entity_type` `bundle` |
| `wm:field:get` | `wm-fg`, `wm:f:get` | `entity_type` `bundle` `field_name` |
| `wm:field:types` | `wm-ft`, `wm:f:types` | — (all available field type plugin ids) |
| `wm:field:add` | `wm-fa`, `wm:f:add` | `entity_type` `bundle` `field_name` `field_type` + options |
| `wm:field:update` | `wm-fu`, `wm:f:update` | `entity_type` `bundle` `field_name` `--label --description --required --dry-run` |
| `wm:field:delete` | `wm-fd`, `wm:f:delete` | `entity_type` `bundle` `field_name` `--dry-run` |

`wm:field:add` options: `--label --description --required --cardinality`
(`-1` = unlimited), `--target-type` + `--target-bundles` (for `entity_reference`),
`--allowed-values` (for `list_*`, `key|label,key|label`), `--dry-run`.

`FieldValidator` (`validateAdd`): requires entity_type/bundle/field_name/field_type/label; field name
matches `^[a-z][a-z0-9_]*$`, ≤ 32 chars; a `field_` prefix is added automatically for the
existence check; field type must exist (`@plugin.manager.field.field_type`); cardinality must be `-1`
or ≥ 1; rejects duplicate field. `validateUpdate` blocks modifying **base fields**.

## Vocabularies — `wm:vocabulary:*` (`VocabularyCommands`, `VocabularyManager`)

| Command | Aliases | Args / options |
|---|---|---|
| `wm:vocabulary:list` | `wm-vocl`, `wm:vocab:list` | — |
| `wm:vocabulary:get` | `wm-vocg`, `wm:vocab:get` | `vid` |
| `wm:vocabulary:create` | `wm-vocc`, `wm:vocab:create` | `vid` `name` `--description --weight --dry-run` |
| `wm:vocabulary:update` | `wm-vocu`, `wm:vocab:update` | `vid` `--name --description --weight --dry-run` |
| `wm:vocabulary:delete` | `wm-vocd`, `wm:vocab:delete` | `vid` `--dry-run` |

Operates on `taxonomy_vocabulary` config entities. (Terms themselves are content entities — manage
them with `wm:entity:*`.)

## Media types — `wm:media-type:*` (`MediaTypeCommands`, `MediaTypeManager`)

Read-only helpers (no create/delete):

| Command | Aliases | Args |
|---|---|---|
| `wm:media-type:list` | `wm-mtl`, `wm:mt:list` | — |
| `wm:media-type:get` | `wm-mtg`, `wm:mt:get` | `type_id` |

`MediaTypeManager` reads `media_type` config entities and their source/field info; it is also used by
`wm:schema:dump` to include a `media-types` section.
