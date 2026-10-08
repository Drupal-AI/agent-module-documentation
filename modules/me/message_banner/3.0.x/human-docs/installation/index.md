# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).

There are no other module dependencies and no third-party Composer library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/message_banner -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/message_banner -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en message_banner -y
```

On install, the **View message banner** permission is granted to the anonymous and
authenticated roles, so the banner will be visible to everyone once you enable and
save it.

## Configure the banner

Go to **Configuration → User interface → Message Banner**
(`/admin/config/user-interface/message-banner`), write your message, tick **Enable
banner**, and save. See the [main page](../index.md#configuring-the-banner) for the
full list of options. Nothing appears until the banner is enabled and saved.
