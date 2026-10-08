# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- No module dependencies and no third‑party Composer or PHP library requirements.

> **Heads up:** This project is **not covered by Drupal's security advisory
> policy**. Weigh that before using it on a production site, and apply the
> safe‑setup checklist below.

## Install with Composer

From the project root:

```bash
composer require drupal/files_upload -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/files_upload -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en files_upload -y
```

You can also enable it from the UI at **Extend** (`/admin/modules`).

## Safe‑setup checklist

Because this is a file‑upload feature, its security depends on Drupal's
server‑side validation. Before letting anyone use it:

- **Restrict allowed file extensions** to what you actually need — never allow
  executable or script types.
- **Enforce size limits** to prevent abuse of disk space.
- **Store sensitive or non‑public files in the private file system** so they are
  not directly served or executed from the web root.
- **Restrict who can upload** to trusted roles.

## Verify it worked

Log in as an administrator and visit **`/admin/content/files`** (under
**Content**). You should see the Files Upload interface. Upload a test file to
confirm it works, then remove it if you don't need it.
