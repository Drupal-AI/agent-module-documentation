# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field** module (`field`) and **Media** module (`media`) — enabled automatically
  as dependencies.

There are no third‑party Composer or PHP library requirements.

> **A note on maintenance status:** at the time of documentation this module is marked
> **Unsupported** on drupal.org and receives maintenance fixes only. Review its current
> status and test it on your site before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/media_auto_publication -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_auto_publication -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_auto_publication -y
```

That's all — there is no configuration step. The behavior is active immediately for all
fieldable publishable entities.

## Verify it worked

Create a node in an **unpublished** state that references an **unpublished** media item, then
**publish** the node and save. The referenced media should now be published too — check it on
the media's own page or by viewing the node as an anonymous visitor and confirming the media
renders. See the note in the [overview](../index.md) about the unconditional publish
behavior if you use content moderation on media.
