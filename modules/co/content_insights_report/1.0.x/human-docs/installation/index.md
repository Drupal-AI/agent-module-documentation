# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No required contrib dependencies and no third‑party PHP or JavaScript
  libraries.
- **Optional:** the [Group](https://www.drupal.org/project/group) module, if you
  want per‑group reporting via this module's Group submodule.

## Install with Composer

From the project root:

```bash
composer require drupal/content_insights_report -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_insights_report -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_insights_report -y
```

## Submodule — Group reporting

The project ships a submodule that extends reporting to the **Group** module, so
you can generate a report for an individual group. Enable it only if you use Group
and want per‑group reports:

```bash
drush en content_insights_report_group -y
```

It adds a **Content Insights Report Group Settings** page
(`/admin/config/content/content_insights_report_group/settings`) and per‑group
reporting under the Groups area.

## Verify it worked

Go to **Reports → Content Insights Report**
(`/admin/reports/content-insights-report`) and confirm the report page loads. Then
visit the settings form (see [Configuration](../configuration/index.md)) to tune
the reporting period before you rely on the figures.

> **Before running on production:** analysing all content can be expensive on a
> large site. Check whether the report runs as a batch/cron job rather than a
> live page load, and confirm who is allowed to view it — it aggregates content
> some viewers may not otherwise be able to access.
