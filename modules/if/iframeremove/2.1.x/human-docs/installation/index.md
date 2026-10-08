# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).

There are no module dependencies and no third-party Composer or PHP libraries. The
filter builds on core's Filter framework, which is part of every Drupal install.

## Install with Composer

From the project root:

```bash
composer require drupal/iframeremove -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/iframeremove -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en iframeremove -y
```

## After enabling

Enabling the module makes the filter *available* but does not turn it on anywhere.
You still have to enable it on each text format and set its whitelist — see the
[overview](../index.md#how-to-use-it) for the step-by-step.
