# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **File** module (`file`) — enabled automatically as a dependency.
- To use the two built-in optimizers, two command-line tools must be present on
  the server:
  - **jpegoptim** — for JPEG images. See https://github.com/tjko/jpegoptim
  - **pngquant** — for PNG images. See https://pngquant.org/#download

If you plan to register your own optimizer instead, those tools are not required.

> **Note:** This project is **not covered by Drupal's security advisory policy**,
> and it is currently **seeking a new maintainer**. Weigh that before relying on
> it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/images_optimizer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/images_optimizer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Install the command-line tools

The optimizers call external binaries, so they must be installed where PHP can
run them. On a Debian/Ubuntu-based server (including inside a DDEV web container)
you can usually install both with the system package manager, for example:

```bash
sudo apt-get install jpegoptim pngquant
```

> **Using DDEV?** Run the install inside the web container (`ddev ssh`, then
> `sudo apt-get install jpegoptim pngquant`), or add them via a DDEV
> `webimage_extra_packages` entry so they persist across rebuilds.

## Enable the module

```bash
drush en images_optimizer -y
```

## Verify it worked

Go to **Configuration → Media → Images Optimizer**
(`/admin/config/media/images-optimizer`). If the settings form loads and you can
select the JPEG and PNG optimizers, the module is installed. Upload a test JPEG or
PNG and confirm the stored file is smaller than the original — see
[Configuration](../configuration/index.md) for choosing and tuning optimizers.
