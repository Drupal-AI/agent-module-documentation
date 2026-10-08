# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Filter** module (`filter`) enabled — this is the only dependency, and it
  is part of standard Drupal.
- No third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/filter_twig -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/filter_twig -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en filter_twig -y
```

Enabling the module makes the **"Replaces Twig values"** filter available, but it
does **nothing** until you tick it on a text format.

> **Security reminder.** This filter executes Twig from field content. Only enable it
> on a text format whose *use* permission is restricted to trusted/administrative
> roles — never on a format available to untrusted or anonymous users. See the
> [overview](../index.md) for the full caution and the steps to enable it on a
> format.

## Next step

Turn the filter on for a suitably restricted text format at **Configuration →
Content authoring → Text formats and editors**
(`/admin/config/content/formats`) — see the [overview](../index.md) for the
walkthrough.
