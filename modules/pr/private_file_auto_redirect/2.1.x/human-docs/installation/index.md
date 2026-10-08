# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **PHP 8.1** or newer.
- Core's **Media** module (`media`) — this is the only dependency, and Drupal
  enables it automatically if it isn't already on.
- A configured **private file system**. The module only acts on files served from
  the private file stream; if your files are public, there is nothing for it to
  redirect.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/private_file_auto_redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/private_file_auto_redirect -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en private_file_auto_redirect -y
```

That's the whole setup. There is no configuration form, no permissions to grant,
and no new routes to expose — the module swaps in its own private-file download
controller as soon as it is enabled.

## Verify it worked

1. On a media entity that uses a private file, replace the source file with a new
   upload (a new revision that points at a different file).
2. Request the **old** file's private-download URL in your browser.
3. Instead of a 404, you should be redirected to the current file. The redirect
   still enforces private-file access, so you'll only receive the bytes if you're
   permitted to.

If a file isn't referenced by any media entity, or the latest revision still
points at the same file, you'll get the normal core behaviour — that's expected.
