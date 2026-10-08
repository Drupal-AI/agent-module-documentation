# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **System** module (`system`), which is always present in a Drupal site.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/reviewer_notes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/reviewer_notes -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en reviewer_notes -y
```

## Verify it worked

Go to **People → Permissions** (`/admin/people/permissions`) and grant the notes
permissions to a reviewer role. Then set up a URL rule for a page you want to
review and open that page as a user with the permission — the review overlay should
appear, letting you add an annotated or quick note. See "How to use it" on the
[overview page](../index.md) for the full flow, including the site-wide report and
CSV export.
