# Installation

## Requirements

- **Drupal 11 or 12** (`core_version_requirement: ^11 || ^12`).
- No other modules are required. If you want to test how it interacts with inline
  errors, core's **Inline Form Errors** (`inline_form_errors`) module can be
  enabled — the settings form has an option to disable it on the showcase page.

There are no third‑party Composer or PHP library requirements. The module has no
security‑advisory coverage, which is consistent with it being a development‑only
tool.

> **Do not enable on production.** The showcase page is reachable by anyone with
> the `access content` permission. Install it on local development and staging
> environments only.

## Install with Composer

From the project root:

```bash
composer require drupal/form_style -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/form_style -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en form_style -y
```

## Verify it worked

Visit **`/admin/form_style`**. You should see a page full of form elements
rendered in the site's front‑end theme. Submit it and every element should show a
validation error — that's the tool working as intended. To tune its behaviour,
see [Configuration](../configuration/index.md).

When you're finished testing, remember to **uninstall** it before deploying to
production:

```bash
drush pmu form_style -y
```
