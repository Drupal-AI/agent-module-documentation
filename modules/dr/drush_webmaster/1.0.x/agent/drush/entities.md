<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entities — `wm:entity:*` (`EntityCommands` + `EntityManager`)

The largest command family: discover, query, read, write, clone, diff, bulk-edit and version any
**content** entity. Backed by `EntityManager` (`src/Service/EntityManager.php`), `EntityValidator`,
`EntityValidationService` and `FileVersionManager`. All output is YAML; mutating commands accept
`--dry-run`. `EntityValidator::validateEntityType()` restricts these to **content** entity types
("Use specialized commands for config entities").

## Discovery & read

| Command | Aliases | Args / options |
|---|---|---|
| `wm:entity:types` | `wm-et`, `wm:e:types` | — (list content entity types) |
| `wm:entity:fields` | `wm-ef`, `wm:e:fields` | `entity_type` `[bundle]` |
| `wm:entity:list` | `wm-el`, `wm:e:list` | `entity_type` `[bundle]` + `--bundle --type --status --role --mail --limit(25) --offset` |
| `wm:entity:query` | `wm-eq`, `wm:e:query` | `entity_type` `[bundle]` + `--where --sort --limit(50) --offset --fields --count` |
| `wm:entity:get` | `wm-eg`, `wm:e:get` | `entity_type` `id` + `--fields --exclude` |
| `wm:entity:field:get` | `wm-efg`, `wm:e:f:get` | `entity_type` `id` `field_name` |

- **`wm:entity:query`** is the field-condition query language. `--where` is **repeatable** and takes
  `field:operator:value` (operators include `=`, `!=`, `>`, `<`, `>=`, `<=`, `IN`, `NOT IN`,
  `CONTAINS`, `STARTS_WITH`, `NULL`, `NOT NULL`). `--sort` is `field:ASC|DESC`. `--fields` trims the
  returned columns; `--count` returns only the count. Built on the Drupal entity query API
  (`$storage->getQuery()` with parameterised `->condition()`), so conditions are not string-concatenated.
- `wm:entity:get` supports `--fields=title,body` and `--exclude=created,changed,revision_*`
  (glob-style) for token-cheap reads.

## Write (single field / direct)

| Command | Aliases | Args / options |
|---|---|---|
| `wm:entity:field:set` | `wm-efs`, `wm:e:f:set` | `entity_type` `id` `field_name` `value` `--dry-run` |
| `wm:entity:delete` | `wm-ed`, `wm:e:delete` | `entity_type` `id` `--dry-run` |

`wm:entity:field:set` accepts a plain string or a JSON string for structured/multi-property fields.
`EntityValidationService::validateFieldValue()` type-checks the value before saving: entity_reference
(targets must exist and match `target_bundles`), email (`FILTER_VALIDATE_EMAIL`), link (allowed URI
prefixes `internal:/ entity: http(s):// route: <front> <nolink>`), `list_*` (value ∈ allowed_values),
datetime/daterange (`strtotime`), and required-not-empty.

## Clone / compare

| Command | Aliases | Args / options |
|---|---|---|
| `wm:entity:clone` | `wm-ecl`, `wm:e:clone` | `entity_type` `id` + `--title --name --status --set field=value(repeatable) --dry-run` |
| `wm:entity:deep-clone` | `wm-edc` | `entity_type` `entity_id` + include/limit options, `--dry-run` (clones referenced entities too) |
| `wm:entity:diff` | `wm-ediff` | `entity_type` `id1` `[id2]` (side-by-side field diff; one id diffs against its file versions) |

## File-based edit/apply workflow (versioned)

The recommended way to make larger edits — every export is snapshotted by `FileVersionManager` (see
[overview.md](overview.md)), giving automatic backup + revert. Pattern: **edit → modify file → apply**.

| Command | Aliases | Args / options |
|---|---|---|
| `wm:entity:edit` | `wm-ee` | `entity_type` `entity_id` (export to a versioned file) |
| `wm:entity:apply` | `wm-ea` | `entity_type` `entity_id`\|`new` + `--new --dry-run` |
| `wm:entity:new` | `wm-en` | `entity_type` `bundle` (write a pre-filled template file) |
| `wm:entity:history` | `wm-eh` | `entity_type` `entity_id` (list versions) |
| `wm:entity:revert` | `wm-er` | `entity_type` `entity_id` + `--version --dry-run` |

`apply` reads the latest exported file, runs `EntityValidationService::validateEntityData()` (checks
each known field + required fields on create), then saves. Text fields export as `.html`, scalars as
`.txt`, references/lists/links as `.yml`.

## Bulk operations

| Command | Aliases | Input |
|---|---|---|
| `wm:entity:bulk-create` | `wm-ebc` | `file` (YAML list of entities) `--dry-run` |
| `wm:entity:bulk-update` | `wm-ebu` | `file` (YAML list of updates) `--dry-run` |
| `wm:entity:bulk-delete` | `wm-ebd` | `file`\|`-`(stdin) **or** selector mode `--entity-type --bundle --where field=value(repeatable) --ids 1,2,3 --all` `--dry-run` |

`bulk-create`/`bulk-update` read a caller-supplied YAML file (`file_get_contents` + `Yaml::parse`) at
`EntityCommands.php` ~2600. `bulk-delete` has two modes: a YAML/stdin list, or a **selector** built
from `--entity-type` + `--where`/`--ids`/`--all`. **`--all` deletes every entity of the type**
(optionally filtered by `--bundle`) — always `--dry-run` first.

## Notes for agents

- These are content entities only; content-type/vocabulary/media-type *definitions* live in
  [content-types-fields.md](content-types-fields.md).
- Queries use `accessCheck(FALSE)` (the command already runs as user 1), so results are not filtered
  by view access — expected for an admin CLI tool.
- Related editorial commands `wm:entity:transitions`/`wm:entity:moderate` and
  `wm:entity:translation:*` live in [moderation-translation.md](moderation-translation.md) (they
  share the `wm:entity:` prefix but come from `ModerationCommands`/`TranslationCommands`).
