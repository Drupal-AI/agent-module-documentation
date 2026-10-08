# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Node** module (`node`), enabled by default — the scanner audits node
  content.
- No third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/accessibility_auto_fixer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/accessibility_auto_fixer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en accessibility_auto_fixer -y
```

## Grant the permissions

At **People → Permissions** (`/admin/people/permissions`):

- **Access accessibility reports** — grant to editors and QA who should view
  findings.
- **Administer accessibility settings** — grant only to trusted roles; it controls
  the scanner configuration.

See the [main guide](../index.md#how-to-use-it) for running a scan and reviewing
results.
