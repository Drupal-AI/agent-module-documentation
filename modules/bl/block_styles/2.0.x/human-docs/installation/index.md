# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Block** module (`block`) — always available.
- The **Styles API** module (`styles_api`) — this is a contrib dependency that
  provides the style/template-suggestion registration Block Styles builds on.
  Composer installs it for you when you require Block Styles.
- No third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/block_styles -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Styles API
module and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/block_styles -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_styles -y
```

Drupal will enable the Styles API and core Block modules along with it if they are
not already on. The bundled **Clean Wrapper** style is available immediately.

## Optional: the Bootstrap styles submodule

To get ready-made Bootstrap card, collapse, dropdown, modal, and popover styles,
enable the **Block Styles Bootstrap** submodule:

```bash
drush en block_styles_bootstrap -y
```

Its styles then appear in the block-form style picker alongside Clean Wrapper.
(You will want Bootstrap's CSS/JS present in your theme for them to look right.)

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`), configure any placed
block, and look for the **Block Styles Template** section on the form. If it is
there, the module is working. See [Configuration](../configuration/index.md) for how
to apply a style.
