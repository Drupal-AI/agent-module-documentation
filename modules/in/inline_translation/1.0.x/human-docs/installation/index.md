# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- Core's multilingual modules, since this module presents core's translations
  inline: **Language** (`language`) and **Content Translation**
  (`content_translation`). Enable these if they aren't already on.

There are no contributed dependencies and no external libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/inline_translation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/inline_translation -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it along with the core multilingual modules if they aren't already on:

```bash
drush en language content_translation inline_translation -y
```

## Set up core translation

Because Inline Translation surfaces core's translations, complete the standard core
setup first:

1. Add your languages at **Configuration → Regional and language → Languages**.
2. At **Configuration → Regional and language → Content language and translation**,
   turn on translation for the entity types, bundles, and fields you want to
   translate.
3. On **People → Permissions**, grant the relevant core content‑translation
   permissions, plus the permission this module provides, to the appropriate roles.

## Verify it worked

Edit a piece of content whose bundle you marked as translatable. The fields for
your other languages should now appear **inline on the same edit form**, rather
than only on a separate *Translate* tab. If they don't, revisit the **Content
language and translation** settings and confirm the entity type, bundle, and
individual fields are marked translatable.
