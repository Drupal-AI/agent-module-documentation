Submodule of MCP Tools that adds six Tool API plugins for listing, inspecting, validating, creating, and applying Drupal Recipes from an AI/MCP client.

---

`mcp_tools_recipes` exposes Drupal core's Recipe system (Drupal 10.3+) to MCP tooling. Read-only tools let an agent enumerate the recipes available from the site `recipes/` directory, core, and contrib modules, fetch a single recipe's modules/config/dependencies/files, list which recipes have already been applied, and validate a recipe (checking required fields, module availability, dependent recipes, and YAML validity) before running it. Two mutating tools — apply and create — are gated behind the admin scope: applying a recipe runs core's `RecipeRunner` (which can install modules and import configuration broadly), and creating a recipe writes a new `recipe.yml` into the site `recipes/` directory. All six are Tool API plugins extending `McpToolsToolBase` with category `recipes`, so they inherit the parent access model (`mcp_tools use recipes` permission, per-connection scope, config write policy, global read-only switch) on top of their own explicit admin-scope checks. The submodule ships two permissions and one service (`RecipesService`); it declares no config, routes, or forms.

---

- List every available recipe with name, label, description, type, source, and path (`mcp_recipes_list`).
- Discover recipes bundled by core and by installed contrib modules, not just site recipes.
- Inspect one recipe's `install` module list, config imports/actions, recipe dependencies, and files (`mcp_recipes_get`).
- Validate a recipe before applying it — catch missing modules, unknown dependent recipes, and malformed config YAML (`mcp_recipes_validate`).
- See the warnings for modules that are available but not yet enabled (they will be installed).
- List the recipes already applied to this site, with who applied them and when (`mcp_recipes_applied`).
- Apply a vetted recipe to configure a site in one step, from an admin-scoped connection (`mcp_recipes_apply`).
- Have an agent apply a "blog", "editorial workflow", or "SEO starter" recipe on request.
- Scaffold a brand-new recipe (`recipe.yml` with name/description/type/install/config) from a description (`mcp_recipes_create`).
- Generate a recipe that bundles a set of modules to install plus config to import.
- Capture a site-building convention as a reusable recipe for other environments.
- Pre-flight a recipe on staging: validate, review the file list, then apply.
- Refuse to apply a recipe that fails validation (apply validates first and aborts on errors).
- Track recipe application history in state for auditing.
- Let an agent explain what a recipe will change (modules + config) before the human approves applying it.
- Bootstrap a demo/QA site from a stored recipe.
- Keep recipe apply/create restricted to admin-scoped connections while leaving discovery read-only.
- Fall back to a suggested `drush recipe <path>` command when the core RecipeRunner class is unavailable.
