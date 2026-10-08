# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- A **RumbleTalk account** with at least one chat room created, so you have a chat
  ID/hash to embed. Sign up at [rumbletalk.com](https://rumbletalk.com/).
- No other contributed modules, third‑party Composer libraries, or PHP extensions are
  required. The chat widget's JavaScript is loaded from RumbleTalk at runtime.

> **Heads up — the Composer package name differs from the module name.** The project
> is `rumbletalk` on Drupal.org (so you `composer require drupal/rumbletalk`), but the
> module's machine name is `rumbletalk_chat` (so you `drush en rumbletalk_chat`).

This project is not covered by Drupal's security advisory policy, so weigh that
alongside the third‑party‑script consideration before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/rumbletalk -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rumbletalk -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rumbletalk_chat -y
```

## Verify it worked

Confirm the module is enabled at **Extend** (`/admin/modules`). Then go to
**Structure → Block layout** (`/admin/structure/block`) and click **Place block** —
the RumbleTalk chat block should be available to add. Configuring it is covered in
[Configuration](../configuration/index.md).
