# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`) — this branch targets core 11.2,
  and relies on core's **Single Directory Components** support.

There are no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/gov_cz -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gov_cz -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gov_cz -y
```

## Verify it worked

Load a front-end page. You should see the gov.cz fonts and colours applied — that
confirms the module's libraries are loading. To make full use of the components,
integrate the SDC components into your theme, as described in the main
[guide](../index.md).
