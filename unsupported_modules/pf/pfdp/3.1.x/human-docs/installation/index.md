# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other contrib modules, Composer libraries or PHP extensions are required.
- **Drupal's private file system must be configured.** The module only affects
  files served through the private stream, so `$settings['file_private_path']`
  must be set in `settings.php` and the files you want to protect must be stored
  privately (see below).

## Install with Composer

The project's package name differs from the module's machine name — install it
with the full name:

```bash
composer require drupal/private_files_download_permission -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/private_files_download_permission -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

The enabled module's machine name is **`pfdp`** (all its routes, permissions and
config use `pfdp`), so enable it as:

```bash
drush en pfdp -y
```

## Set up the private file system (prerequisite)

For the module to do anything, private files must actually be in use:

1. In `settings.php`, set the private path, for example:

   ```php
   $settings['file_private_path'] = '../private';
   ```

2. Make sure the fields whose files you want to protect upload to the **private**
   file system (either by setting the site default file scheme to private, or by
   configuring individual file/image fields to use a private destination).

Public files are never checked by this module.

## Grant permissions

The module defines three permissions. Assign them at **People → Permissions**, or
from the CLI:

```bash
# lets a role manage the module's directories and settings:
drush role:perm:add file_admin 'administer pfdp'
# optional: unconditional download access to all private directories:
drush role:perm:add trusted 'bypass pfdp'
# optional: unconditional access to temporary files (e.g. image derivatives):
drush role:perm:add support 'bypass pfdp for temporary files'
```

## First-run note: save the settings form once

In version 3.1.x there is a packaging quirk: the module's settings object does
**not** exist until you save the Settings form once. Until then, all behavioural
settings read as "off" (by-user access disabled, downloads served inline, no
logging), which is a safe default but may not be what you expect. After enabling
the module, visit
`/admin/config/media/private-files-download-permission/settings` and click **Save
configuration** once to create the settings object.

## Verify it worked

Log in as a user with **Administer Private files download permission** and go to
**Configuration → Media → Private files download permission**
(`/admin/config/media/private-files-download-permission`). You should see the
(initially empty) directory list with an **Add** button. Head to
[Configuration](../configuration/index.md) to register your first directory.
