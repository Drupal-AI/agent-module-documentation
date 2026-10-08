# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core only — no other module dependencies and no third-party PHP libraries.
- A **Netlify site** with a **build hook** created (Netlify → Site settings → Build
  & deploy → Build hooks), which gives you the build-hook URL the module posts to.

## Install with Composer

From the project root:

```bash
composer require drupal/netlify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/netlify -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en netlify -y
```

## Grant the permission

The module provides its own permission for configuring and triggering builds.
Assign it only to trusted administrators at **People → Permissions**
(`/admin/people/permissions`) — remember that triggering a build is the same as
having the (secret) build-hook URL.

## Verify it worked

After enabling and configuring the build-hook URL (see
[Configuration](../configuration/index.md)), save a piece of content that is set to
trigger builds and confirm in your Netlify dashboard that a new deploy starts.
