# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- Core's **Layout Builder** (`layout_builder`) and **Views** (`views`) modules —
  pulled in and enabled automatically as dependencies.
- The **laminas/laminas-feed** PHP library (`^2.17`), used by the RSS feed widget —
  installed automatically by Composer.

### Optional, but useful

The project suggests several modules that unlock extra widgets or capabilities:

- [Layout Builder Restrictions](https://www.drupal.org/project/layout_builder_restrictions)
  — control which blocks and layouts editors may use on a dashboard.
- [Matomo](https://www.drupal.org/project/matomo) and
  [Matomo Reporting API](https://www.drupal.org/project/matomo_reporting_api) — for
  the analytics widgets.
- [Webform](https://www.drupal.org/project/webform) — for the webform submission
  widgets.
- Core **Statistics** — for the content‑view‑count widgets.

## Install with Composer

From the project root:

```bash
composer require drupal/dashboards -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install laminas‑feed and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dashboards -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dashboards -y
```

## Submodules — enable only what you need

Dashboards ships five optional submodules, each adding widgets. Enable them
individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Comments** | `dashboards_comments` | Comment activity widgets. |
| **Matomo** | `dashboards_matomo` | Matomo analytics widgets (visitors, top URLs, countries, browsers, OS). Needs the Matomo modules. |
| **Statistic** | `dashboards_statistic` | Content view‑count / node statistics widgets. |
| **Views** | `dashboards_views` | Widgets driven by Views. |
| **Webform** | `dashboards_webform` | Webform submission‑trend widgets. |

For example:

```bash
drush en dashboards_statistic -y
```

## After enabling

Grant the **Administer dashboards** permission to the roles that will create
dashboards, then build your first one at **Structure → Dashboards** — see
[Configuration](../configuration/index.md).
