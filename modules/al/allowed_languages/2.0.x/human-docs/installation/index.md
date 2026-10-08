# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Core's **Content Translation** (`content_translation`) and **User** (`user`)
  modules — Allowed Languages depends on both, and they are enabled as
  dependencies. Content Translation in turn needs core's **Language** module, and
  you should have more than one language configured for the module to be
  meaningful.
- There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/allowed_languages -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/allowed_languages -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en allowed_languages -y
```

Enabling the module adds an **Allowed languages** field to every user account.

## After enabling

There are no submodules. Next, set the two permissions and assign languages to
your editors — see [Configuration](../configuration/index.md). Remember that once
the module is on, any user without the *Translate all languages* bypass is
restricted by default, so plan your permissions before you rely on it in
production.
