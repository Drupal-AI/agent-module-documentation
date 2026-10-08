# Installation

## Requirements

Twig Tweak needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11.0`).
- **PHP 8.1 or newer**.
- **Twig 3.10.3 or newer** and the JSON PHP extension (`ext-json`) — both are
  already present on a standard Drupal 10.3+/11 install, and Composer pulls in the
  right Twig version for you.
- Core's **System** module, which is always enabled.

Optionally, `symfony/var-dumper` gives you a nicer `dump()` output when debugging
Twig variables; Composer will suggest it but it is not required.

## Install with Composer

From the project root:

```bash
composer require drupal/twig_tweak -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/twig_tweak -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en twig_tweak -y
```

That is all. There is no configuration step — the moment the module is enabled,
its functions and filters are available in every Twig template. See the
[overview](../index.md#how-to-use-it) for examples of the most common ones.

## Verify it worked

Add `{{ dump(_context|keys) }}` (or `{{ dd() }}`) to any template and reload the
page — if Twig Tweak is active you will see the debug output rather than an
"unknown function" error. You can also list everything the module registered by
running:

```bash
drush twig-tweak:debug
```
