# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No third‑party libraries and no other module dependencies. It's typically paired
  with an SSO/SAML login module, but that's a usage pairing, not a hard dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/login_path_helper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/login_path_helper -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en login_path_helper -y
```

## Verify it worked

1. Confirm the settings form loads at **`/admin/config/login_path_helper`**.
2. Place the **Login Path Helper** block in a region (see
   [Configuration](../configuration/index.md)).
3. As an anonymous visitor on some interior page, check that the login link's
   target includes a `destination=` pointing back at that page.
