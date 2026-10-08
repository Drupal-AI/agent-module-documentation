# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- The **`pixel418/markdownify`** PHP library, which does the HTML‑to‑Markdown
  conversion. Composer installs it for you when you require the module.

There are no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/markdownifier -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in
`pixel418/markdownify` and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/markdownifier -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en markdownifier -y
```

## Verify it worked

There is no settings page to check. Instead, go to the **Manage display** of an
entity that has an **Entity reference** (or **Entity reference revisions**) field —
the format dropdown for that field should now offer **Render entity to Markdown**
(or **Render entity revision to Markdown**). See the
[overview](../index.md#how-to-use-it) for how to apply it.
