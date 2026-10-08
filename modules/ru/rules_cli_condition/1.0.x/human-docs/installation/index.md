# Installation

## Requirements

- **Drupal 10.4 or 11.1** (`core_version_requirement: ^10.4 || ^11.1`).
- The **Rules** module (`rules`) — this module contributes a single condition plugin
  to Rules.
- No third‑party Composer libraries or PHP extensions are required.

## Install with Composer

From the project root:

```bash
composer require drupal/rules_cli_condition -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rules_cli_condition -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rules_cli_condition -y
```

## Verify it worked

Go to **Configuration → Workflow → Rules** (`/admin/config/workflow/rules`), edit a
rule, and add a condition. In the **System** group you should now see
**Command‑line environment** available to add.
