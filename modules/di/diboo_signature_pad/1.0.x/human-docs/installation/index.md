# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Module dependencies (Composer resolves these automatically):
  - **Diboo core** (`diboo_core`) — the base Diboo module this add-on extends.
  - **Signature Pad** (`signature_pad`) — the underlying signature-pad widget.

## Install with Composer

Installing with Composer is recommended so the dependencies are pulled in for you.
From the project root:

```bash
composer require drupal/diboo_signature_pad -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/diboo_signature_pad -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en diboo_signature_pad -y
```

Enabling this module also enables its dependencies, Diboo core and Signature Pad.

## Verify it worked

With the module enabled, Diboo image chain links will use the signature pad widget
for drawing — there is no configuration step. Try creating or contributing to an
image chain link in your Diboo setup and confirm the drawing canvas appears.
