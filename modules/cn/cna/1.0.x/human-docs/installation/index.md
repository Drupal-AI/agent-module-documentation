# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **Comment** (`comment`) module — the only dependency, enabled
  automatically.
- A working **mail system** on the site (SMTP or another transport). Configure
  this before relying on notifications, or the emails have nowhere to go.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cna -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/cna -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cna -y
```

## Verify it worked

Log in as an administrator and open **Configuration → System → Comment Notify
Author** (`/admin/config/system/cna`). Turn on the toggles you want (see
[Configuration](../configuration/index.md)), then post a test comment on a node
owned by a user with a valid email and confirm the notification arrives.
