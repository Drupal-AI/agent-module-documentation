# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Filter** and **System** modules (`filter`, `system`) — part of core and
  enabled automatically as dependencies.
- PHP with the **json** extension (standard on any Drupal-capable PHP).
- The **lazysizes** JavaScript library, installed to `/libraries/lazysizes` — required
  unless you run in native-only mode (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/lazy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lazy -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Add the lazysizes library

Unless you plan to use **native-only** lazy-loading (the "Prefer native" setting),
Lazy-load needs the third-party **lazysizes** library on disk. The module suggests
`bower-asset/lazysizes`. Place the library so its files sit under
`/libraries/lazysizes` in your web root (the exact path and even an external CDN URL
are configurable on the settings form). If you only ever use native `loading="lazy"`,
you can skip the library.

## Enable the module

```bash
drush en lazy -y
```

There are no submodules. Enabling the module adds the settings form under
**Configuration → Content authoring → Lazy-load**, the two lazy-loading image
formatters, and the text-format filter.

## Next steps

Nothing is lazy-loaded until you switch it on somewhere. Choose native vs. library mode
and enable lazy-loading via the text filter, image formatters, or render attribute —
all covered in **How to use it** on the [overview page](../index.md).
