# Installation

## Requirements

- **Drupal 11.4.2+ or 12** (`core_version_requirement: ^11.4.2||^12`).
- Core's **Interface Translation** module (`locale`) — enabled automatically as a
  dependency.
- For the custom‑translations command to find your strings, your **custom code
  should live in `modules/custom`**.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/locale_deploy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/locale_deploy -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en locale_deploy -y
```

## Verify it worked

Confirm the Drush commands are available:

```bash
drush list | grep locale-deploy
```

You should see `locale-deploy:localize-translations` and
`locale-deploy:custom-translations`. Running the localize command will fetch
translations into your local translations folder and export configuration; check
that the expected files appear (and show up in `git status`) afterwards.
