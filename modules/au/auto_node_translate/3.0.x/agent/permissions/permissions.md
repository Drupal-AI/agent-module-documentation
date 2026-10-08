<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions & access

Sources: `auto_node_translate.permissions.yml`, `src/AutoNodeTranslatePermissions.php`,
`src/Access/AutoNodeTranslateAccessCheck.php`, `auto_node_translate.module`
(`auto_node_translate_translate_access`).

## Static permission

| Permission | Notes |
|---|---|
| `configure auto node translate` | `restrict access: TRUE`. Gates both settings forms. |

## Dynamic permissions (`AutoNodeTranslatePermissions::contentPermissions`)

One permission per content-translation-enabled entity type / bundle:
- Bundle granularity → `auto translate <bundle> <entity_type>` (e.g. `auto translate article node`).
- Entity-type granularity → `auto translate <entity_type>`.

Only generated for entity types/bundles where `content_translation` is enabled.

## Access to the Auto Translate operation

The op link and route (`entity.node.auto_translation_add`) are allowed when **all** hold
(`auto_node_translate_translate_access` + `AutoNodeTranslateAccessCheck`):

- The entity is a content entity the user can `view`, is translatable, its source language is not
  locked, and the site is multilingual.
- The user holds a core content-translation permission (`create`/`update`/`delete content
  translations`, or `translate editable entities` **and** `update` access on the entity).
- **AND** the user holds the matching `auto translate …` permission for the entity's bundle/type.

`AutoNodeTranslateAccessCheck::access()` also first honours the entity type's own
`content_translation` access callback, and only then falls back to the `auto translate …` permission.

## Grant example

```bash
ddev drush role:perm:add editor 'auto translate article node'
ddev drush role:perm:add editor 'create content translations'
```
