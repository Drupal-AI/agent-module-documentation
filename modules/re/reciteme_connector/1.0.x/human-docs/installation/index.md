# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **jQuery** and **drupalSettings** libraries, which the module uses to
  pass the Recite Me service details to the browser — both ship with core, so
  there is nothing extra to install.
- A **Recite Me account**, which supplies the **Service URL** and **Service Key**
  you will enter during configuration. Sign up and find these values at
  [reciteme.com](https://reciteme.com/).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/reciteme_connector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/reciteme_connector -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en reciteme_connector -y
```

## Verify it worked

After enabling, visit the settings form at
`/admin/config/reciteme_connector/recitemeconfig` and confirm it loads. The
toolbar itself will not appear until you have entered your Recite Me service URL
and key and either placed the ReciteMe block or turned on the site-wide toggle —
see [Configuration](../configuration/index.md).
