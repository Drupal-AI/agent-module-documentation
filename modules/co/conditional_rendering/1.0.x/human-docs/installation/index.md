# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Layout Builder** module (`layout_builder`) — the only dependency,
  enabled automatically when you enable this module.
- *(Optional, recommended)* The **Token** module (`drupal/token`) for a token
  browser when defining conditions. Not required.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/conditional_rendering -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/conditional_rendering -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en conditional_rendering -y
```

To also install the optional token browser:

```bash
composer require drupal/token -W
drush en token -y
```

## Verify it worked

Edit a **content block** (**Content → Blocks**). You should see a new section for
rendering conditions, with a **Show/Hide** action selector and the ability to add
condition rows. Place the block in a Layout Builder layout to see the rules take
effect on the rendered page.
