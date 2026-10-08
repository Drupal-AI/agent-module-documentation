# Installation

## Requirements

Synapse Helper needs:

- **Drupal 8, 9, 10 or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- The **`idna`** library, which the module depends on for internationalised
  domain-name handling.
- **Drush**, to use the helper commands the module provides.

## Install with Composer

From the project root:

```bash
composer require drupal/synhelper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the `idna`
dependency and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/synhelper -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en synhelper -y
```

## What to expect after enabling

Because Synapse Helper is more than a passive library, enabling it changes a few
things immediately: it adds a **`/privacy-policy`** page, it **blocks installing
modules through the Extend UI** (so you install modules with Composer/Drush
instead), it pre-fills some admin checkboxes, and it surfaces warnings against
certain errors. Keep this in mind on an existing site before enabling it.

## Verify it worked

Confirm the module is enabled at **Extend** (`/admin/modules`), check that its
Drush commands appear in `drush list`, and visit **`/privacy-policy`** to see the
default legal-agreement page. If you later need to remove the module and find it
cannot be uninstalled, check whether it is a dependency of the **synmini**
installation profile and, if so, remove it from
`/profiles/synmini/synmini.info.yml`.
