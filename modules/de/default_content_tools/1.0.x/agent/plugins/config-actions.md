<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config actions — mark/unmark a recipe's content for deletion

Two core-style **config action** plugins (`src/Plugin/ConfigAction/`) edit the
`delete_recipes` sequence in `default_content_tools.settings`. Both are marked `@internal` /
"experimental" in source. They implement `ConfigActionPluginInterface` +
`ContainerFactoryPluginInterface`, injecting `@Drupal\Core\Config\ConfigFactoryInterface`.

A recipe invokes them under `config:` `actions:` on the `default_content_tools.settings` config
name, passing a recipe machine name as the value.

## `markRecipeContentForDeletion`

Class `MarkRecipeContentForDeletion`, `#[ConfigAction(id: 'markRecipeContentForDeletion', ...)]`.
`apply($configName, $value)` requires a non-empty string (throws `ConfigActionException`
otherwise), then appends `$value` to `delete_recipes` **only if not already present** (`in_array`
strict) and saves. Additive by design: several composed recipes can each mark their own entry
without a plain `simpleConfigUpdate` on the whole list clobbering what another layer marked.

```yaml
# in a recipe's recipe.yml
config:
  actions:
    default_content_tools.settings:
      markRecipeContentForDeletion: my_demo_catalogue
```

## `unmarkRecipeContentForDeletion`

Class `UnmarkRecipeContentForDeletion`, id `unmarkRecipeContentForDeletion`. `apply()` also
requires a non-empty string; it removes every entry equal to `$value`
(`array_filter` + `array_values`) and saves **only if** the list actually changed. Lets a later
recipe layer keep content a previously-applied recipe had marked for deletion.

```yaml
config:
  actions:
    default_content_tools.settings:
      unmarkRecipeContentForDeletion: my_demo_catalogue
```

## How this ties into deletion

Marking a recipe here is what the `RecipeContentCleanup` and (with `recipe_tracker`)
`RecipeTrackerCatchup` subscribers act on — see [../api/deletion.md](../api/deletion.md). The
config actions only change the list; the actual entity deletion happens when a
`RecipeAppliedEvent` fires and the recipe's machine name is found in `delete_recipes`.
