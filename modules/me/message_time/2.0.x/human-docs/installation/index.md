# Installation

## Requirements

- **Drupal 8, 9, 10 or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- No other modules and no external PHP libraries are required.

This project is not covered by Drupal's security advisory policy, so review it before
relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/message_time -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/message_time -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en message_time -y
```

## Verify it worked

Visit **Configuration → User interface → Message Time**
(`/admin/config/user-interface/message-time`). If the settings form loads, the module
is installed. Set your preferred duration there (see
[Configuration](../configuration/index.md)), then trigger any status message — for
example save a piece of content — and confirm the message disappears after the delay
you chose.
