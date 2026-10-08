# Installation

> **Development only.** This module exposes an admin route that runs benchmark
> work hundreds of times against the live database. Install it in development or
> staging, not on a production site.

## Requirements

- **Drupal 10.3+ or Drupal 11** (`core_version_requirement: ^10 || ^11`,
  minimum 10.3).
- Core's **Help** (`help`) and **User** (`user`) modules — enabled as
  dependencies. (User is used by the bundled example scenario.)
- No contributed modules or external libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/code_benchmarker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/code_benchmarker -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en code_benchmarker -y
```

## Verify it worked

Log in as a user with **Administer site configuration** and open **Configuration
→ Development → Code benchmarker** (`/admin/config/development/code-benchmarker`).
The dashboard should list the bundled example scenario. Clicking a scenario runs
it — see the "How to use it" section of the [guide](../index.md). When you are
done measuring, disable the module so the benchmark route is not left exposed.
