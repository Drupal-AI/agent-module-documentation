<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Seeds Performance (seeds_performance) — agent index

Metapackage / starter module from the **Seeds** distribution. Installed version 1.0.5 (dir label
`1.x`). Ships **only** `seeds_performance.info.yml`, `composer.json`, `README.md`, `LICENSE.txt`,
and an **empty** `seeds_performance.module` (just a `@file` docblock — no hooks). **No `src/`, no
routes, no services, no config, no schema, no permissions.** Its sole function is to declare
dependencies so that enabling it turns on a curated performance stack.

## What enabling it does
`info.yml` `dependencies:` (auto-enabled with the module):
- `webp:webp` — generates/serves WebP derivatives of image styles
- `ultimate_cron:ultimate_cron` — per-job cron scheduling and control

`composer.json` `require` (pulled into the codebase; `minifyhtml` is **not** in info.yml, so it is
present on disk but enabled individually as needed):
- `drupal/webp` `^1.0@RC`
- `drupal/minifyhtml` `^2.0` — collapses/minifies rendered HTML output
- `drupal/ultimate_cron` `^2.0@alpha`

Note `composer.json` also carries a `drupal/webp` patch under `extra.patches` (issue #3450918) and
sets `minimum-stability: dev`.

## Entities / plugins / routes / services
None. All behaviour, configuration, and any security surface belong to the depended-on modules; this
project provides nothing of its own to configure. `configure` is null. Despite the README's phrasing
("providing its configurations"), there is no `config/` directory on disk.

## Solution docs
- [agent/config/install.md](config/install.md) — install/enable, the dependency set, how to operate.

`core_version_requirement: ^9 || ^10 || ^11`. `package: Seeds`. License GPL-2.0-or-later.
