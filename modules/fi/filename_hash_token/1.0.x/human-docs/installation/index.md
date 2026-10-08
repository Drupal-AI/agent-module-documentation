# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **File** module (`file`, version 8.8.0 or later) — a declared dependency,
  enabled by default on most sites.

Two modules are useful companions but **not required**:
[File (Field) Paths](https://www.drupal.org/project/filefield_paths) to build
directory paths from the substring token, and
[Token](https://www.drupal.org/project/token) for a UI to browse the tokens.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/filename_hash_token -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/filename_hash_token -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en filename_hash_token -y
```

That's all — there is no configuration step. The tokens are available immediately
anywhere Drupal tokens are accepted.

## Verify it worked

If you have the Token module installed, open its token browser (for example from a
file field's directory setting) and look under the **File** group — you should see
**`[file:name-hash]`** and the **name‑hash‑substring** token listed. Otherwise,
set a file field's **File directory** to a pattern such as
`public://uploads/[file:name-hash-substring:2]` and upload a file; the file should
land in a subdirectory named after the first two characters of its filename hash.
