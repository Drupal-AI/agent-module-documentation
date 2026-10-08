# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **`league/commonmark`** PHP library, used to convert Markdown to HTML.
  Composer installs it for you as part of requiring the module.

## Install with Composer

From the project root:

```bash
composer require drupal/markdown_docs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in
`league/commonmark` and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/markdown_docs -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en markdown_docs -y
```

## Set up your documentation folder

Create a `documentation/` directory containing your `.md` files (see the structure
example in the [overview](../index.md#configuration-and-permissions)). If you want
to use a different folder, change the module's `docs_path` configuration.

## Grant permissions

At **People → Permissions** (`/admin/people/permissions`) grant **access
markdown_docs** to the roles who should read the docs, and — only if you want
in‑Drupal editing — **administer markdown_docs** to trusted administrators.

## Verify it worked

Visit **`/admin/documentation`**. You should see your documentation landing page
(or an auto‑generated overview if you have no `index.md` yet), with navigation
built from your folder structure and a search box across the docs.
