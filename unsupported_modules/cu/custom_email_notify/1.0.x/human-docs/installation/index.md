# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **File** (`file`) and **Media** (`media`) modules — enabled automatically
  as dependencies.
- No third‑party Composer or PHP library requirements.
- For mail to actually leave your server, your site needs a working mail system. The
  module hands the message to Drupal's mail manager; add and configure an SMTP module
  (or similar) if the default PHP mail transport isn't reliable in your environment.

## Install with Composer

The project's Composer name is **`drupal/medianotify`** (it differs from the
`custom_email_notify` machine name). From the project root:

```bash
composer require drupal/medianotify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/medianotify -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it by its **machine name**, `custom_email_notify`:

```bash
drush en custom_email_notify -y
```

## Verify it worked

Log in as an administrator, grant the **`administer media document notifier`**
permission to a trusted role, and open **Configuration → Media/Document Notifier
settings** (`/admin/config/custom-email-notify/settings`). Set the allowed
extensions and recipients (see [Configuration](../configuration/index.md)), then
upload a matching file and confirm the notification arrives.
