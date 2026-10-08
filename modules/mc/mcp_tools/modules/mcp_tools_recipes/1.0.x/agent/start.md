<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Recipes (mcp_tools_recipes) — agent index

Submodule of **mcp_tools**. Adds six Tool API plugins wrapping Drupal core's Recipe system
(Drupal 10.3+). Installed release **1.0.0-beta8** (version dir `1.0.x`).
Core `^10.3 || ^11 || ^12`. License GPL-2.0-or-later. Package *MCP*.
Depends only on `mcp_tools:mcp_tools`. No config objects, routes, or forms of its own.

- **The six tools, scopes, path handling, and the RecipesService** → [tools/recipes-tools.md](tools/recipes-tools.md)

## What it is

Each tool extends `Drupal\mcp_tools\Tool\McpToolsToolBase` (const `MCP_CATEGORY = 'recipes'`) under
`src/Plugin/tool/Tool/`, delegating to one service, `RecipesService` (`mcp_tools_recipes.recipes`).
Base `checkAccess()` requires `mcp_tools use recipes` + the operation's scope + read-only off; the two
mutating tools additionally verify admin scope explicitly.

## Tools (6)

| id | class | op | what |
|----|-------|----|------|
| `mcp_recipes_list` | `ListRecipes` | Read | list recipes from site/core/contrib |
| `mcp_recipes_get` | `GetRecipe` | Read | one recipe's modules/config/deps/files |
| `mcp_recipes_validate` | `ValidateRecipe` | Read | validate before applying |
| `mcp_recipes_applied` | `GetAppliedRecipes` | Read | recipes already applied (from state) |
| `mcp_recipes_apply` | `ApplyRecipe` | Trigger | run `RecipeRunner` — installs modules / imports config (**admin**) |
| `mcp_recipes_create` | `CreateRecipe` | Trigger | write a new `recipe.yml` to `recipes/` (**admin**) |

## Service (`mcp_tools_recipes.services.yml`)

- `mcp_tools_recipes.recipes` — `RecipesService`: `listRecipes`, `getRecipe`, `validateRecipe`,
  `applyRecipe`, `getAppliedRecipes`, `createRecipe`. Uses `config.factory`, `extension.list.module`,
  `file_system`, `%app.root%`, `mcp_tools.access_manager`, `mcp_tools.audit_logger`, `state`,
  `current_user`, and a dedicated logger channel. Applied recipes tracked under state key
  `mcp_tools_recipes.applied`.

Permissions (`mcp_tools_recipes.permissions.yml`, both `restrict access: true`):
`mcp_tools use recipes`, `mcp_tools administer recipes`.
