# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Image Optimize** module (`drupal/imageapi_optimize`, `^4`) — Composer installs it as a
  dependency. This is the framework that provides pipelines and the processor plugin type; this
  module only supplies the binary‑based processors.
- **The command‑line optimization tools installed on the server**, for whichever processors you
  intend to use. Nothing runs unless the matching binary is present on the system `$PATH` (or you
  point the processor at its path). See "Install the binaries" below.

There are no additional Composer PHP‑library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/imageapi_optimize_binaries -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Image Optimize and update any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/imageapi_optimize_binaries -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en imageapi_optimize_binaries -y
```

Enabling the module also installs a ready‑made optional pipeline called **Local Binaries**
containing all nine processors — a convenient starting point (see
[Configuration](../configuration/index.md)).

## Install the binaries

The processors are thin wrappers around system tools, so those tools must exist on the server.
Install the ones you plan to use with your OS package manager, for example on Debian/Ubuntu:

```bash
sudo apt-get install jpegoptim libjpeg-turbo-progs optipng pngquant pngcrush advancecomp
```

(`libjpeg-turbo-progs` provides `jpegtran`; `advancecomp` provides `advdef`/`advpng`.) Some
tools, such as `pngout`, are distributed separately. A processor whose binary is missing is
simply skipped and shows *"Command not found"* on the pipeline form, so you can install only the
tools you actually want and ignore the rest.

> **DDEV / containers:** the binaries must be installed **inside** the web container (the same
> environment PHP runs in), not just on your host. In DDEV, add them via a `webimage_extra_packages`
> entry in `.ddev/config.yaml` (or a custom Dockerfile) and `ddev restart`.

## Verify it worked

Go to **Configuration → Media → Image Optimize pipelines**
(`/admin/config/media/imageapi-optimize-pipelines`). The **Local Binaries** pipeline should be
listed. Open it and check the processor summaries — any processor whose binary is installed
shows its options; any whose binary is missing shows *"Command not found"*, telling you which
tools still need installing.
