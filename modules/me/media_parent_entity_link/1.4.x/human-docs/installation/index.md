# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Media** module (`media`), enabled — the only dependency, and Drupal
  enables it automatically.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_parent_entity_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_parent_entity_link -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_parent_entity_link -y
```

Core Media is pulled in automatically if it isn't already on.

## Verify it worked

Go to a media bundle's **Manage display**, e.g.
**Structure → Media types → Image → Manage display**
(`/admin/structure/media/manage/image/display`). Click the **cog** on the image
field (formatted as **Image** or **Responsive image**) — you should see a new
**Link to parent entity** checkbox. Turning it on, saving, and then viewing a piece
of content that references the media should make the image link to that content.
See the [overview](../index.md#how-to-use-it) for the full walkthrough. There's no
separate configuration page.
