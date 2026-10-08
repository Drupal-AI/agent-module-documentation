# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Content Moderation** module (`content_moderation`) — its only dependency —
  with a workflow applied to the content you want to moderate by link.

Drupal will enable Content Moderation automatically as a dependency. There are no
third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/content_moderation_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_moderation_link -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_moderation_link -y
```

## Verify it worked

As an authenticated user who has permission to perform a given transition, visit a
moderation URL in the form
`/content-moderation-link/process/{target_state}/{entity_type}/{ids}` — for example
`/content-moderation-link/process/published/node/1`. The listed content should move
to the target state. As a user without that transition permission (or while logged
out), the change should be refused or you should be redirected to log in — confirming
the link respects your existing moderation permissions.
