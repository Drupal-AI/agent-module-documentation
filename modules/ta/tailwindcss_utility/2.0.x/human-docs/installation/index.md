# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 | ^11`).
- Core's **File** module (`file`) — the only module dependency, enabled
  automatically as a dependency.
- To use the Layout Builder integration, core's **Layout Builder** module should be
  enabled on the layouts you want to style.

There are no PHP library or extension requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/tailwindcss_utility -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tailwindcss_utility -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tailwindcss_utility -y
```

## Next steps

Before using it in earnest, choose a rule-storage backend and — importantly — set
the permissions carefully (especially the add-rules API permission). See
[Configuration](../configuration/index.md).

## Verify it worked

After enabling, go to **Appearance → Tailwind** (`/admin/appearance/tailwind`) and
confirm the styles form loads. If you use Layout Builder, edit a layout and check
that a Tailwind class input now appears on section and block forms.
