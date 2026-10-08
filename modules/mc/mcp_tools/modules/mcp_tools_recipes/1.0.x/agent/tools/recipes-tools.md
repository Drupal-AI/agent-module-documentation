<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# mcp_tools_recipes — tools reference

All plugins live in `src/Plugin/tool/Tool/`, extend `McpToolsToolBase` with
`MCP_CATEGORY = 'recipes'`, and delegate to `RecipesService` (`mcp_tools_recipes.recipes`). Base
`checkAccess()`: permission `mcp_tools use recipes` + scope for the operation + read-only off.

## Tool table

| Tool id | Class | Operation → scope | Inputs | Returns |
|---------|-------|-------------------|--------|---------|
| `mcp_recipes_list` | `ListRecipes` | Read → read | — | `recipes` (name/label/description/type/source/path), `count`, `sources` |
| `mcp_recipes_get` | `GetRecipe` | Read → read | `recipe_name` (req) | `label`, `description`, `type`, `path`, `install`, `config` (import+actions), `recipes`, `files` |
| `mcp_recipes_validate` | `ValidateRecipe` | Read → read | `recipe_name` (req) | `valid` (bool), `errors`, `warnings`, `message` |
| `mcp_recipes_applied` | `GetAppliedRecipes` | Read → read | — | `recipes` (name/path/applied_at/applied_by), `count` |
| `mcp_recipes_apply` | `ApplyRecipe` | Trigger → **admin** | `recipe_name` (req) | `recipe`, `path`, `message` |
| `mcp_recipes_create` | `CreateRecipe` | Trigger → **admin** | `name` (req), `description` (req), `label`, `type`, `install` (list), `recipes` (list), `config` (map) | `name`, `path`, `message` |

## Behaviour notes (from `RecipesService`)

- **Recipe sources** (`getRecipeDirectories()`): `%app.root%/recipes` (site), `%app.root%/core/recipes`,
  and every installed module's `recipes/` dir. `isRecipesSupported()` requires Drupal >= 10.3.
- **`mcp_recipes_apply`** enforces admin twice: the plugin op is `Trigger` (base → admin scope) AND
  `ApplyRecipe::executeLegacy()` calls `checkAdminAccess()` (WriteAccessTrait) AND
  `RecipesService::applyRecipe()` re-checks `accessManager->canAdmin()`. It then **validates first**
  and aborts on validation errors, loads the recipe via `Recipe::createFromDirectory()`, runs
  `RecipeRunner::processRecipe()`, tracks it in state, and audit-logs. If `RecipeRunner` is missing it
  returns a suggested `drush recipe <path>` command instead of failing silently.
- **`mcp_recipes_create`** re-checks `canAdmin()`, enforces a machine-name regex
  (`/^[a-z][a-z0-9_]*$/`) on `name`, refuses to overwrite an existing recipe dir, and validates any
  `config_files` filenames against `/^[a-zA-Z0-9_\-\.]+\.yml$/` + a `..` check before writing.
- **Recipe resolution** (`findRecipe()`): a plain `recipe_name` is looked up within the known recipe
  directories; an absolute path is `realpath()`-canonicalised and accepted only when it resolves
  inside a known recipe directory or the Drupal root, and only when it contains a `recipe.yml`. So the
  tools operate on real recipe directories under the Drupal root.

## Operating it

1. `drush en mcp_tools_recipes -y` (parent `mcp_tools` enabled; Drupal 10.3+ for Recipe support).
2. Grant `mcp_tools use recipes` (+ `mcp_tools administer recipes`) to the execution user; the apply
   and create tools also require the connection to hold the **admin** scope and read-only mode off.
3. Discover → `mcp_recipes_list`; inspect → `mcp_recipes_get`; validate → `mcp_recipes_validate`;
   apply → `mcp_recipes_apply`; author new → `mcp_recipes_create`.
