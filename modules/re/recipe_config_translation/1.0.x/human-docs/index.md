# Recipe config translation — manual setup guide

**Recipe config translation** (`recipe_config_translation`) fills a gap in
Drupal's recipe system: recipes can install configuration, but they cannot yet
apply *per-language* config overrides (translated config values). On a
multilingual site that means recipe-provided strings — a site name, a label, a
setting — arrive in one language and stay that way after the recipe runs. This
module makes those translations land automatically.

The way it works is refreshingly simple. A recipe author ships plain YAML files
inside the recipe at `{recipe}/config/language/{langcode}/{config_name}.yml`,
each holding only the keys that differ for that language. Every time the recipe
is applied — a fresh site install, `drush recipe`, Package Manager, or Project
Browser — the module listens for core's `RecipeAppliedEvent` and writes those
overrides into the matching `language.{langcode}` config override collection.

There is **nothing to configure**. You enable the module, and from then on any
recipe that carries language files has its translations applied on every
apply path. The writes are scoped to the languages actually installed on the
site (a langcode directory for an uninstalled language is skipped) and they are
idempotent — overrides merge on top of what is already there, so re-applying a
recipe is always safe.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form and
adds no admin menu items. Everything happens automatically when a recipe is
applied. The only "setup" is on the recipe side, described in "How to use it"
below.

## How to use it

The module is aimed at **recipe authors**. To ship translated config with a
recipe:

1. Inside your recipe, add a language file for each config object you want to
   translate, at the path `config/language/{langcode}/{config_name}.yml`. For
   example, a German site name lives at `config/language/de/system.site.yml`:

   ```yaml
   name: 'Mein Name'
   ```

   Include **only** the keys that differ for that language — the file is an
   override, not a full copy.

2. Make sure the target language is installed on the site. The module only
   applies overrides for languages that actually exist; a file for an
   uninstalled language is quietly skipped.

3. Apply the recipe as normal. On every apply path — fresh install, `drush
   recipe`, Package Manager, Project Browser — the overrides are written into
   that language's config override collection. If your recipe pulls in nested
   recipes, each one's language files are applied in turn.

### Backfilling recipes applied before you installed this module

If a recipe was already applied before this module was enabled, its translations
were never written. To backfill them, call the module's installer service once
from a custom module's `hook_update_N()` — `recipe_config_translation.installer`
provides `installFromDirectory()` (for a single recipe) and `installAll()` (for
every top-level recipe under the site's `recipes` directory).
