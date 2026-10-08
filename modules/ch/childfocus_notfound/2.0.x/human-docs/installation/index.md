# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`) — this release supports Drupal 11
  only.
- Core's **Block** module (`block`) enabled — the only dependency, and Drupal
  enables it automatically when you turn on this module.
- A **key** from [notfound.org](https://notfound.org/) to show real cases (see
  [Configuration](../configuration/index.md)).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/childfocus_notfound -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/childfocus_notfound -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en childfocus_notfound -y
```

## Verify it worked

Go to **Configuration → Childfocus (notfound.org)**
(`/admin/config/childfocus_notfound`) and confirm the settings form loads. Then
head to [Configuration](../configuration/index.md) to enter your notfound.org key
and place the block on your 404 page — nothing appears to visitors until you do
both.
