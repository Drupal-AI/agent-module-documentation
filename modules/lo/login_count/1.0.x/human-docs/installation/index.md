# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **User** module (enabled by default) — the only dependency.
- Core's **Views** module, if you want to display the count (it's part of core).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/login_count -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/login_count -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en login_count -y
```

Counting begins immediately — there is nothing to configure.

## Verify it worked

Log in with a test account once or twice, then edit a user‑based view
(**Structure → Views**), add the **Login Count** field, and confirm the tally
reflects the logins. The field should be available without needing any aggregation
or relationship.
