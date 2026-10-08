# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Language** module (`language`) enabled, and at least two configured languages so
  the site is actually multilingual — otherwise the block hides itself.

The default **Simple HTML select** output needs no extra libraries. The other three output
styles are optional and each needs its JavaScript library present:

- **Chosen** — the `harvesthq/chosen` library (and, on Drupal, the *Chosen* contrib module).
- **msDropdown** (Marghoob Suleman) — the `marghoobsuleman/ms-dropdown` library.
- **ddSlick** — the ddSlick library (flag‑image dropdown).

Installing the optional **Language Icons** module (`drupal/languageicons`) adds a flag next
to each language.

## Install with Composer

From the project root:

```bash
composer require drupal/lang_dropdown -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your host
> machine — `ddev composer require drupal/lang_dropdown -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lang_dropdown -y
```

There are no submodules. Once enabled, the **Language dropdown switcher** block becomes
available in **Block layout** — see [Configuration](../configuration/index.md) to place and
tune it.
