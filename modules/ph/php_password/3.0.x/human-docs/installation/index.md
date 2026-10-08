# Installation

## Requirements

- **Drupal 10.4 or 11.1** and up (`core_version_requirement: ^10.4 || ^11.1`).
- No other module dependencies.
- For **argon2** algorithms: PHP built with **libargon2**.

> **Do you need it?** The 3.x version is only required on Drupal core **10.4/10.5
> and 11.1/11.2**. On **Drupal 11.3 or newer**, core configures the password
> algorithm natively and this module is unnecessary — if installed there, it simply
> no‑ops.

There are no third‑party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/php_password -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/php_password -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en php_password -y
```

## Configure the algorithm

Enabling the module is not enough on its own — you should set the
`password.algorithm` (and optionally `password.options`) parameters in a
`services.yml` file, as described in "How to configure it" on the
[overview page](../index.md). Rebuild the container afterwards with `drush cr`.

## Verify it worked

After setting the algorithm and clearing caches, change or set a user's password (or
have a user log in) to generate a fresh hash, then inspect that hash — for example
with PHP's `password_get_info()` — to confirm it reports the algorithm you chose.
