# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **[Redirect](https://www.drupal.org/project/redirect)** module,
  **version 1.12 or newer** — it provides the redirect entities and admin
  interface this module builds on. Composer pulls it in for you.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/redirect_regex -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including the Redirect module — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/redirect_regex -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en redirect_regex -y
```

## Verify it worked

Go to **Configuration → Search and metadata → URL redirects → Add redirect**
(`/admin/config/search/redirect/add`). The redirect form should now include a
**Regular expression** checkbox. Ticking it turns the redirect's source into a
regex pattern — see [Configuration](../configuration/index.md) for how to write
and use them.
