# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- No other module dependencies and no third-party PHP libraries. (You'll want core's
  contact forms in place, since this module shapes the mail they send.)

## Install with Composer

From the project root:

```bash
composer require drupal/contact_mail -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/contact_mail -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en contact_mail -y
```

> **Expect a warning.** Enabling prints `Route synmail.config does not exist`.
> This is a stale **Configure** link left in the module's `info.yml` from an old
> project name; the module still installs and works. It only means the Configure
> link on the Extend page won't work — see [Configuration](../configuration/index.md)
> for how to reach the settings form.

## Verify it worked

After enabling, open the settings form at **Configuration › System › Contact Mail
Settings** (`/admin/config/system/contact-mail`) and confirm you can set common
recipients and the mail formatting. See
[Configuration](../configuration/index.md).
