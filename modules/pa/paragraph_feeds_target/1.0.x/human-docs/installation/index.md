# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **Feeds** (`drupal/feeds`).
- **Paragraphs** (`drupal/paragraphs`).
- **Entity Reference Revisions** (`drupal/entity_reference_revisions`).

## Install with Composer

From the project root:

```bash
composer require drupal/paragraph_feeds_target -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Feeds, Paragraphs
and Entity Reference Revisions and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraph_feeds_target -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraph_feeds_target -y
```

Then rebuild the cache so Feeds picks up the new targets:

```bash
drush cr
```

## Verify it worked

Edit a **Feeds feed type** whose target entity has a paragraph reference field, and
open its **Mapping** tab. In the list of available targets you should now see
paragraph sub‑field targets named like *{host field} {paragraph bundle}
{paragraph field}*. If they appear, the plugin is registered and ready to map.
