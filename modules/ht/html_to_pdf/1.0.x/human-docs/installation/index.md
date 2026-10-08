# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Dompdf** PHP library (`dompdf/dompdf`) — this is what actually renders the
  PDF. Installing the module with Composer normally pulls it in, but if it is
  missing you can add it explicitly (see below).

There are no other Drupal module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/html_to_pdf -W
```

If the Dompdf library is not already present, add it too:

```bash
composer require dompdf/dompdf
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/html_to_pdf -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en html_to_pdf -y
```

## Verify it worked

Log in as an administrator and visit **`/admin/config/upload`**. You should see the
HTML upload form. Upload a small, well-formed HTML file — a PDF of that content
should download to your browser. If you get an error instead, the HTML most likely
contains invalid markup or characters that Dompdf could not parse.
