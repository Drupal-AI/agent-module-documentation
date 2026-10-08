# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **System** module (always present). The Webform integration applies only
  if you use Webform.
- For the revision **UI** to work properly, the module notes it depends on the core
  patch from drupal.org issue [#2350939] — apply that patch to core before relying
  on the history screens.

There are no third‑party PHP library requirements. This release is an early beta
(1.0.0-beta1) and is not covered by Drupal's security advisory policy, so test it on
a non‑production copy first.

## Install with Composer

From the project root:

```bash
composer require drupal/config_revision -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_revision -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_revision -y
```

## Verify it worked

After enabling, open the module's admin settings and mark a config entity type as
revisionable. Edit and save one of those config entities, then look for its
revision history — you should see a new revision recorded. If the history screens do
not render as expected, confirm the core patch mentioned under Requirements has been
applied.
