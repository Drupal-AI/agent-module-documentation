# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Drupal core only — there are no other module dependencies and no third-party
  library or special PHP requirements.

Tamper is a toolkit rather than an end-user feature, so on most sites you install
it alongside the module that consumes it — usually **Feeds**
(`drupal/feeds`) — which lets you attach Tamper transformations to imported fields.

## Install with Composer

From the project root:

```bash
composer require drupal/tamper -W
```

Or install it together with Feeds:

```bash
composer require drupal/tamper drupal/feeds -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tamper -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tamper -y
```

There is nothing to configure after enabling — the ~45 built-in Tamper plugins and
the `plugin.manager.tamper` service become available immediately. You use them
through a consuming module such as Feeds, or from your own code. See
[How to use it](../index.md#how-to-use-it) on the overview page.
