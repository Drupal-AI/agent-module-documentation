# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No third‑party Composer packages, PHP libraries or other module dependencies.

The only "requirement" beyond enabling the module is edit access to your site's
`settings.php`, since that is where all configuration lives.

## Install with Composer

From the project root:

```bash
composer require drupal/reverse_proxy_header -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/reverse_proxy_header -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en reverse_proxy_header -y
```

Enabling the module alone does nothing visible — it is a no‑op until you name a
header to read. Continue to [Configuration](../configuration/index.md) to add the
`$settings` line that turns it on.

## Verify it worked

After adding the `reverse_proxy_header` setting (see Configuration), you can
confirm Drupal is reading the value you expect:

```bash
drush ev "print \Drupal\Core\Site\Settings::get('reverse_proxy_header');"
```
