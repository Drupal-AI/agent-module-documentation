# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Language** module (`language`), enabled — the only hard dependency, and
  Drupal enables it automatically.

It has no third-party Composer or PHP library requirements. For the full benefit
you'll usually also have core **Locale** (interface translation) and
**Configuration Translation** enabled — Language Hierarchy detects those and
extends the fallback to interface strings and config translations when they're
present, but it doesn't require them.

## Install with Composer

From the project root:

```bash
composer require drupal/language_hierarchy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/language_hierarchy -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en language_hierarchy -y
```

Core Language is pulled in automatically if it isn't already on. Enabling the
module creates a small database table (`language_hierarchy_priority`) that it
maintains automatically — you never edit it by hand.

## Verify it worked

Go to **Configuration → Regional and language → Languages**
(`/admin/config/regional/language`). Edit any non-default language and you should
see a new **Translation fallback language** select on its form, and a **Parent**
column with drag handles on the overview. Set a fallback, save, and confirm the
resolved chain with the `drush` command shown in
[Configuration](../configuration/index.md#verifying-the-effective-chain).
