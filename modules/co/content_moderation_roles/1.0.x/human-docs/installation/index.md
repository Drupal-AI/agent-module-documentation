# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core modules, all of which Drupal enables automatically as dependencies:
  - **Content Moderation** (`content_moderation`) — provides the workflow and
    state system.
  - **Node** (`node`) — state filtering is applied to node forms.
  - **Views** (`views`) — required for the view query-alteration features.
  - **Workflows** (`workflows`) — used to populate the list of available
    moderation states in the admin UI (enabled automatically with Content
    Moderation).

There are no third‑party Composer or PHP library requirements. If you use
**Layout Builder**, enable the Views sort correction (see
[Configuration](../configuration/index.md)) so pending revisions sort correctly
in content-listing views.

## Install with Composer

From the project root:

```bash
composer require drupal/content_moderation_roles -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_moderation_roles -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_moderation_roles -y
```

## Verify it worked

You need a Content Moderation workflow applied to at least one content type.
Then, as a user with the core **Administer workflows** permission, go
to **Configuration → Workflow → Content Moderation Roles**
(`/admin/config/workflow/content-moderation-roles`). If the settings page loads
with your roles and states listed, the module is working. Continue to
[Configuration](../configuration/index.md) to set up the rules.
