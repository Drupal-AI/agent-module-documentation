<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Seeds SEO — install & operate

Grounded in `seeds_seo.info.yml` and `composer.json`. There is no other source in the project
(only `README.md` and `LICENSE.txt` besides these two).

## Nature of the module
Seeds SEO is a **dependency aggregator / metapackage**. It contains no `.module`, `.install`,
`.routing.yml`, `.services.yml`, `.permissions.yml`, `src/`, `config/`, or `templates/`. Enabling it
has one effect: Drupal enables its declared dependencies. Disabling it does not disable those
dependencies.

## Install
```
composer require drupal/seeds_seo
drush en seeds_seo -y
```
`composer require` resolves the full `require` list in `composer.json`, downloading these projects
into the codebase (constraints as declared):

| Project | Constraint | In info.yml deps? |
|---|---|---|
| drupal/metatag | ^2.1 | yes (+ metatag_facebook, metatag_open_graph submodules) |
| drupal/pathauto | ^1.13 | yes |
| drupal/simple_sitemap | ^4.2 | yes |
| drupal/redirect | ^1.11 | yes |
| drupal/link_attributes | ^2.1 | yes |
| drupal/length_indicator | ^1.4 | yes |
| drupal/fast_404 | ^3.3 | no |
| drupal/google_analytics | ^4.0.3 | no |
| drupal/google_tag | ^2.0 | no |
| drupal/yoast_seo | ^2.1 | no |
| drupal/schema_metatag | ^2.6 \|\|^3.0 | no |
| drupal/ms_clarity | ^2.0 | no |
| drupal/linkchecker | ^2.1@alpha | no |

`drush en seeds_seo` enables **only** the info.yml dependency set: `metatag`, `metatag_facebook`,
`metatag_open_graph`, `simple_sitemap`, `redirect`, `pathauto`, `link_attributes`,
`length_indicator`. The composer-only projects (fast_404, google_analytics, google_tag, yoast_seo,
schema_metatag, ms_clarity, linkchecker) are present on disk but must be enabled individually,
e.g. `drush en yoast_seo -y`.

## Composer patches
`composer.json` `extra.patches` (requires `cweagans/composer-patches`, `enable-patching: true`)
applies one Drupal core patch (`#3293771` DateTime::createFromFormat) and three `yoast_seo` patches
(`#3504939`, `#3396294`, `#3010164`). These target dependencies, not Seeds SEO code.

## Configuration
Seeds SEO exposes **no settings route** (`configure` is null) and provides no config or schema.
Configure the SEO behaviour on each depended-on module's own admin pages, e.g.:
- Metatag: `/admin/config/search/metatag`
- Pathauto: `/admin/config/search/path/patterns`
- Simple Sitemap: `/admin/config/search/simplesitemap`
- Redirect: `/admin/config/search/redirect`

## Operating notes
- Use it as a one-shot to establish the SEO baseline, then configure each module.
- `core_version_requirement: ^10 || ^11`; `package: Seeds`.
- The composer `minimum-stability: dev` and `linkchecker:^2.1@alpha` mean the resolved set can
  include a non-stable release; pin as needed for production.
- Nothing here provides Drush commands, permissions, plugins, or services.
