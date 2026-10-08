# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`).
- The **Key** module (`key`) — used to store your DeepL API key as a Key entity.
- The **`deeplcom/deepl-php`** PHP library — the official DeepL client library.
- A **DeepL API key** (Free or Pro) from your DeepL account.

Both the Key module and the `deeplcom/deepl-php` library are declared in the
module's `composer.json`, so Composer installs them automatically with the command
below. If you install the module without Composer, you must add them yourself.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_deepl -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the `deeplcom/deepl-php` library and the Key
module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor5_deepl -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_deepl -y
```

Enabling this also enables the Key module if it was not already on.

## Next: configure it

The module does nothing until you supply a DeepL API key and add the DeepL button
to a text format. Continue to [Configuration](../configuration/index.md).

## Verify it worked

After configuration (a stored DeepL key and the DeepL button added to a text
format), open a content edit form using that format, select some text, and click
the **DeepL** button. A translation dialog should appear, and the selected text
should be translated in place.
