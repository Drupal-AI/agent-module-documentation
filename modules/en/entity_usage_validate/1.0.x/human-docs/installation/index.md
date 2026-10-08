# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- The **Entity Usage** module (`entity_usage`) enabled — it is a hard dependency
  and supplies the reference data the warning is based on.
- A site that uses **media** referenced from nodes (otherwise there is nothing to
  check).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_usage_validate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Entity Usage and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_usage_validate -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_usage_validate -y
```

That is all — there is no configuration step. The publish-time warning is active
immediately.

## Verify it worked

Create or edit a node so that it embeds a media item that is **unpublished**,
mark the node as **published**, and save. You should see a warning message at the
top of the page naming the unpublished media (title and ID). Publish that media,
save again, and the warning should be gone.
