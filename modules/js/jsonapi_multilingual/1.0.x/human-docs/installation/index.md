# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Content Translation** (`content_translation`) and **JSON:API**
  (`jsonapi`) modules.
- For write operations, JSON:API must be in **read-write mode**
  (`jsonapi.settings:read_only = false`), exactly as for core JSON:API.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_multilingual -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonapi_multilingual -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_multilingual -y
```

Drupal enables Content Translation and JSON:API as dependencies if they are not
already on. Make sure your content types are configured for translation and that
you have more than one language enabled, otherwise there are no translations to
work with.

## Verify it worked

With at least two languages enabled and a translated node available, request a
specific translation:

```
GET /jsonapi/node/article/{uuid}?langCode=fr
```

You should get the French translation (or a `404` if it does not exist). Add
`&includeFallback=1` and confirm you now get a `200` with the served language
reported in the `Content-Language` header and the `langcode` attribute. If you plan
to write translations, confirm JSON:API is in read-write mode first.
