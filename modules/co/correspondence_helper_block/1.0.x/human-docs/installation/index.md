# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).

There are no other module dependencies and no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/correspondence_helper_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/correspondence_helper_block -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en correspondence_helper_block -y
```

## Verify it worked

After enabling, go to **Structure → Block layout** and confirm the
**Correspondence Helper Block** is available to place. Once you've set its text
(see [Configuration](../configuration/index.md)) and placed it in a region, view a
page while logged in — the block should show your configured messages together
with your own account email.
