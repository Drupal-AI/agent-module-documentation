# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Webform** module (`webform`) — this is a hard dependency, since the module
  only validates email fields on webforms.
- A **mailboxlayer account and API key** — sign up at
  [mailboxlayer.com](https://mailboxlayer.com/). Free plans have a monthly request
  limit, which is one reason the module caches results.

## Install with Composer

From the project root:

```bash
composer require drupal/mailboxlayer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If Webform isn't already installed, pull it in the same
way (`composer require drupal/webform -W`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mailboxlayer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mailboxlayer -y
```

Webform will be enabled automatically as a dependency if it isn't already.

## Verify it worked

Log in as an administrator and open **Configuration → Mailbox Layer**
(`/admin/config/mailboxlayer`). You should see the settings page where you enter
your API key. After you've configured the key and enabled validation on a
webform's email field (see [Configuration](../configuration/index.md)), submit the
form with an obviously invalid address and confirm it's rejected.
