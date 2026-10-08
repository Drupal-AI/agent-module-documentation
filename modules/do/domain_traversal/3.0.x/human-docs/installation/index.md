# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9.0||^10.0||^11.0`).
- The **Domain** module (`domain`) — this is a hard dependency, since Domain
  Traversal only makes sense on a Domain Access multi‑domain site. Install and
  configure Domain first.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_traversal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/domain_traversal -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain_traversal -y
```

If Domain is not yet enabled, Drupal will prompt to enable it as a dependency.

## Verify it worked

Log in as an administrator on a multi‑domain site. Grant the Domain Traversal
permissions to the roles that need cross‑domain navigation (on the
**People → Permissions** page), then confirm that per‑domain menu items appear and
that clicking one takes you to the corresponding domain already logged in.
