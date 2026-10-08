# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- The **`ffmpeg` executable** installed on the server, reachable from your Drupal
  root so the `ffmpeg` command can run. (This is a system package, not a Composer
  dependency — install it with your OS package manager or ask your host.)
- PHP configured to **allow `exec()`** — the module invokes the binary through
  PHP's `exec()`. If your host disables `exec()`, the module cannot work.

If you are unsure whether the binary or `exec()` are available, check with your
server administrator or hosting provider. On DDEV you can confirm the binary is
present inside the container with `ddev exec 'command -v ffmpeg'`.

## Install with Composer

From the project root:

```bash
composer require drupal/ffmpeg_image_toolkit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. There are no additional module dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ffmpeg_image_toolkit -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ffmpeg_image_toolkit -y
```

## Verify it worked

Go to **Configuration → Media → Image toolkit**
(`/admin/config/media/image-toolkit`). FFmpeg should now appear as a selectable
toolkit option alongside the default (usually GD). Enabling the module does **not**
switch your site to it — selecting it is a deliberate step covered in
[Configuration](../configuration/index.md).
