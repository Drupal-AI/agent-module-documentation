# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Domain** module (`domain`).
- The **Admin Toolbar** module (`admin_toolbar`) — the toolbar the domain
  drop-down attaches to.

Both dependencies are pulled in by Composer. There are no third-party PHP or
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_menu_links -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/domain_menu_links -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain_menu_links -y
```

This also enables `domain` and `admin_toolbar` if they are not already on.

## Verify it worked

Log in as an administrator and look at the admin toolbar. You should see a new
drop-down listing your registered domains; hovering it lets you jump to another
domain. If you have no domains yet, add some under **Configuration → Domain**
first.
