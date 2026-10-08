# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`;
  the module requires core `^8.7 || ^9 || ^10 || ^11`).

That's it — the module has **no module dependencies**, no third-party Composer
libraries, and no PHP extension requirements. It is optionally aware of Content
Moderation and Workbench Moderation if those happen to be enabled, but neither is
required.

## Install with Composer

From the project root:

```bash
composer require drupal/revision_log_default -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/revision_log_default -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en revision_log_default -y
```

That is the entire setup. There is no configuration, no permissions, and no
settings form. No submodules ship with this project.

## Verify it worked

Edit and save a node **without** typing anything in the revision log message field
(create a new revision if your content type doesn't do so automatically). Open the
node's **Revisions** tab — the new revision should carry an automatically generated
message such as "Updated the Title field" rather than being blank.
