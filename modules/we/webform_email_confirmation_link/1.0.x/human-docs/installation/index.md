# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Webform** module (`webform`) — this is a required dependency and provides
  the handler machinery this module extends. Composer pulls it in automatically if
  it isn't already present.

There are no other third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/webform_email_confirmation_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Webform and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/webform_email_confirmation_link -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webform_email_confirmation_link -y
```

This also enables Webform if it wasn't already. The module ships no submodules.
Once enabled, open any form's *Emails / Handlers* page to add the confirmation
handler — see [Configuration](../configuration/index.md).
