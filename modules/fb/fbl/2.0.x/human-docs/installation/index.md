# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **User** module (always present) — Field Based Login extends the core user
  login. No third‑party PHP libraries.
- The core **Configuration Translation** module is optional: enable it only if you
  want to translate the custom login‑field label and description.

## Install with Composer

From the project root:

```bash
composer require drupal/fbl -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fbl -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fbl -y
```

## Verify it worked

Go to **Configuration → People → Field Based Login**
(`/admin/config/people/fbl`) and confirm the settings form loads. Configure it (see
[Configuration](../configuration/index.md)), then log out and try signing in with
the alternative identifier you allowed — the correct password should still be
required.
