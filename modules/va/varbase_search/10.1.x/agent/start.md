<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Varbase Search (varbase_search) — agent index

A Varbase distribution feature that preconfigures **Search API** for a site: it ships a
database search **server**, an Ultimate Cron job for indexing, and an install **recipe** that
enables the core `search` + `search_api` + `search_api_db` stack and grants the `search content`
permission to anonymous and authenticated users. It also auto-builds a `search_result` node
view-mode display when a content type opts in.

- No settings page (`configure` is null). Config-and-recipe module; the only PHP is one hook and
  the install hook.
- `core_version_requirement: ~11.4.0`. Composer: `drupal/core ~11.4.0`,
  `drupal/search_api ~1`, `vardot/module-installer-factory ~1`. `info.yml` declares no module
  dependencies — the search stack is pulled in by the recipe at install time.
- Defines no permissions, no drush commands, no plugin types, no config schema of its own.

## Solution docs
- **The shipped search server, the install recipe, cron indexing, how to change the backend** → [configure/search-setup.md](configure/search-setup.md)
- **The auto-generated `search_result` node view-mode display (the form hook + template)** → [hooks/search_result_view_mode.md](hooks/search_result_view_mode.md)
- **The `search_content` search view (page at `/search`, exposed keyword filter, node-access behavior)** → [views/search_content.md](views/search_content.md)
- **The search box / exposed-filter block and its Olivero placement** → [blocks/search_box.md](blocks/search_box.md)

## Key facts (real machine names)
- Install: `varbase_search_install()` runs `recipes/default` via `Recipe::createFromDirectory()` +
  `RecipeRunner::processRecipe()`.
- Recipe `recipes/default/recipe.yml`: installs modules `search`, `search_api`, `search_api_db`;
  grants permission `search content` to `user.role.anonymous` and `user.role.authenticated`.
- Search server config: `search_api.server.database_server` (id `database_server`, backend
  `search_api_db`, database `default:default`, `min_chars: 3`, `matching: partial`). Shipped in
  `config/optional/`.
- Cron job config: `ultimate_cron.job.search_api_cron` (callback `search_api_cron`) — optional
  config, applies only if `ultimate_cron` is installed.
- Hook class `Drupal\varbase_search\Hook\VarbaseSearchHooks` implements
  `form_entity_view_display_edit_form_alter`; template at
  `src/assets/config_templates/CONTENT_TYPE_NAME/core.entity_view_display.node.CONTENT_TYPE_NAME.search_result.yml`.
- The concrete `content` Search API index, the `search_content` view (`/search`) and the search
  block live in the `tests/varbase_search_test/` recipe/fixture here and are provided by the
  Varbase distribution at the site level — they are NOT in this module's own `config/install`.
- Update `varbase_search_update_90001` sets module weight after install (`ModuleInstallerFactory`).
