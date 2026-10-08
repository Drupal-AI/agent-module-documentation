# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Content Moderation** module (`content_moderation`) enabled — this is
  the only dependency. Drupal will enable it (and its own dependency, Workflows)
  automatically if it isn't already on.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/content_moderation_permissions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_moderation_permissions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_moderation_permissions -y
```

## Verify it worked

You need an existing Content Moderation workflow applied to at least one content
type for the new permissions to appear. Once that's in place, go to **People →
Permissions** (`/admin/people/permissions`) and look in the Content Moderation
section. Alongside core's transition permissions you should now see entries
scoped to a specific content type — for example *"Use the Publish transition of
the Editorial workflow for Article"*. Their presence confirms the module is
working. See the main guide's [How to use it](../index.md#how-to-use-it) section
for assigning them.
