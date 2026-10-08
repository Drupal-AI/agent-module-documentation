# Installation

## Requirements

- **Drupal 10.2, 11, or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- Core **Block** (`block`).
- **Social Media Links** (`social_media_links`) — provides the actual block.

There are no third-party PHP-library requirements, and this feature has no
Drutopia Core dependency of its own — it is a standalone convenience wrapper.

## Install with Composer

From the project root:

```bash
composer require drupal/drutopia_social -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Social Media
Links module alongside the feature.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/drutopia_social -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drutopia_social -y
```

This enables the module and its Social Media Links dependency, making the social
media links block available to place.

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and confirm a
**Social Media Links** block is available to place. Add it to a region, configure
a network or two, and check that the icons render on the front end.
