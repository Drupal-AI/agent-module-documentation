# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- **PHP 8.3 or newer** (`php: >=8.3`).
- The **`sabberworm/php-css-parser`** library (`^9.0`), used by the stylesheet
  generator. Composer installs it automatically.

The base module has no Drupal module dependencies of its own. Individual
submodules depend on the systems they integrate with (for example
`ui_styles_layout_builder` needs Layout Builder, `ui_styles_ckeditor5` needs
CKEditor 5).

## Install with Composer

From the project root:

```bash
composer require drupal/ui_styles -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the php-css-parser
library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ui_styles -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ui_styles -y
```

On its own, the base module only provides style discovery and the reusable
selector — it has no admin page. To actually apply styles somewhere you need to
enable at least one integration submodule and provide some style definitions.

## Enable the submodules you need

Turn on the integration points you want (see the table in the
[overview](../index.md#submodules--enable-only-what-you-need)):

```bash
drush en ui_styles_block ui_styles_layout_builder ui_styles_library -y
```

Each submodule requires the base UI Styles module, which is already present once
you have installed it above.

## Verify it worked

After enabling a submodule such as `ui_styles_block`, edit any block and look for a
**Styles** section in its settings form. If your theme or a module ships a
`*.ui_styles.yml` file, its options appear there. (If you just added a YAML file,
run `drush cr` first, since discovery is cached.)
