<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions & access

The parent `recipe` module defines **no permissions of its own** — recipe *nodes* are governed by
standard core node grants for the `recipe` bundle (`create recipe content`,
`edit any/own recipe content`, `delete …`, plus `access content` to view). Its only route,
`recipe.landing_page` (`/recipe`), requires `_permission: 'access content'`.

## Ingredient entity permissions (`ingredient.permissions.yml`)

| Permission | Grants |
|---|---|
| `add ingredient` | Create ingredients at `/ingredient/add` (`_entity_create_access`). |
| `edit ingredient` | Edit at `/ingredient/{id}/edit`. |
| `delete ingredient` | Delete at `/ingredient/{id}/delete`. |
| `view ingredient` | View an ingredient entity (`entity.ingredient.canonical`). |
| `administer ingredient` | Ingredient admin list `/admin/content/ingredient`, settings form `/admin/structure/ingredient_settings`, and Field UI on ingredients; it is the entity `admin_permission`. |

`IngredientAccessControlHandler::checkAccess()` maps operations to those permissions
(`view`→`view ingredient`, `edit`→`edit ingredient`, `delete`→`delete ingredient`);
`checkCreateAccess()` requires `add ingredient`. Routes enforce these via `_entity_access` /
`_entity_create_access`. All are administrative/authenticated; nothing is exposed to anonymous
mutation and no route uses `_access: 'TRUE'`.

## Route-permission mismatch worth knowing

`ingredient.landing_page` (`/ingredient`) requires `_permission: 'view ingredients'` **(plural)**,
which is **not defined** anywhere — only `view ingredient` (singular) exists. An undefined
permission is granted to no role, so `/ingredient` is effectively reachable only by user 1. This
is a fail-closed bug (over-restrictive), not a bypass. The canonical per-entity view route
`/ingredient/{id}` correctly uses `view ingredient`.

## Autocreate caveat (not a permission bypass, but note it)

The `ingredient_autocomplete` widget autocreates ingredient entities for any user who can edit a
recipe node, regardless of the `add ingredient` permission — creation happens through core's
entity-reference autocreate on node save, not the `/ingredient/add` form. That is by design
(ingredients are lightweight name-only entities), but factor it in when reasoning about who can
create ingredient content.
