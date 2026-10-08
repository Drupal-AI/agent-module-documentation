# Installation

## Requirements

Stenographer needs:

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **Toolshed** module (`toolshed`), which Composer pulls in as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root — this also fetches the Toolshed dependency:

```bash
composer require drupal/stenographer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/stenographer -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en stenographer -y
```

## After installing

Stenographer does nothing until you define recorders. There is no admin form —
instead, add a `<your_module>.stenographer.yml` file to one of your own modules
(start from the shipped `example.stenographer.yml`), define the recorders you need,
and run `drush cr` so the definitions are discovered. See the
[main guide](../index.md) for how recorders are structured.
