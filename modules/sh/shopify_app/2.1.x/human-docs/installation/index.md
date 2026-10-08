# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- The **official Shopify PHP SDK**, which the module uses to run the OAuth flow and
  verify webhook signatures. Installing the module with Composer pulls in the
  packages it depends on.

There are no other Drupal module dependencies declared.

## Install with Composer

From the project root:

```bash
composer require drupal/shopify_app -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the Shopify SDK this framework builds on.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/shopify_app -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en shopify_app -y
```

## Next step

There is no settings form to fill in. From here you work as a developer: configure
your Shopify API credentials as secrets, and implement your webhook handlers as
plugins. See the [overview](../index.md) for how the pieces fit together, and the
sibling [`agent/`](../agent/start.md) docs for the technical detail.
