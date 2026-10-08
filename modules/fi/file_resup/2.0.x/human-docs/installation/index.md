# Installation

## Requirements

File Resumable Upload is lightweight. It needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **File** module (`file`) — part of a standard Drupal install and enabled
  automatically as a dependency.

There are no third-party Composer or PHP library requirements.

> **A note on your server limits:** the whole point of the module is to upload files larger
> than PHP's per-request limits by sending them in small chunks, so those limits don't cap
> the total file size. Just make sure your web server (and any reverse proxy) allows the
> individual chunk requests (a couple of megabytes each by default) and that there's enough
> disk space for the assembled files.

## Install with Composer

From the project root:

```bash
composer require drupal/file_resup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_resup -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_resup -y
```

Enabling the module does not change any field on its own — resumable upload stays off until
you switch it on per field. See [Configuration](../configuration/index.md).

## Submodule — Media Library support

If you want resumable, chunked uploading in the Media Library "Add media" form (not just on
plain file fields), enable the submodule:

```bash
drush en file_resup_media_library -y
```

It requires the base File Resumable Upload module, which is already present once you have
installed it above.
