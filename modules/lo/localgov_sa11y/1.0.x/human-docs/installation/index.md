# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A **LocalGov Drupal** site — the module is oriented toward the distribution,
  though its accessibility‑checking job is self‑contained.

There are no other module dependencies and no third‑party PHP library requirements —
the Sa11y checker itself is bundled.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_sa11y -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_sa11y -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_sa11y -y
```

## Grant the widget permission

Decide who should see the checker. At **People → Permissions**
(`/admin/people/permissions`), grant **Use LocalGov Sa11y** (`use_localgov_sa11y`)
to your editorial roles. Do **not** grant it to anonymous users — the audit overlay
is meant for editors, not the public.

## Verify it worked

Log in as a user with the **Use LocalGov Sa11y** permission and visit any page on
your site that uses the **front‑end** theme (not an admin page). The **Sa11y**
accessibility widget should appear in the bottom‑right corner of the page.
