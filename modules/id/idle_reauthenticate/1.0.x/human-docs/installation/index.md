# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- Core's **User** module (`user`) — enabled on every standard Drupal site and
  pulled in automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/idle_reauthenticate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/idle_reauthenticate -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en idle_reauthenticate -y
```

## Verify it worked

After enabling, set an idle timeout on the module's configuration form (see
[Configuration](../configuration/index.md)). Then log in, leave the browser
untouched for longer than the timeout, and confirm the re‑authentication dialog
appears and blocks interaction until you re‑enter your password.
