# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Content Moderation** module (`content_moderation`) and **User** module
  (`user`) — Drupal enables these as dependencies. Content Moderation in turn needs
  the core **Workflows** module.
- No third-party Composer or PHP library requirements.

You will also need at least one content-moderation **workflow** configured on the
entity types/bundles you want to annotate (see Configuration).

## Install with Composer

From the project root:

```bash
composer require drupal/moderation_note -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/moderation_note -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en moderation_note -y
```

After enabling, grant the note permissions to your editorial roles and confirm the
email setting — see [Configuration](../configuration/index.md).
