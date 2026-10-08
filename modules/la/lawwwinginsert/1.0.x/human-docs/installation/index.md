# Installation

## Requirements

- **Drupal 10 or higher** (`core_version_requirement: ^10 || ^11 || ^12`).
- **PHP 8.1 or greater.**
- A valid **Lawwwing Script ID** from the Lawwwing service.

There are no third‑party Composer or PHP library requirements.

> **Security coverage:** this module is **not** covered by Drupal's security
> advisory policy, and its maintainers recommend the official `lawwwing` module
> instead (see the overview). It also loads a third‑party script from
> `cdn.lawwwing.com`.

## Install with Composer

From the project root — note the **project (Composer) name is `lawwwinginsert`**,
which differs from the module's machine name:

```bash
composer require drupal/lawwwinginsert -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/lawwwinginsert -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

The **machine name is `lawwwing`**, not `lawwwinginsert`, so enable it with:

```bash
drush en lawwwing -y
```

## Verify it worked

Go to **Configuration → Web services → Lawwwing Settings** (`/admin/config/lawwwing`)
and confirm the form loads. Nothing is injected until you enter a Script ID — see
[Configuration](../configuration/index.md). After configuring it, view a front‑end
page's source and confirm the Lawwwing `<script>` tag appears in the `<head>`.
