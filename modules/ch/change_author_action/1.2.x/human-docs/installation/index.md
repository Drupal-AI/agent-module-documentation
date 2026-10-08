# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The contrib **Action** module (`drupal/action`, `^0.2`) — Change author action
  is built on top of it, and Composer pulls it in as a dependency.

There are no other PHP library requirements. The module defines no permissions of
its own — the confirm form is gated by core's **Administer users** permission.

## Install with Composer

From the project root:

```bash
composer require drupal/change_author_action -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the required
Action module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/change_author_action -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en change_author_action -y
```

This enables the `action` dependency too if it is not already on. Enabling the
module installs two action configs: one for **nodes** and one for **media**.

## Verify it worked

Go to **Content** (`/admin/content`), tick a couple of items, and open the
**Action** dropdown — **Change author** should be listed. Make sure the
administrator running the reassignment holds the **Administer users** permission,
or the confirmation step will be denied. See the [overview](../index.md) for the
full walkthrough.
