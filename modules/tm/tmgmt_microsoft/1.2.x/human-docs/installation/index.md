# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Translation Management Tool** module (`tmgmt`) — this module is a TMGMT
  translator plugin and cannot work without it.
- A **Microsoft Azure Cognitive Services Translator** subscription and its API key
  (the service is paid).

There are no additional third-party Composer or PHP library requirements — the
plugin talks to Azure over HTTP using Drupal's built-in HTTP client.

## Install with Composer

From the project root:

```bash
composer require drupal/tmgmt_microsoft -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If TMGMT is not yet in your project, add it too:

```bash
composer require drupal/tmgmt drupal/tmgmt_microsoft -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tmgmt_microsoft -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tmgmt_microsoft -y
```

TMGMT is required and must be enabled (Drush will enable it as a dependency if it is
installed). There is a `tmgmt_microsoft_test` submodule in the project, but it exists
only for the module's automated tests — do not enable it on a real site.

Once enabled, add the Microsoft provider and enter your Azure key as described in
[Configuration](../configuration/index.md).
