<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Commands are defined as Symfony Console commands under `src/Drush/Commands` and autowired.
Only `site:export` and the `--generic` option are `@api` (stable); the rest are `@internal`
and hidden.

## `site:export` (aliases `siex`, `six`) — `@api`

Exports the running site's configuration and content as a `Site`-type recipe.

```
drush site:export --destination=/path/to/recipe
```

Options:
- `--destination=<dir>` — where to write the recipe. Defaults to the Composer recipe
  ("cookbook") path for `drupal/site_export` if one can be determined; if empty and none can
  be resolved, the command errors.
- `--overwrite` — allow writing into an existing destination directory (otherwise errors if
  it exists).
- `--base=<dir>` — path of a base recipe to build on. Its files (except `config/`,
  `content/`, `recipe.yml`) are copied first, `*.example` files are un-suffixed, then the
  site's own config/content is regenerated over the top. Defaults to
  `drupal/drupal_cms_site_template_base` if installed.
- `--dev` — export in development mode: enables `themeDevelopmentMode` instead of forcing CSS/JS
  aggregation on.

What it writes to the destination: `recipe.yml` (with `type: Site`, an `install:` list of all
installed modules/themes, and a `config: { strict: false, actions: {...} }` section),
`composer.json` (`type: drupal-recipe`, `require` computed from installed extensions),
a `config/` tree, and a `content/` tree of exported default content. Config that ships with
core, System and User is emitted as **config actions** (`setProperties` / `simpleConfigUpdate`)
rather than files, because those modules are guaranteed present when the recipe is applied.
Site name and mail, `core.extension`, path aliases, redirects and a few internal entity types
are deliberately excluded. Export throws if any `canvas.*` config has content dependencies.

## `config:export --generic` — `@api` option

This module adds a `--generic` flag to core's `config:export`. With it, every exported config
object has its `_core` and `uuid` keys removed (except config entities whose ID *is* the UUID,
e.g. Canvas folders), producing recipe-ready output.

```
drush config:export --destination=/path/to/dir --generic
```

## Internal / hidden commands

- `content:export:all <dir>` (`@api`, hidden) — exports all content entities (with
  dependencies) to `<dir>` as default-content files. Skips `path_alias`, `redirect`,
  `search_api_task`, `easy_email`, internal entity types, and users 0/1.
- `content:import <dir>` (`@api`, hidden; aliases `contim`, `cti`) — imports default-content
  files from `<dir>`. `--skip-existing` (`-s`) skips entities whose UUID already exists
  (default is to error on conflict).
- `site:archive [archive]` (hidden; aliases `siar`, `sia`) — archives config, content and the
  project `composer.json`/`composer.lock` into a ZIP (default `drupal.zip`). `--db-type=<driver>`
  rewrites the DB driver recorded in `core.extension`.
