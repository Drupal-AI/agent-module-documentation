# Installation

## Requirements

- **Drupal 11.3 or newer, or Drupal 12** (`core_version_requirement:
  ^11.3 || ^12`).
- Core's **User** module (`user`), which is part of every standard Drupal install
  and is enabled automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/context_profile_role -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/context_profile_role -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en context_profile_role -y
```

## Verify it worked

Edit any block (for example at **Structure → Block layout**) and open its
**Visibility** settings. You should see a new **User Profile Role** condition with
a checklist of your site's roles. That confirms the condition plugin is available.
