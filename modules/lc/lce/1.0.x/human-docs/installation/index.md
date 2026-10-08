# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11.0`).

There are no third-party Composer or PHP library requirements. LCE integrates
nicely with **Config Ignore** if you want to exclude a linked entity's ID from
configuration exports, but that module is optional.

## Install with Composer

From the project root:

```bash
composer require drupal/lce -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/lce -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lce -y
```

After enabling, grant the module's permission under **People → Permissions** to
the roles that should manage entity identifiers.

## Verify it worked

Assign a unique identifier to a content entity, then reference it with an `lce:*`
token (such as `[lce:path:your_identifier]`) or a Twig function. The token should
resolve to that entity's canonical URL — and continue to do so even if you later
change the entity's title or URL alias.
