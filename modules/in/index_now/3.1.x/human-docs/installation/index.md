# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.0 or newer** (`php: ^8.0`).
- The **Config Split** (`config_split`) and **Path Alias** (`path_alias`) modules —
  required dependencies.
- The **`league/commonmark`** PHP library (version `^2.0`), pulled in automatically
  by Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/index_now -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it also pulls in the required Config Split module and
the `league/commonmark` library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/index_now -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en index_now -y
```

On enable, the module generates your IndexNow **API key** automatically. If the
site's status report later warns that the key is empty (for example after a
config‑only deploy), generate one with:

```bash
drush index_now:keygenerate
```

Then configure it at **Configuration → Web services → Index Now** — see
[Configuration](../configuration/index.md).

## Submodule — Index Now Commerce

The project ships one optional submodule, **Index Now Commerce**
(`index_now_commerce`), which adds IndexNow support for Commerce **products** and
**stores**. Enable it only if you run Drupal Commerce:

```bash
drush en index_now_commerce -y
```

Once enabled, its product and store types appear as their own exclusion tabs on the
Index Now settings form.
