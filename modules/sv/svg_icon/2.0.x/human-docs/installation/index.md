# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3||^10||^11`).
- Core's **File** module (`file`), which Drupal enables automatically as a
  dependency.
- No third-party Composer packages or PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/svg_icon -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/svg_icon -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en svg_icon -y
```

## After enabling — mind the security caveat

Before granting the SVG upload permission to anyone but fully trusted
administrators, review the security notes in the [main guide](../index.md): SVG files
can carry embedded JavaScript, so uploaded SVGs served inline from your origin are a
stored-XSS risk. Restrict the upload permission to trusted roles, and make sure your
site sanitizes SVGs or serves them in a non-executing way before opening uploads
more widely.

## Verify it worked

Go to **Manage fields** on any content type and click **Add field**. With the module
enabled, the SVG Icon field type should appear in the list of available field types.

> **Note:** This release is a beta (2.0.0-beta2). Review it before relying on it in
> production.
