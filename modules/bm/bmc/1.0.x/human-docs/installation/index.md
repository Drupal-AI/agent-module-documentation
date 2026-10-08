# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Block** module (`block`) — Drupal enables it automatically as a
  dependency when you turn on Buy Me a Coffee.
- A **Buy Me a Coffee account** with a public username, so you have something to
  point the button at.

There are no third‑party Composer or PHP library requirements. No API key or
secret is needed — only your public Buy Me a Coffee username.

## Install with Composer

From the project root:

```bash
composer require drupal/bmc -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bmc -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bmc -y
```

Once enabled, place and configure the **Buy Me a Coffee** block from
**Structure → Block layout** and enter your username — see
[How to use it](../index.md#how-to-use-it).
