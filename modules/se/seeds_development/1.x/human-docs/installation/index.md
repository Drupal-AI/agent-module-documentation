# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No third-party PHP libraries or extra modules are required. The features build on
  Drupal core's Image Styles and content-type form-display screens.

This is **developer tooling** — enable it only in development, integration, or QA
environments, never on production.

## Install with Composer

From the project root:

```bash
composer require drupal/seeds_development -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Consider requiring it as a dev-only dependency
(`composer require --dev …`) so it does not ship to production.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/seeds_development -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en seeds_development -y
```

You can also enable it from **Extend** (`/admin/modules`). **Do not enable it on
production** — disable it again before deploying, as dev tools can expose diagnostic
detail and are not hardened for a live site.

## Verify it worked

After enabling in a development environment:

- Go to **Media → Image Styles** (`/admin/config/media/image-styles`) and look for the
  **Unused Images** action and the per-style **Operations** usage links.
- Go to **Structure → Content types**, open any type's **Manage Form Display**, and
  confirm the **Generate Field Groups** button appears.
