# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Image** module (`image`) — the only dependency, and Drupal enables it
  automatically.

Note this is a **beta** release (8.x‑1.0‑beta5). It is covered by Drupal's security
advisory policy, but test it before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/image_hotspots -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_hotspots -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_hotspots -y
```

## Grant the permission

Hotspot creation, editing and deletion is gated by a single permission. Go to
**People → Permissions** (`/admin/people/permissions`), find **Edit image
hotspots**, tick it for the roles that should be able to annotate images, and save.

Remember this permission is **per‑site**, not per‑image — anyone holding it can
annotate any image the site displays.

## Verify it worked

As a user with the **Edit image hotspots** permission, view a page that shows an
image through an image field. You should be able to place a labelled point on the
image and have it persist. If you can't see any editing affordance, re‑check that
the permission is granted to that user's role.
