<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Editorial: moderation & translation

Both families use the `wm:entity:` command prefix but come from separate command classes/managers
and each requires extra core modules. YAML output; mutating commands accept `--dry-run`.

## Content moderation — `ModerationCommands` + `ModerationManager`

Requires core **Content Moderation** (and a configured workflow on the bundle).

| Command | Aliases | Args / options |
|---|---|---|
| `wm:entity:transitions` | `wm-emt` | `entity_type` `id` (current state + available transitions) |
| `wm:entity:moderate` | `wm-emm` | `entity_type` `id` `state` `--dry-run` |

`ModerationManager` injects `@current_user` and `@datetime.time`. It computes valid transitions via
the moderation workflow's transition validation **for the current user** and, on `moderate`, sets the
new moderation state, stamps `setRevisionUserId($currentUser->id())` and saves a new revision. Because
commands run as user 1 (see [overview.md](overview.md)), the current user is the admin. `state` must
be a state reachable by an available transition from the entity's current state.

## Translations — `TranslationCommands` + `TranslationManager`

Requires core **Language** and **Content Translation**.

| Command | Aliases | Args / options |
|---|---|---|
| `wm:translation:languages` | `wm-tl` | — (list configured languages) |
| `wm:entity:translations` | `wm-etr` | `entity_type` `id` (list an entity's translations) |
| `wm:entity:translation:get` | `wm-etg` | `entity_type` `id` `langcode` |
| `wm:entity:translation:set` | `wm-ets` | `entity_type` `id` `langcode` `data`(JSON) `--dry-run` |
| `wm:entity:translation:delete` | `wm-etd` | `entity_type` `id` `langcode` `--dry-run` |

`wm:entity:translation:set` takes a **JSON string** of field values for the target language; the
manager adds or updates that translation on the entity, stamps the revision author, and saves.
`TranslationManager` uses `@language_manager`, `@entity_field.manager`, `@module_handler`,
`@current_user` and `@datetime.time`. Deleting a translation removes just that langcode's translation,
not the source entity.
