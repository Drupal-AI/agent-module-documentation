# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Pluginreference** module
  ([`drupal/pluginreference`](https://www.drupal.org/project/pluginreference)) —
  a hard dependency used to reference overview plugins from a field.
- **Optional:** the **Paragraphs** module
  ([`drupal/paragraphs`](https://www.drupal.org/project/paragraphs)). When it is
  enabled, Overview Builder can create a ready‑made "overview" paragraph type for
  you.

## Install with Composer

From the project root:

```bash
composer require drupal/overview_builder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Pluginreference
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/overview_builder -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en overview_builder -y
```

Enable Paragraphs first (or alongside) if you want the shipped "overview"
paragraph type:

```bash
drush en paragraphs overview_builder -y
```

## Enable the example submodule (recommended for developers)

Overview Builder is a coding tool, and the `overview_builder_example` submodule is
the quickest way to see a working overview plugin and copy its structure:

```bash
drush en overview_builder_example -y
```

## Verify it worked

After enabling, the `overview_builder` plugin type is available to your code.
If you enabled Paragraphs, check **Structure → Paragraphs types**
(`/admin/structure/paragraphs_type`) for the new "overview" paragraph type. If
you enabled the example submodule, its sample overview plugin will be discoverable
when you add an overview field.
