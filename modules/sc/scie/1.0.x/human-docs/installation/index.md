# Installation

## Requirements

SCIE is deliberately self-contained:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Node** module (`node`) — the only dependency.
- **No** external services, API keys, or additional installations. The engine is
  pure PHP and runs entirely within Drupal, so it works on shared hosting and on
  managed platforms such as Pantheon, Acquia and Platform.sh.

## Install with Composer

From the project root:

```bash
composer require drupal/scie -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/scie -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en scie -y
```

Enabling the module creates the `field_scie_score` field on all content types and
scores your existing content immediately — there is nothing you must configure to
get started.

## Verify it worked

Open a node and confirm it now carries an SCIE score, then visit the SCIE
dashboard to see scores listed across your content. From there you can, optionally,
adjust the scoring behaviour — see [Configuration](../configuration/index.md).
