# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other contrib module dependencies. The optional
  [Token](https://www.drupal.org/project/token) module lets you use tokens in the
  link text and query parameters, but it is not required.
- **A configured private file system.** The module works only for fields stored
  on the `private://` scheme, so your site must have the private files directory
  set up (the `file_private_path` setting in `settings.php`).

> **Heads up:** this project is not covered by Drupal's security advisory policy,
> and — as noted on the front page — its "encryption" is URL obfuscation rather
> than a confidentiality control. Keep that in mind before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/encrypted_link_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/encrypted_link_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en encrypted_link_formatter -y
```

## Verify it worked

1. Confirm the module is enabled on the **Extend** page (`/admin/modules`).
2. Confirm your **private file system** is configured — if it is not, the
   formatter has nothing to apply to.
3. Visit **Configuration → System → Crypt settings**
   (`/admin/config/system/crypt-settings`) and confirm the settings form loads.
   Then continue to [Configuration](../configuration/index.md) to choose a mode,
   set a strong seed, and apply the formatter to a field.
