# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Language** module (`language`) enabled, with more than one language configured
  (otherwise there is nothing to disable).

There are no third‑party libraries or special PHP requirements. If you use **Simple XML
Sitemap**, this module will also strip disabled‑language URLs from its output, but that module
is not required.

> **Heads up:** the installed release is a **release candidate** (`8.x-1.0-rc2`, Composer
> `1.0.0-rc2`). There is no stable 1.0 tag yet; test on a non‑production environment first.

## Install with Composer

From the project root:

```bash
composer require drupal/disable_language -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed. Because only a release candidate exists, make sure your project's `minimum-stability`
allows it (Composer will otherwise refuse to install the RC).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your host
> machine — `ddev composer require drupal/disable_language -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en disable_language -y
```

This enables core `language` as a dependency if it isn't already on. There are no submodules.

## After enabling

The language list grows a **Disabled** column and each language's edit form gains a *Disable
language* checkbox. Head to [Configuration](../configuration/index.md) to disable a language —
and remember to clear caches afterwards, because this module can't do it for you.
