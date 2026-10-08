# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **User** (`user`), **Field** (`field`), and **REST** (`rest`) modules —
  REST also pulls in core's Serialization module. These are enabled automatically
  as dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/emoji_reactions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/emoji_reactions -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en emoji_reactions -y
```

Drush enables the core User, Field, REST, and Serialization dependencies
automatically. Six default emojis are installed and ready to use.

## Verify it worked

Log in as an administrator, edit a content type under **Structure → Content types
→ *(your type)* → Manage fields**, and confirm that **Emoji Reaction** appears as
a field type you can add. Then continue with
[Configuration](../configuration/index.md) to attach the field, choose a layout,
and set permissions.
