# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer**.
- Two Composer libraries, installed automatically: `symfony/http-foundation`
  (`^6 || ^7`) and `guzzlehttp/psr7` (`^2.4.5`).
- No module dependencies.

A couple of compatibility notes worth knowing before you install:

- The module is **incompatible with the `big_pipe` module** — do not run both.
- Its edge-purging only actually does anything on **Pantheon** hosting. Off
  Pantheon it stays safely inert, so it is fine to keep enabled everywhere for
  configuration parity.

## Install with Composer

Note the Composer namespace is under `pantheon-systems`, not `drupal`:

```bash
composer require pantheon-systems/pantheon_advanced_page_cache -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it pulls in the Symfony and Guzzle libraries above.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require pantheon-systems/pantheon_advanced_page_cache -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pantheon_advanced_page_cache -y
```

That is all. There is no configuration form and nothing else to set up — the module
starts emitting `Surrogate-Key` headers and purging edge keys immediately. See
[How to use it](../index.md#how-to-use-it) on the overview page for the two optional
config keys.

## Optional: the test submodule

The package includes a `pantheon_advanced_page_cache_test` submodule used by the
project's automated tests. You do not need it on a normal site — leave it disabled.
