# Installation

## Requirements

Language Fallback Fix is deliberately tiny. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- A multilingual site — that is, core's **Language** module with more than one
  language configured, so that fallback is a meaningful concept.

There are no third‑party Composer or PHP library requirements, and no other
contrib module is required to *install* it. To get any benefit, though, you will
pair it with a module that consumes the Language Fallback API — Search API is the
main one.

## Install with Composer

From the project root:

```bash
composer require drupal/language_fallback_fix -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/language_fallback_fix -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en language_fallback_fix -y
```

That's all it takes. There is no required configuration.

## Verify it worked

The module has no visible interface, so the check is indirect. Confirm it appears
as enabled on the **Extend** page (`/admin/modules`), then verify that whatever
you installed it *for* now behaves correctly — for example, that Search API can
index content in languages that lack a full fallback chain. While you are there,
review your language fallback order under **Configuration → Regional and language
→ Languages** to make sure it matches what you want visitors to see for
untranslated content.
