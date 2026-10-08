# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Menu UI** module (`menu_ui`) enabled — this is the only dependency, and
  it's what provides the menu link settings on the node form that this module
  builds on.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/required_menulink -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/required_menulink -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en required_menulink -y
```

Enabling the module adds a **Menu link settings** vertical tab to the content type
edit form, but doesn't change any content type's behaviour until you turn the
requirement on for a type. See [Configuration](../configuration/index.md).

> **Tip:** for a content type to offer menu link settings at all, that type must
> have at least one menu enabled for it under its own *Menu settings* — that's
> standard core behaviour.
