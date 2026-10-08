<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Backfilling recipe language overrides

The `RecipeAppliedEvent` only fires when a recipe is applied. To apply overrides for a recipe
that was already applied before this module was installed, call the installer service once,
normally from a `hook_update_N()`.

```php
/** @var \Drupal\recipe_config_translation\RecipeConfigTranslationInstaller $installer */
$installer = \Drupal::service('recipe_config_translation.installer');

// A single recipe directory (full path):
$count = $installer->installFromDirectory('/path/to/recipes/my_recipe');

// Or every top-level recipe under ../recipes (relative to the Drupal root):
$count = $installer->installAll();
```

## What it does
- Reads `{recipe}/config/language/{langcode}/*.yml` via a core `FileStorage`.
- Skips any `{langcode}` whose language is not installed.
- For each config object, loads the `language.{langcode}` override, merges the file data on top
  with `array_replace_recursive`, and saves — existing overrides are preserved.
- Returns the number of config overrides written.

Re-running is safe (idempotent): the same values are simply re-merged.
