# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Drupal core's **Editor** module (`editor`) — enabled automatically as a
  dependency.

No third‑party libraries are required.

> **Note:** This module is marked *minimally maintained* (maintenance fixes only),
> though it is covered by the Drupal Security Team.

## Install with Composer

From the project root:

```bash
composer require drupal/elf -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/elf -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en elf -y
```

Enabling the module makes the filter *available*, but nothing changes on your
content until you turn the filter on for a text format — see
[Configuration](../configuration/index.md).

## Verify it worked

After enabling the module and turning the filter on for a text format (see
Configuration), edit a piece of content that uses that format and add an external
link. On the rendered page, the external link should carry the module's CSS class,
which your theme can style.
