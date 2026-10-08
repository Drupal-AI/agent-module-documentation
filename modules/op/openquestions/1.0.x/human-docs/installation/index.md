# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Block**, **Taxonomy**, and **Views** modules — all part of Drupal core
  and enabled automatically as dependencies.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/openquestions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/openquestions -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en openquestions -y
```

Drupal enables Block, Taxonomy, and Views automatically as dependencies.

> **A note on maturity:** This module is an early alpha and is still under active
> development. The maintainer has advised against putting it on a live site until
> outstanding issues are resolved. Install it on a staging or test environment
> first.

## Verify it worked

After enabling, review the module's permissions at **People → Permissions**
(`/admin/people/permissions`) and grant voting rights to the group of users you
want. Then place the module's blocks from **Structure → Block layout**
(`/admin/structure/block`) and confirm the voting interface appears where you
placed it.
