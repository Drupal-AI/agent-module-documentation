# Installation

## Requirements

TARDIS is deliberately lightweight. It needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** module (`views`) — the only dependency.

There are no third-party Composer or PHP library requirements. TARDIS is covered
by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/tardis -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (The Composer package name, `drupal/tardis`, matches the
module's machine name, `tardis`.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tardis -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tardis -y
```

## Verify it worked

Enabling the module adds a new **TARDIS** choice to the **Format → Style** options
inside the Views UI. Edit any view, open its Format settings, and confirm TARDIS
appears in the list of styles. From there, follow
[Configuration](../configuration/index.md) to switch a view to the TARDIS style
and wire up the archive links.
