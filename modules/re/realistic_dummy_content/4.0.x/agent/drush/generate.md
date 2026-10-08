# Drush command and recipes

## The command

`realistic_dummy_content_api:generate-realistic` — aliases **`generate-realistic`** and **`grc`**.

- Defined in `api/src/DrushCommands/RealisticDummyContentDrushCommands.php::generateRealistic()`,
  registered as the Drush service `realistic_dummy_content_api.drush_commands` in the project-root
  `drush.services.yml` (`composer.json` pins `drush.services.yml` to Drush `^9`). A legacy Drush <9
  shim exists in `api/realistic_dummy_content_api.drush.inc`.
- Takes **no arguments/options**. It runs `realistic_dummy_content_api_apply_recipe(new
  RealisticDummyContentDrushLog())`, which calls `RealisticDummyContentRecipe::run($log)`.

```bash
ddev drush generate-realistic     # or: ddev drush grc
```

This does **not** by itself generate the plain devel content — it discovers and runs every module's
**recipe** (see below). Recipes are what invoke `devel_generate`; the realistic replacement of
values then happens automatically in `hook_entity_presave` (see [../api/extend.md](../api/extend.md)).

To just get realistic content without a recipe, run Devel's own generator (e.g.
`ddev drush devel-generate-content` / `devel-generate-users`) with both modules enabled — the
`entity_presave` hook rewrites the generated fields from your file directories.

## Recipes — scripted, ordered generation

A recipe generates a fixed set of entities in a defined order (e.g. "4 pages, then 10 articles").
`RealisticDummyContentRecipe::run()` (`api/src/includes/RealisticDummyContentRecipe.php:33`) scans
**every enabled module** for
`{module}/realistic_dummy_content/recipe/{module}.recipe.inc` and instantiates the class
`{module}_realistic_dummy_content_recipe` if it exists, then calls its `_Run_()`.

Requirements enforced by the loader (`loadRecipeClass()`):

- The `.inc` file must contain `use Drupal\realistic_dummy_content_api\includes\RealisticDummyContentRecipe;`
  (a 2.x-era guard — an older file without it throws an exception).
- The class name must be exactly `{module}_realistic_dummy_content_recipe`.

Author a recipe (mirror the bundled example at
`realistic_dummy_content/realistic_dummy_content/recipe/realistic_dummy_content.recipe.inc`):

```php
use Drupal\realistic_dummy_content_api\includes\RealisticDummyContentRecipe;

class mymodule_realistic_dummy_content_recipe extends RealisticDummyContentRecipe {
  public function _Run_() {
    $this->NewEntities('node', 'page', 4, ['kill' => TRUE]);
    $this->NewEntities('node', 'article', 10, ['kill' => TRUE]);
  }
}
```

- `NewEntities($type, $bundle, $count, $more)` routes to
  `RealisticDummyContentDevelGenerateGenerator`, which calls `devel_generate` — so **`devel_generate`
  must be enabled**, and **only `user` and `node` entity types are supported** (anything else logs an
  error). `['kill' => TRUE]` deletes existing entities of that bundle first.
- For **deterministic** output in a recipe or test, set the config toggle falsy before generating —
  `\Drupal::configFactory()->getEditable('realistic_dummy_content_api')->set('realistic_dummy_content_api_rand', 0)->save();`
  (see the random/sequential section in [../api/extend.md](../api/extend.md)).
- The generator adds `max_comments => 5` when the `comment` module is enabled, uses uid 1 as the node
  author, and `title_length => 3` (`RealisticDummyContentDevelGenerateGenerator.php`).

Logging goes through `RealisticDummyContentDrushLog` (a `RealisticDummyContentLogInterface`); the run
reports elapsed milliseconds per bundle and in total.
