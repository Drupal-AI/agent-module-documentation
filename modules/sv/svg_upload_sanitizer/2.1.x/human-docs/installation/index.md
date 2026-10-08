# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or higher** (`php: ^8.1`).
- Core's **File** module (`file`), which is part of the standard install and is
  enabled automatically as a dependency.
- The **`enshrined/svg-sanitize` `~0.22`** Composer package — the sanitiser
  library this module wraps. Composer installs it for you as a dependency (see
  below).

Note that this project is **not covered by Drupal's security advisory policy**, so
weigh that when deciding whether to rely on it, and keep the sanitiser library
updated.

## Install with Composer

From the project root:

```bash
composer require drupal/svg_upload_sanitizer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the
`enshrined/svg-sanitize` library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/svg_upload_sanitizer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en svg_upload_sanitizer -y
```

That is all it takes. From now on, every SVG uploaded through Drupal is sanitised
automatically before it is stored — there is no configuration step.

## Verify it worked

Upload a test SVG that contains a `<script>` element through any SVG‑capable file
or image field, then look at the stored file: the script and any event handlers
should be gone, while the visible graphic is preserved. Remember this only cleans
files uploaded through Drupal — files copied onto the server by other means are
not touched.
