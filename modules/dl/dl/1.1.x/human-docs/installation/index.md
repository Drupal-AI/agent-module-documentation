# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core **Node**, **File**, **User**, **Views** and **Taxonomy** modules — all part
  of a standard Drupal install and enabled automatically as dependencies.
- A configured **file system**. For restricted documents, set up Drupal's
  **private file scheme** (a private files path in `settings.php` plus the private
  scheme enabled) so files aren't served directly by the web server.

There are no third‑party Composer library or PHP extension requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dl -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/dl -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dl -y
```

## After enabling

1. Grant DL's permissions to the right roles on **People → Permissions** — keep
   upload and document‑management permissions to trusted roles.
2. If any documents should be restricted, confirm your **private file scheme** is
   configured so those files can't be downloaded by URL regardless of listing
   access.

## Verify it worked

Visit **`/documents`** — you should see the document library interface with an
**Upload Document** button. Upload a test document and confirm it appears in the
library and in the admin view at **`/admin/content/documents`**.
