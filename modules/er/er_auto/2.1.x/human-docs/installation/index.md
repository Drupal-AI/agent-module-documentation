# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No third-party Composer or PHP library requirements, and no other module
  dependencies. You will, of course, need the entity-reference fields you want to
  automate already in place (core's Entity Reference field is part of Drupal).

## Install with Composer

From the project root:

```bash
composer require drupal/er_auto -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/er_auto -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en er_auto -y
```

## Verify it worked

Edit an entity-reference field's settings on a content type (Structure → Content
types → *Manage fields* → the reference field). You should now see an **"Enable
Automation based on this field?"** option and the two field selectors used to wire
up the automation — see "How to use it" in the [overview](../index.md).
