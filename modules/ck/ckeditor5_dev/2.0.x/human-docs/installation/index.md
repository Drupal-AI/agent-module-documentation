# Installation

## Requirements

- **Drupal 10.5, 11, or 12** (`core_version_requirement: ^10.5 || ^11 || ^12`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — this is the only
  dependency.

There are no third‑party Composer or PHP library requirements.

Because this is a development tool, install it as a dev dependency where your
workflow supports it, and only enable it in local or development environments.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_dev -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. To keep it out of production builds, you can require it as
a dev dependency instead:

```bash
composer require --dev drupal/ckeditor5_dev -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor5_dev -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_dev -y
```

## Grant the report permission

The plugin report is protected by the **access ckeditor5 plugin report**
permission. Grant it to the appropriate roles at **Administration → People →
Permissions** (`/admin/people/permissions`).

## Do not deploy it enabled

Disable the module before pushing to production, since the Inspector overlay and
plugin report expose editor internals and configuration:

```bash
drush pmu ckeditor5_dev -y
```

## Verify it worked

Open any content edit form that uses CKEditor 5 — the **CKEditor 5 Inspector**
panel should appear. Then visit **Reports → CKEditor 5 plugins**
(`/admin/reports/ckeditor5-plugins`) to see the list of loaded plugins.
