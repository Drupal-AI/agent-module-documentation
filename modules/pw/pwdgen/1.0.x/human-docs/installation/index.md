# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No third-party libraries are required.

> **Security coverage:** this project is **not** covered by Drupal's security
> advisory policy. Weigh that before relying on it on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/pwdgen -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (You can also pin the branch with
`composer require 'drupal/pwdgen:^1.0'`.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pwdgen -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pwdgen -y
```

## Verify it worked

1. Confirm the module is enabled: `drush pm:list --status=enabled | grep pwdgen`.
2. Visit **Configuration → People → Generate password**
   (`/admin/config/people/generate-password`), enter a phrase, and submit — a
   generated password should appear. See [Configuration](../configuration/index.md)
   for the options.
