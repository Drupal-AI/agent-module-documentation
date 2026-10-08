# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **[Redirect](https://www.drupal.org/project/redirect)** module
  (`redirect`) — this is the one hard dependency, and Composer pulls it in for
  you.
- Optional: the **Redirect 404** submodule (ships with Redirect) if you want to
  mark missing URLs as 410 Gone straight from the 404 report.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/redirect_or_410 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including pulling in the Redirect module — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/redirect_or_410 -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en redirect_or_410 -y
```

If you also want the 404‑report integration, enable Redirect's own submodule:

```bash
drush en redirect_404 -y
```

## Verify it worked

Go to **Configuration → Search and metadata → URL redirects → Add redirect**
(`/admin/config/search/redirect/add`). When you edit or add a redirect you
should now find **410 Gone** available as a status‑code choice. See
[Configuration](../configuration/index.md) for how the option behaves.
