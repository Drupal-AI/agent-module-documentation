# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- **PHP 8.1 or newer**.
- Core's **Block** module (`block`) enabled — the only dependency, and Drupal
  enables it automatically.
- No third-party Composer libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/block_aria_landmark_roles -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/block_aria_landmark_roles -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_aria_landmark_roles -y
```

That is the whole setup. There is no settings form and no permission to grant —
the module simply adds a **Block ARIA Landmark Roles settings** section to every
block's configuration form. You set roles per block as described in the
[main guide](../index.md#how-to-use-it).

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and click
**Configure** on any block. You should see a **Block ARIA Landmark Roles settings**
section with a **Landmark role** select and a **Label** field. Set a role, save,
then view the page and inspect the block's wrapper element — it should now carry
the matching `role` (and `aria-label`, if you set a label) attribute.
