# Installation

> **Before you install:** the maintainers state that this project was **not
> designed to install on your own site.** For live ecosystem data use the hosted
> dashboard at `https://dev.acquia.com/drupal11/deprecation_status/projects`, and
> for your own site's upgrade readiness use the
> [Upgrade Status](https://www.drupal.org/project/upgrade_status) module. Only
> install this module locally if you specifically need to run the analysis
> tooling yourself.

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **File** module (`file`), which Drupal enables automatically as a
  dependency.

There are no third-party Composer or PHP library requirements. This project is
**not covered by Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/deprecation_status -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/deprecation_status -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en deprecation_status -y
```

## Verify it worked

Because this module is a developer/analysis tool rather than a site feature, there
is no settings page to confirm. Refer to the project's own documentation for how to
run and view its reports, and remember the hosted dashboard is the recommended way
to consume the data.
