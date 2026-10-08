# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- The **Embedded Content** module (`embedded_content`) — the framework this module
  plugs into.
- The **CL Editorial** module (`cl_editorial`).

Both dependencies are pulled in automatically when you install this module with
Composer. There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/embedded_content_sdc -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Embedded
Content and CL Editorial dependencies and update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/embedded_content_sdc -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it together with its dependencies:

```bash
drush en embedded_content_sdc -y
```

Drush enables `embedded_content` and `cl_editorial` automatically as
dependencies.

## Verify it worked

With the modules enabled, your site's SDC components become available to the
Embedded Content framework. Configure the Embedded Content button on a text
format's CKEditor toolbar, then edit a piece of content and confirm you can insert
an SDC component and see it render. See the
[main guide](../index.md#how-to-use-it) for the editor workflow.
