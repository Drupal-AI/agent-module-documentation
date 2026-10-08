# Installation

## Requirements

- **Drupal 9.3+, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- No modules outside Drupal core are required. The jump‑menu widget lives in the
  admin toolbar, so core's Toolbar is the natural place it appears.

There are no third‑party PHP or JavaScript library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_jump_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_jump_menu -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_jump_menu -y
```

## Verify it worked

After enabling, grant the **Use the entity jump menu toolbar widget** permission at
**People → Permissions**, then reload an admin page. You should see the jump‑menu
controls (an entity‑type select and an ID field) in the admin toolbar. See the
["How to use it"](../index.md) section for putting it to work and for placing the
optional block.
