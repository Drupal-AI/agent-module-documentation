# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Filter** module (`filter`) — this is the only dependency, and Drupal
  enables it automatically (it is on by default on virtually every site).
- No third‑party PHP libraries are required.
- Optionally, **Select2** is recommended to give a nicer UI when choosing from a
  large list of libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/library_attach -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/library_attach -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en library_attach -y
```

There are no submodules.

## Verify it worked

1. Confirm **Library attach** is enabled on **Extend** (`/admin/modules`).
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`), edit a format, and confirm the Library
   attach filter appears in the **Enabled filters** list.
3. With a library that declares a `filter-selector-css`/`filter-selector-xpath`,
   add matching markup to a piece of content using that format, view it, and check
   the page source: the library's assets should be present only on that page.

Because there is no standalone settings form, everything is done on the text
format — see the module's [main page](../index.md), and mind the security note
there about restricting which libraries can be attached.
