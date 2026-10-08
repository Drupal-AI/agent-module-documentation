<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Recipe config translation (recipe_config_translation) — agent index

**Applies a recipe's `config/language/{langcode}/` overrides into the matching language config override collection whenever the recipe is applied.**

- **Version:** 1.0.x
- **Core:** ^10.6 || ^11.2
- **Routes / permissions:** none (no user-facing surface)
- **Services:** `recipe_config_translation.installer` (`installFromDirectory()`, `installAll()`), `recipe_config_translation.subscriber`
- **Event:** subscribes to `RecipeAppliedEvent` → `onRecipeApplied()`
- **Security:** no routes, permissions, or mutating endpoints; the installer runs only in the privileged recipe-apply / CLI context and reads config files shipped inside the recipe on disk; writes merge (non-destructive) and are scoped to installed languages.

See [api/backfill.md](api/backfill.md) for the installer service / update-hook usage.