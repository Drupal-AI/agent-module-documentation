# Search setup: server, recipe, cron

Varbase Search has no settings form. Everything is applied at install time by the module's
`hook_install()` running the bundled recipe, plus two shipped config files.

## What happens at install
`varbase_search.install`:
```php
function varbase_search_install() {
  $default_recipe = Recipe::createFromDirectory(__DIR__ . '/recipes/default');
  RecipeRunner::processRecipe($default_recipe);
}
```
The recipe `recipes/default/recipe.yml` (type `install`):

| Step | Value |
|------|-------|
| Installs modules | `search`, `search_api`, `search_api_db` |
| Imports config | `search: '*'`, `search_api: '*'`, `search_api_db: '*'`, and this module's `search_api.server.database_server` + `ultimate_cron.job.search_api_cron` |
| Grants permission | `search content` → `user.role.anonymous` and `user.role.authenticated` |

`varbase_search_update_90001()` (in `includes/updates/v9.inc`) calls
`ModuleInstallerFactory::setModuleWeightAfterInstallation('varbase_search')` so the module's hooks
run after the modules it configures.

## The shipped search server
`config/optional/search_api.server.database_server.yml` — a Search API server backed by the site
database (`search_api_db`). Being in `config/optional/`, it is only imported when its dependency
module (`search_api_db`) is present, so the module degrades instead of failing.

| Key | Value |
|-----|-------|
| `id` | `database_server` |
| `name` | `Database server` |
| `backend` | `search_api_db` |
| `backend_config.database` | `default:default` |
| `backend_config.min_chars` | `3` (minimum indexed token length) |
| `backend_config.matching` | `partial` |
| `backend_config.autocomplete.suggest_suffix` | `true` |
| `backend_config.autocomplete.suggest_words` | `true` |

To move the site to a different backend (e.g. Solr), edit or replace this server config; the
`content` index (provided by the distribution) points its `server:` at `database_server`.

## Cron indexing
`config/optional/ultimate_cron.job.search_api_cron.yml` defines an Ultimate Cron job
`search_api_cron` (callback `search_api_cron`, simple scheduler, serial launcher, database logger).
It is optional config — applied only if `ultimate_cron` is installed. Without Ultimate Cron,
Search API indexes on normal Drupal cron. The distribution index sets `index_directly: true` and
`cron_limit: 50`.

## Operating it via drush / PHP
```bash
# Rebuild / re-index the content index after config or content changes:
drush search-api:reset-tracker content
drush search-api:index content
drush search-api:status
```
```php
// Read the shipped server config:
$server = \Drupal::config('search_api.server.database_server')->get('backend_config');
```

## Note on shipped config
This module's own `config/install/` is empty (`README.md` says "Moved to optional"); the search
`content` index and the `search_content` view are provided by the Varbase distribution and are
mirrored in the `tests/varbase_search_test/` fixture — see
[../views/search_content.md](../views/search_content.md). The module does not define config schema
of its own; the schema for `search_api.server.*` and `ultimate_cron.job.*` comes from those modules.
