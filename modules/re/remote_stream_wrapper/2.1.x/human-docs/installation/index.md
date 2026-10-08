# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- PHP's **cURL** extension must be installed and enabled. The module checks for it
  on install and **blocks installation** if it's missing, because the HTTP stream
  wrapper relies on it to fetch remote files. (cURL is present in almost every
  standard PHP setup, including DDEV's.)

There are no module dependencies beyond Drupal core, and no third‑party Composer
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/remote_stream_wrapper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/remote_stream_wrapper -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en remote_stream_wrapper -y
```

Or enable **Remote Stream Wrapper** on the **Extend** page (`/admin/modules`).

That's all — there is nothing to configure. As soon as it's enabled the
`http`/`https` schemes are live and the helper functions are available. See
[How to use it](../index.md#how-to-use-it) for the common code patterns.

> **Note:** enabling the module changes the `image_style` entity class site‑wide so
> that image styles can handle remote originals. This is expected and needs no
> action from you.

Remote Stream Wrapper has no submodules.
