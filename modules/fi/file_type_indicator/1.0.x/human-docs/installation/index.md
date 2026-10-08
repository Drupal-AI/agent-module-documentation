# Installation

## Requirements

- **Drupal 9.4+ or 10** (`core_version_requirement: ^9.4 || ^10`).
- Core's **Filter** module (`filter`) — enabled automatically as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/file_type_indicator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_type_indicator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_type_indicator -y
```

## Turn on the filter

Enabling the module does not change any content on its own — you must add the
filter to a text format:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. **Configure** a text format, tick **"Add icon to file link, depends on its
   extension"** under Enabled filters, set the comma-separated extension list
   (default `pdf,doc,zip`), and **Save configuration**.

See the [overview](../index.md) for the full walk-through.

## Verify it worked

Create or edit a piece of content that uses the text format you configured, and
include a link to a file with one of the configured extensions (for example a
`.pdf`). When you view the content, the link should now display the matching
file-type icon.
