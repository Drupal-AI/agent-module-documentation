# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- A **Mida account and API key** — you get the key from the Mida platform, and
  it's what ties the injected script to your experiments.

There are no additional contrib module dependencies and no extra Composer
libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/mida -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mida -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mida -y
```

## Verify it worked

The module does nothing visible until it is configured. Continue to
[Configuration](../configuration/index.md) to enter your Mida API key and set the
visibility conditions. Once configured, view the page source on a page where the
script should load and confirm the Mida snippet is present.
