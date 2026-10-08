# Installation

## Requirements

- **Drupal 9 or newer** (`core_version_requirement: >=9`).
- An **Ahrefs account** with a Web Analytics project, so you have an analytics
  key to enter.

This module is not part of the Drupal AI ecosystem and has no AI provider or
third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ahrefs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ahrefs -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ahrefs -y
```

## Next step

Enter your Ahrefs analytics key on the module's settings form — see
[How to use it](../index.md#how-to-use-it). Until the key is set, the tracking
snippet has nothing to report with.
