# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`). WebProfiler is tightly bound to
  the Symfony version in core, so you must use the matching major: use the 11.x
  branch for Drupal 11 (there are separate 9.x and 10.x branches for older cores).
- **PHP 8.3 or newer**.
- The **Devel** module (`drupal/devel` `^5.0`) and the **Tracer** module
  (`drupal/tracer` `^1.2`) — both installed automatically by Composer.
- Several PHP libraries pulled in by Composer: `league/commonmark`,
  `nikic/php-parser`, `scrivo/highlight.php`, `symfony/stopwatch`, and
  `symfony/var-dumper`.
- *Optional:* `symfony/messenger` enables the Messenger panel.

## Install with Composer

From the project root:

```bash
composer require drupal/webprofiler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it brings in Devel, Tracer, and the required
libraries. Because it's a development tool, many teams add it with
`composer require --dev`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/webprofiler -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webprofiler -y
```

Enabling WebProfiler also enables Devel and Tracer if they aren't already on. The
toolbar appears immediately on HTML pages for users with the right permission.

> **Do not enable WebProfiler in production.** It instruments and replaces several
> core subsystems to collect its data, adding overhead and exposing internal
> details. Keep it to local and staging environments.

## Verify it worked

Load any front-end page while logged in as an administrator — you should see the
WebProfiler toolbar pinned to the bottom of the page. Click a segment to open the
full profile, or go straight to **Reports → Profiler**
(`/admin/reports/profiler`). If you don't see the toolbar, check that your user
has the `view webprofiler toolbar` permission and that the page isn't on an
excluded path.

Next, see [Configuration](../configuration/index.md) to tune which collectors
appear, exclude noisy paths, and turn on optional time metrics.
