# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9||^9||^10||^11`).
- The **2.x** line builds on `page_manager` and core **Layout Builder**; Composer
  and Drupal resolve the modules it needs when you install and enable it.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/drowl_admin_dashboard -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/drowl_admin_dashboard -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drowl_admin_dashboard -y
```

## Grant access

The dashboard provides one permission, **Access Admin Dashboard**. Give it to the
roles that should see the overview screen:

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Find **Access Admin Dashboard** and tick the box for each role that maintains
   the site (for example an *Editor* or *Site manager* role).
3. Click **Save permissions**.

## Verify it worked

Log in as a user who holds the **Access Admin Dashboard** permission. They should
now land on — or be able to reach — the administrative dashboard, showing the
overview of content, configuration, and status entry points.
