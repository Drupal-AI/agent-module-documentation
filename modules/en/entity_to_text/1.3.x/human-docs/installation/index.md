# Installation

## Requirements

- **Drupal 10.4, 11, or 12** (`core_version_requirement: ^10.4 || ^11 || ^12`).
- The base module requires the **`ezyang/htmlpurifier`** PHP library, pulled in
  automatically by Composer.
- The **Entity to Text Paragraphs** submodule additionally requires the
  **Paragraphs** module (`drupal/paragraphs`).
- The **Entity to Text Tika** submodule additionally requires the
  **`vaites/php-apache-tika`** PHP library (and a reachable Apache Tika service to
  extract text from files).

## Install with Composer

From the project root:

```bash
composer require drupal/entity_to_text -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_to_text -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_to_text -y
```

## Submodules

Enable only the submodules you need:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Entity to Text Paragraphs** | `entity_to_text_paragraphs` | Extracts plain text from Paragraphs content. Requires the Paragraphs module. |
| **Entity to Text Tika** | `entity_to_text_tika` | Extracts plain text from uploaded files via Apache Tika. Requires the `vaites/php-apache-tika` library and a Tika service. |

For example, to add Paragraphs support:

```bash
drush en entity_to_text_paragraphs -y
```

## Verify it worked

After enabling, confirm the module appears in **Extend**
(`/admin/modules`) and is checked. Because this is an API module with no UI, the
real test is calling its services from your own code — see the project's code
examples for a complete usage sample.
