# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- An **Axeptio account** with a configured project, so you have the identifier(s)
  the widget needs.

There are no other module dependencies and no third‑party Composer or PHP library
requirements — the widget itself loads from Axeptio's service in the browser.

## Install with Composer

From the project root:

```bash
composer require drupal/axeptio -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/axeptio -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en axeptio -y
```

After enabling, connect your Axeptio account on the settings form and — the part
that actually matters for compliance — make sure your trackers are gated behind
consent. See [Configuration](../configuration/index.md).
