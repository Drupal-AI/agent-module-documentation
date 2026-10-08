# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Hook Event Dispatcher** (`hook_event_dispatcher`, providing
  `core_event_dispatcher ^4`) and **Autoservices** (`autoservices ^1`). Composer
  pulls these in for you.
- The module also relies on **external PHP libraries** (from packagist.org, to
  talk to the jsDelivr API), so it **must be installed with Composer** — you
  cannot install it from a plain tarball.

## Install with Composer

From the project root:

```bash
composer require drupal/libraries_provider -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the two module dependencies and the external
PHP libraries this module needs.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/libraries_provider -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en libraries_provider -y
```

Drupal will enable Hook Event Dispatcher and Autoservices at the same time.

## Submodules

- **Libraries Provider UI** (`libraries_provider_ui`) — adds the administrative
  interface for changing each library's source, version, and variant without
  hand‑editing YAML. Enable it if you want to manage libraries through a screen
  rather than in code:

  ```bash
  drush en libraries_provider_ui -y
  ```

## Verify it worked

1. Confirm **Libraries Provider** is enabled on **Extend** (`/admin/modules`),
   along with Hook Event Dispatcher and Autoservices.
2. If you enabled the UI submodule, confirm its management screen is reachable in
   the admin area.
3. Add a `libraries_provider` section to a library in a theme's
   `*.libraries.yml`, clear the cache, and confirm the library loads from the
   source you chose (check the page source for a CDN URL versus a local `/libraries`
   path).

Next, see [Configuration](../configuration/index.md) for the YAML keys and the UI.
