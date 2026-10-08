<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Seeds Performance — install & operate

Grounded in `seeds_performance.info.yml` and `composer.json`. There is no other source in the
project besides `README.md`, `LICENSE.txt`, and an empty `seeds_performance.module` (a `@file`
docblock with no hooks).

## Nature of the module
Seeds Performance is a **dependency aggregator / metapackage**. It contains no `.install`,
`.routing.yml`, `.services.yml`, `.permissions.yml`, `src/`, `config/`, or `templates/`. Its
`.module` file defines no functions. Enabling it has one effect: Drupal enables its declared
dependencies. Disabling it does not disable those dependencies.

## Install
```
composer require drupal/seeds_performance
drush en seeds_performance -y
```
`composer require` resolves the full `require` list in `composer.json`, downloading these projects
into the codebase (constraints as declared):

| Project | Constraint | In info.yml deps (auto-enabled)? |
|---|---|---|
| drupal/webp | ^1.0@RC | yes |
| drupal/ultimate_cron | ^2.0@alpha | yes |
| drupal/minifyhtml | ^2.0 | no — present on disk, enable manually |

`drush en seeds_performance` enables **only** the info.yml dependency set: `webp` and
`ultimate_cron`. The composer-only project `minifyhtml` is present on disk but must be enabled
individually: `drush en minifyhtml -y`.

## Composer patches & stability
`composer.json` sets `minimum-stability: dev` and `enable-patching: true`, and under
`extra.patches` applies one patch to `drupal/webp` (issue #3450918 — duplicate WebP rendering when
originals share a name but differ in extension). The patch targets a dependency, not Seeds
Performance code. The `@RC` / `@alpha` constraints mean the resolved set can include non-stable
releases; pin as needed for production.

## Configuration
Seeds Performance exposes **no settings route** (`configure` is null) and provides no config or
schema. Configure performance behaviour on each depended-on module's own admin pages, e.g.:
- WebP: `/admin/config/media/webp`
- Ultimate Cron: `/admin/config/system/cron/jobs`
- MinifyHTML (if enabled): `/admin/config/development/performance` (its settings integrate there)

## Operating notes
- Use it as a one-shot to establish the performance baseline, then configure each module.
- `core_version_requirement: ^9 || ^10 || ^11`; `package: Seeds`.
- Nothing here provides Drush commands, permissions, plugins, config, or services.
