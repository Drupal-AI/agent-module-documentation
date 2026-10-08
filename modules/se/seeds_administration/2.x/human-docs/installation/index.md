# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No third-party PHP libraries are required. As an aggregator, the module pulls in a
  curated set of administration modules when installed via Composer — review that set
  after installing (see below).

The project is **not covered by Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/seeds_administration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer download the bundled
administration modules and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/seeds_administration -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en seeds_administration -y
```

Enabling it brings up the curated administration stack. You can also enable it from
**Extend** (`/admin/modules`).

## After enabling — review the bundle

Because this is an opinionated bundle, take a moment to:

1. Open **Extend** (`/admin/modules`) and see which modules Seeds Administration
   enabled.
2. Visit each one's configuration page and confirm the defaults suit your site.
3. Disable anything you do not need.

There is no settings form for Seeds Administration itself — all configuration lives in
the individual modules it brought in.
