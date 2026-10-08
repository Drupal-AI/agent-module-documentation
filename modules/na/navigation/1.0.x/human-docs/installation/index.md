# Installation

> **Check core first.** The Navigation feature has been merged into Drupal core
> (from 10.3 onward). If your Drupal version already includes the core
> **Navigation** module, enable that instead — this contrib module is outdated and
> not recommended for new sites. Only install this project if you are on a setup
> where the core module is not available.

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Block** (`block`) and **File** (`file`) modules — enabled automatically
  as dependencies.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/navigation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/navigation -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en navigation -y
```

## Grant permissions

The module provides its own permissions. Under **People → Permissions**, grant
them to the roles that should use and manage the sidebar navigation.

## Verify it worked

Log in as an administrator. The admin interface should now show the left‑aligned,
collapsible sidebar navigation in place of (or alongside) the horizontal toolbar.
If you are on a recent Drupal core that already provides Navigation, prefer the
core module — see the note at the top of this page.
