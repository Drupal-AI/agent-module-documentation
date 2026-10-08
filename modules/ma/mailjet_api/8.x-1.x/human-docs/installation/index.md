# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Mail System** module (`mailsystem`), which this module depends on and
  Composer installs for you.
- The **Mailjet APIv3 PHP SDK**, downloaded automatically by Composer.
- A **Mailjet account** with an API key and secret.

## Install with Composer

From the project root:

```bash
composer require drupal/mailjet_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Mail System and
the Mailjet SDK and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mailjet_api -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mailjet_api -y
```

This also enables Mail System if it wasn't already on.

## Verify it worked

Log in as an administrator, open the Mailjet API settings form, and enter your
API key and secret (see [Configuration](../configuration/index.md)). Then use the
module's built-in **test form** to send yourself a message — if it arrives, the
integration is working. Finally, set Mail System to use the Mailjet API mailer so
your real site email is routed through it.
