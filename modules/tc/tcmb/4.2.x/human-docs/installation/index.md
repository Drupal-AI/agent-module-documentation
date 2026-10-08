# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- PHP's **`allow_url_fopen`** setting must be **On** (`1`) in your `php.ini` — the
  module uses it to fetch the central bank's data over the network. If it is
  disabled, the rates will not load.

There are no contributed‑module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/tcmb -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tcmb -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tcmb -y
```

If you also want the public JSON feed of the rates, enable the `tcmb_json`
submodule as well:

```bash
drush en tcmb_json -y
```

Remember that this feed is **public read‑only reference data** — anyone who can
reach the endpoint can read the rates.

## Next steps

The module needs a little configuration before anything shows up: choose your
currency codes and place the display block. See
[Configuration](../configuration/index.md).
