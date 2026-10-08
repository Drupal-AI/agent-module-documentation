# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- Core's **Book** module (`book`) enabled — this is the only module dependency,
  and Drupal will enable it automatically as a dependency.
- A **PDF rendering library/tool**. Generating a PDF from rendered HTML requires
  an underlying PDF engine; the module renders the book tree and produces the
  file, but the actual PDF generation relies on a PDF library being available on
  the server. Check the module's own `README`/`composer.json` for the exact
  library it expects and install that as well if it is not pulled in
  automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/book_pdf -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/book_pdf -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en book_pdf -y
```

There are no submodules.
