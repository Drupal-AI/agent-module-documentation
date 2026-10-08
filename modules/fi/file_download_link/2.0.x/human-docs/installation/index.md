# Installation

## Requirements

File Download Link is a small display‑only field formatter. It needs:

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **File** module (`file`) enabled — this is the only dependency, and Drupal
  enables it automatically. The formatter works on File and Image fields.

There are no third‑party Composer packages or PHP library requirements.

## Optional: the Token module

The **Token** module (`drupal/token`) is suggested but not required. With it
installed, you can use tokens in the formatter's link text, title, ARIA label, forced
filename, and CSS classes — for example to show a file's description and size. Without
it, plain text still works and the settings form shows a hint recommending Token.

```bash
composer require drupal/token -W
drush en token -y
```

## Install with Composer

From the project root:

```bash
composer require drupal/file_download_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_download_link -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_download_link -y
```

There is no configuration form — enabling the module simply makes the **File Download
Link** formatter available on File and Image fields. Apply it from a field's **Manage
display**, as described in the [overview](../index.md#how-to-use-it).

## Optional submodule — Media fields

If you want the same download‑link behavior on **Media reference** fields, enable the
bundled submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **File Download Link (Media)** | `file_download_link_media` | A `file_download_link_media` formatter for Media reference fields that delegates to the main formatter on the media's source file. |

```bash
drush en file_download_link_media -y
```
