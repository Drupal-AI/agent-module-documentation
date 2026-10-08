# Installation

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`).
- The **Simplenews** module (`simplenews`) — a hard dependency. Install and set
  up Simplenews (with at least one newsletter) first; Composer pulls it in
  automatically.

There are no PHP library or third‑party Composer requirements beyond Simplenews.

## Install with Composer

From the project root:

```bash
composer require drupal/degov_simplenews -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Simplenews.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/degov_simplenews -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en degov_simplenews -y
```

Enabling the module runs its install step, which adds the columns needed to store
each subscriber's forename, surname, and consent timestamp.

## Verify it worked

Log in as an administrator and go to **Configuration → deGov → Simplenews**
(`/admin/config/degov/simplenews`). If the settings form loads, the module is
active.

> **Important:** Until you configure a privacy‑policy page for each language (see
> [Configuration](../configuration/index.md)), the Simplenews **signup form will
> be hidden** on the front end — this is by design, so that subscribers are never
> shown a form without a privacy policy and consent checkbox. Administrators will
> see an error message pointing to the missing configuration.
