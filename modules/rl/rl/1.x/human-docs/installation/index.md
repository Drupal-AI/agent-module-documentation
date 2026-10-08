# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 | ^11`).
- Core's **System** module (`system`) — the only declared dependency.
- Web-server configuration that allows **direct access to `rl.php`** (see the
  verification step below). This is the same requirement Drupal core has for
  `statistics.php`.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/rl -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rl -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module, plus the submodule(s) for whatever you want to test:

```bash
drush en rl -y
# then, for example:
drush en rl_page_title -y   # A/B test page titles
drush en rl_menu_link -y    # A/B test menu link labels
```

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **A/B Test Page Titles** | `rl_page_title` | Test page titles for nodes, View pages, and any controller. |
| **A/B Test Menu Links** | `rl_menu_link` | Test the labels of any menu link. |
| **Example** | `rl_example` | A working example experiment to learn from. |
| **Example Frontend** | `rl_example_frontend` | The front-end companion to the example. |

## Verify the `rl.php` endpoint

Relaunch tracks clicks and makes decisions through a lightweight `rl.php` script,
allowed by the module's bundled `.htaccess`. Test that it is reachable:

```bash
curl -X POST -d "action=ping" https://example.com/modules/contrib/rl/rl.php
```

If that fails:

- **Apache** — ensure `.htaccess` files are processed (`AllowOverride All`).
- **Nginx** — copy the rewrite rules from the module's `.htaccess` into your server
  config.
- **Security modules/WAF** — whitelist the `rl.php` path.

## Verify it worked

Confirm the module is enabled (`drush pm:list --status=enabled | grep '^ rl'`) and
that the `rl.php` ping above succeeds. Then define your experiment's variants and
watch the admin reports — see the "How to use it" section of the
[overview](../index.md).
