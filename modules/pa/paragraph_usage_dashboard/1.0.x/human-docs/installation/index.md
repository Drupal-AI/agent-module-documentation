# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- **PHP 8.1 or newer**.
- The **Paragraphs** module (`paragraphs`).
- Core's **Path Alias** module (`path_alias`), used to show human‑readable URLs in
  the dashboard.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraph_usage_dashboard -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Paragraphs and
update any shared dependencies as needed. (Path Alias is part of Drupal core.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraph_usage_dashboard -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraph_usage_dashboard -y
```

## Grant the permission

The module adds an **Access paragraph usage dashboard** permission, which controls
who can view the dashboard and its detail pages. Go to **People → Permissions**
(`/admin/people/permissions`), grant it to the roles that should see the report
(typically administrators or site builders), and save.

## Verify it worked

As a user with the permission, go to **Reports → Paragraph Usage**
(`/admin/reports/paragraph-usage`). The dashboard should load and show your
paragraph types with usage badges, icons, and the content types that use them. If it
appears and lists your types, the module is working.
