# Installation

## Requirements

Language Switcher Extended is lightweight:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Block** module (`block`) — to place the Language Switcher block.
- Core's **Language** module (`language`) — for multilingual support.
- In practice you also need core **Content Translation** enabled and translatable
  content, so there are translations for the module to detect.
- No third-party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/language_switcher_extended -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/language_switcher_extended -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en language_switcher_extended -y
```

Drupal enables the `block` and `language` dependencies for you if they are not
already on.

## Next steps

Two things must be in place for the module to do anything: your site is
multilingual with translatable content, and core's **Language Switcher** block is
placed at **Structure → Block layout**. Then configure the behaviour — see
[Configuration](../configuration/index.md).
