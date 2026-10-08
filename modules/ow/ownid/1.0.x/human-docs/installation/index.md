# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- An account on the **OwnID console** (<https://console.ownid.com>) to create a
  project and obtain your App ID and Shared Secret.
- Outbound **HTTPS** connectivity from your site to the OwnID service.

There are no additional Composer or PHP library requirements declared by the
module. The **Email Registration**
([`drupal/email_registration`](https://www.drupal.org/project/email_registration))
module is recommended by the maintainers, since OwnID uses email as the login
identifier.

## Install with Composer

From the project root:

```bash
composer require drupal/ownid -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ownid -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ownid -y
```

## Verify it worked

Go to **Extend** (`/admin/modules`) and confirm OwnID is enabled, then click its
**Configure** link to reach the settings form. The install itself does nothing
visible until you enter your OwnID credentials — continue to
[Configuration](../configuration/index.md).
