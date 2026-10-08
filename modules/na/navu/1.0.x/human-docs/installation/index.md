# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **Block** module (`block`) enabled — Drupal enables it automatically as a
  dependency.
- A **navu.co subscription** and the site code / embed credentials for your
  account. Without an active NAVU subscription the sidebar will not function.

There are no additional PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/navu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/navu -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en navu -y
```

## Keeping your NAVU credentials safe

The NAVU site code you paste into the block is an account credential. Treat it as
configuration you manage deliberately: avoid committing a production credential
into a shared repository if your workflow exports block configuration, and use a
different code for staging than for production where NAVU supports it.

## Verify it worked

Place the **NAVU** block (see "How to use it" in the [overview](../index.md)) with
a valid site code, then visit a targeted page as an anonymous visitor. The NAVU
sidebar should load and respond. If it does not appear, re-check the site code and
the block's visibility settings, and confirm your navu.co subscription is active.
