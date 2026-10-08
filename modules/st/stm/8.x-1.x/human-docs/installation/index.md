# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **Taxonomy** and **Menu UI** modules (part of a standard install) — the
  module works with vocabularies and menus you already have.
- No third-party Composer or library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/stm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/stm -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

Note: the Composer package is `drupal/stm` while the module's machine name is
`stm` — they match, so enable it under that same name below.

## Enable the module

```bash
drush en stm -y
```

## Verify it worked

Go to **Structure → Taxonomy**, open any vocabulary, and look for a **Sync To
Menu** tab on its term overview page (or visit
`/admin/structure/taxonomy/manage/{vocabulary}/overview/menu` directly). If the tab
is there, the module is working — see the main guide's *How to use it* section for
running a sync.
