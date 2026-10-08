# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A **FullStory account**. From the snippet FullStory gives you, note the line
  `window['_fs_org'] = 'ABC123';` — `ABC123` is your organization (org) ID, which
  you enter in the module's settings.

There are no module dependencies and no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/fullstory -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fullstory -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fullstory -y
```

## Verify it worked

Log in as an administrator and open the FullStory settings form (config route
`fullstory.admin_settings_form`). Once you have entered your org ID there (see
[Configuration](../configuration/index.md)), the snippet is added to your pages —
but read the privacy notes in the configuration guide **before** you turn recording
on for real visitors.
