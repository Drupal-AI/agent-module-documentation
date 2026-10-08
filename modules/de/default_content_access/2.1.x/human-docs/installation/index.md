# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Default Content** module (`default_content`) — provides the export/import
  of content this module hooks into.
- The **Content Access** module (`content_access`) — provides the per‑node /
  per‑type access settings this module carries along.
- **Note:** for now the `default_content` module must be patched with issues
  **[#2640734]** and **[#2698425]** for export/import to work fully. Check the
  project page for the current status.

There are no additional PHP or front‑end library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/default_content_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Default Content and
Content Access and update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/default_content_access -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en default_content_access -y
```

Enabling it pulls in Default Content and Content Access automatically if they are
not already on. Remember to apply the required `default_content` patches (see
Requirements).

## Verify it worked

On a source site, set Content Access permissions on a node, export it with Default
Content, and inspect the exported files — the Content Access settings should now be
included alongside the content. Then import that content into a fresh site and
confirm the same access rules are reproduced there without you re‑applying them by
hand. Review the exported access settings before shipping them in a recipe or
install profile.
