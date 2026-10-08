# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **Media** module (`media`) enabled — this is the only dependency, and
  Drupal enables it automatically as a dependency when you turn on Override Media
  Options.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/override_media_options -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/override_media_options -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en override_media_options -y
```

## Verify it worked

The module ships no visible feature until you grant its permissions. To confirm
the install, go to **People → Permissions** and search for "media" — you should
see the new per‑field override permissions listed under Override Media Options.
Assign the ones you need, then open a media item's edit form as a user in that
role and confirm the extra authoring/publishing fields now appear.

Continue to [Configuration](../configuration/index.md) to assign the permissions
and choose which options are exposed.
