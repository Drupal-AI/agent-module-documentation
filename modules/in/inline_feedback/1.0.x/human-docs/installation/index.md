# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No contributed modules are required. The module relies only on Drupal core's
  dialog and `drupalSettings` libraries, plus a small notification library
  (Toastify.js) it loads for you.

> **Note on security coverage.** This project is **not** covered by Drupal's
> security advisory policy. That's fine for an internal editorial tool, but keep
> it in mind and grant its permissions only to trusted staff.

## Install with Composer

From the project root:

```bash
composer require drupal/inline_feedback -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/inline_feedback -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en inline_feedback -y
```

## Verify it worked

Go to **Configuration → Content authoring → Inline Feedback**
(`/admin/config/content/inline-feedback`). If the settings form loads, the module
is installed. Now head to [Configuration](../configuration/index.md) to allow the
roles that should be able to leave and read feedback — until you do, no one will
be able to add comments. Then open a node page and try **Ctrl+Click** on an
element to confirm the feedback dialog appears.
