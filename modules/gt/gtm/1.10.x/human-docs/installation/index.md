# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other module dependencies, no third-party Composer libraries, and no PHP
  extensions.
- A **Google Tag Manager account** with a container, so you have a container ID
  (`GTM-XXXX`) to paste in. That is set up on Google's side, not in Drupal.

## Install with Composer

From the project root:

```bash
composer require drupal/gtm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/gtm -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gtm -y
```

Enabling the module does **not** inject anything yet. The snippet only appears once
you enter a container ID and turn on the Enable switch — see
[Configuration](../configuration/index.md).

## Grant the permission

The module adds an **Administer GTM** permission (`administer gtm`) that controls
access to the settings form. Grant it to administrators at **People → Permissions**
(`/admin/people/permissions`).

## Verify it worked

Go to **Configuration → System → Google Tag Manager**
(`/admin/config/system/gtm`). If the settings form loads, the module is installed.
After you configure it, view your site's front page source and look for the
`googletagmanager.com/gtm.js` script in the `<head>` — that confirms the container
is being injected.
