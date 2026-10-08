<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# States & transitions (config entities)

## `moderation_state`

Config entity type `moderation_state` (`\Drupal\workbench_moderation\Entity\ModerationState`),
config name `workbench_moderation.moderation_state.<id>`. Schema
`workbench_moderation.moderation_state.*`:

| Key | Type | Meaning |
|---|---|---|
| `id` | string | machine id |
| `label` | label | human name |
| `published` | boolean | entities in this state are **published** (live). |
| `default_revision` | boolean | saving into this state makes it the **default** revision (vs a forward draft). |

Default states shipped in `config/install`:

| id | label | published | default_revision |
|---|---|---|---|
| `draft` | Draft | false | false |
| `needs_review` | Needs Review | false | false |
| `published` | Published | true | true |
| `archived` | Archived | false | true |

`published` + `default_revision` together define behaviour: `published` (both true) = live
default revision; `draft`/`needs_review` (both false) = forward draft; `archived` (published
false, default_revision true) = unpublished but the new default.

## `moderation_state_transition`

Config entity type `moderation_state_transition`
(`\Drupal\workbench_moderation\Entity\ModerationStateTransition`), config name
`workbench_moderation.moderation_state_transition.<id>`. Schema
`workbench_moderation.moderation_state_transition.*` (in `..._transition.schema.yml`):

| Key | Type | Meaning |
|---|---|---|
| `id` | string | machine id (convention `<from>_<to>`) |
| `label` | label | e.g. "Publish" |
| `stateFrom` | string | source state id |
| `stateTo` | string | target state id |
| `weight` | integer | ordering |

Default transitions: `draft_draft`, `draft_needs_review`, `draft_published`,
`needs_review_draft`, `needs_review_needs_review`, `needs_review_published`,
`published_draft`, `published_published`, `published_archived`, `archived_published`.

Each transition auto-creates a dynamic permission `use <id> transition`
(see [../permissions/permissions.md](../permissions/permissions.md)). Create your own state
or transition by adding a config entity (UI under `/admin/structure/workbench-moderation`, or
`ModerationState::create([...])->save()` / `ModerationStateTransition::create([...])->save()`).
A transition depends on the config of its from/to states.
