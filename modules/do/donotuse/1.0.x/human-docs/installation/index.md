# Installation

> **Read this first:** the honest recommendation for `donotuse` is *not* to
> install it. It is an empty placeholder module with no functional code — its only
> effect is to pull in Acquia Cohesion as a dependency. This page documents the
> mechanics only for completeness and for anyone who needs to understand a site
> that already has it.

## Requirements

- **Drupal 9.3 or later** (`core_version_requirement: >=9.3`).
- Declares dependencies on **Cohesion** (`cohesion`) and **Cohesion Base Styles**
  (`cohesion_base_styles`), and its Composer manifest requires
  `acquia/cohesion`.

## Install with Composer

If, despite the above, you need it on disk:

```bash
composer require drupal/donotuse -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve the Acquia
Cohesion dependency chain.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/donotuse -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en donotuse -y
```

Enabling it only turns on the declared Cohesion dependencies — the module itself
does nothing.

## Removing it

If you find it enabled and want it gone, first confirm nothing depends on it, then
uninstall and remove it:

```bash
drush pmu donotuse -y
composer remove drupal/donotuse
```

## Verify it worked

There is nothing functional to verify — the module has no UI, routes, or settings.
"Working" here just means it is enabled (or, preferably, that it is absent from
your site).
