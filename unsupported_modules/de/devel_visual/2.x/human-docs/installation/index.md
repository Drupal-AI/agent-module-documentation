# Installation

> **Developer tool.** Intended for development environments and trusted roles.
> This project is not covered by Drupal's security advisory policy.

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Devel** module (`devel`) — Devel Visualizer extends Devel and depends on
  it.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/devel_visual -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including pulling in Devel if it isn't already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/devel_visual -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en devel_visual -y
```

This also enables **Devel** if it isn't already on.

## Grant the permission

Under **People → Permissions**, grant Devel Visualizer's permission to your
developer/administrator roles only.

## Verify it worked

With the module enabled and the permission granted, open the visualizer as a
permitted user; you should see the graph of configuration-object relationships. If
Devel itself isn't enabled, enable it first.
