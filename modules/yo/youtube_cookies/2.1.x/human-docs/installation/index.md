# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- A cookie-compliance system that YouTube Cookies can hook into for the actual
  consent decision — either **OneTrust** or the **EU Cookie Compliance**
  (`eu_cookie_compliance`) module. You choose which on the settings form.

There are no other Composer or PHP library requirements, and the module has no
dependencies that Drupal must enable for it.

## Install with Composer

From the project root:

```bash
composer require drupal/youtube_cookies -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/youtube_cookies -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en youtube_cookies -y
```

The module ships no submodules. After enabling it, head to
[Configuration](../configuration/index.md) — you **must** set a cookie category
and a provider before any video blocking happens.
