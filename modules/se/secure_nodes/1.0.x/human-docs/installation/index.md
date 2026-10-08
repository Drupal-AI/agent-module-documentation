# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Views** module (`views`) — this is the only dependency, and it is part of
  Drupal core (enabled by default on most sites). It powers the Protected Nodes
  listing and the protect/unprotect bulk actions.

There are no third-party PHP library or Composer requirements. The module provides its
own permissions for the protect/unprotect actions.

## Install with Composer

From the project root:

```bash
composer require drupal/secure_nodes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/secure_nodes -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en secure_nodes -y
```

You can also enable it from **Extend** (`/admin/modules`).

## Verify it worked

After enabling, protection is switched on for the **Article** content type
automatically. To confirm:

- Edit an Article and look for the **"Protect this Node?"** checkbox in the sidebar.
- Visit **`/admin/config/content/secure_nodes`** to see (and extend) the list of
  protected content types.
- Look for the **Protected Nodes** tab next to **Content** (`/admin/content`).

To protect content types other than Article, continue to
[Configuration](../configuration/index.md). Remember to grant the protect/unprotect
permissions only to trusted administrators, and to confirm the protection covers the
deletion paths your site actually uses. This project is **not covered by Drupal's
security advisory policy**.
