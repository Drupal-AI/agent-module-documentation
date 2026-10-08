# Installation

## Requirements

- **Drupal 11.1+** (`core_version_requirement: ^11.1`) — it uses OOP hook
  implementations via the `#[Hook]` attribute.
- Core's **Layout Builder** (`layout_builder`), **Content Translation**
  (`content_translation`), and **Language** (`language`).
- **Layout Builder Asymmetric Translations** (`layout_builder_at`) — a contributed
  module that provides the per-translation layout storage this module seeds into.
  It is a hard dependency: without it (and the field-translatability step below)
  all translations share one stored layout and seeding has no observable effect.

## Install with Composer

From the project root:

```bash
composer require drupal/lb_translation_seed -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in
`layout_builder_at` and any other shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/lb_translation_seed -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lb_translation_seed -y
```

Enabling it also enables `layout_builder_at` and the core translation modules if
they are not already on.

## Post-installation setup

Two steps are essential before seeding will do anything:

1. **Enable Layout Builder with overrides** on each bundle's default display where
   you want translatable layouts.
2. **Make the Layout field translatable.** With `layout_builder_at` enabled, go to
   **Configuration → Regional & language → Content language and translation**
   (`/admin/config/regional/content-language`), expand the relevant bundle, tick
   the **Layout** checkbox under "Fields to translate," and save.

Then define your seeding rules — see [Configuration](../configuration/index.md).

## Verify it worked

Once a rule exists, create a translation of an existing Layout Builder page in the
target language. The layout should be populated automatically from the source
language rather than starting blank.
