# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`). This
  release stream (`8.x-1.x`) does not declare Drupal 11 support, so check the
  project page for a compatible release before using it on Drupal 11.
- Core's **Node** module (`node`) — the only dependency, and part of a standard
  install.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/public_preview -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/public_preview -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en public_preview -y
```

## Grant the permission

Public Preview does the rest through a single permission. Go to **People →
Permissions** (`/admin/people/permissions`) and grant **access preview links
form** to the roles that should be able to create shareable preview links — an
Editor role, for instance. Only grant it to trusted users, since anyone who can
mint a link can expose an unpublished node to the public.

## Verify it worked

As a user with the permission, open any node and visit
`/node/{node}/preview-links` — you should see the form for generating preview
hashes. Generate one, then open the resulting `/node/{node}/preview-link/{hash}`
URL in a private/incognito window (where you're logged out) to confirm the
unpublished node is served to anonymous visitors.
