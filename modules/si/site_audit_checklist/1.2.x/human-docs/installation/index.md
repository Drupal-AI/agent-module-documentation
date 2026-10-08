# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- No other modules, PHP libraries, or external services are required.

Note: this project is **not covered by Drupal's security advisory policy**. That does
not mean it is unsafe, but it is something to factor into a production decision.

## Install with Composer

From the project root:

```bash
composer require drupal/site_audit_checklist -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/site_audit_checklist -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en site_audit_checklist -y
```

## Verify it worked

Grant the **`view site audit checklist`** permission (and, for editors,
**`administer site audit checklist`**) to the appropriate roles, then visit
**`/admin/config/development/site-audit`**. You should see the checklist dashboard with
the module's default set of pre-launch tasks. There is no further configuration needed
to start using it.
