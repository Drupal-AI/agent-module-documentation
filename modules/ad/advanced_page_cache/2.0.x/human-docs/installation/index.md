# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Drupal core's **Page Cache** (`page_cache`) module enabled — this module
  extends it, and Drupal enables it automatically as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/advanced_page_cache -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/advanced_page_cache -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en advanced_page_cache -y
```

On its own the module just installs the extension point; it changes nothing until
a cache-id contributor is added.

## Example submodules — enable only what you need

Two optional example submodules demonstrate the extension point. Enable them
individually with `drush en`:

| Submodule | Machine name | What it does |
|-----------|--------------|--------------|
| **Cookie Page Cache** | `cookie_page_cache` | Varies the anonymous page cache by the value of a cookie. |
| **IP Page Cache** | `ip_page_cache` | Varies the anonymous page cache by the visitor's client IP. Use with care — IP is high-cardinality and can multiply cache entries and reduce hit rates. |

For example:

```bash
drush en cookie_page_cache -y
```

Each submodule requires the base module, which is already present once you have
installed it above. They also serve as reference implementations if you plan to
write your own cache-id part.
