# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no module dependencies and no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/javascript_scripting -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/javascript_scripting -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en javascript_scripting -y
```

## Lock down permissions immediately

Because this module can execute code, the very first thing to do after enabling it
is to review permissions at **People → Permissions**
(`/admin/people/permissions`). Grant the module's execution permission — and edit
access to any script field — **only to trusted roles**. See the security warning
in the [guide index](../index.md) before using it.

## Verify it worked

Add the module's script field to a bundle you control, author a trivial snippet,
and run it through the field's execute action or with
`drush javascript:execute` (inside DDEV: `ddev drush javascript:execute`). The
output should reflect what your script returned.
