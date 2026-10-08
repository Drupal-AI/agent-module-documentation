# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- No other Drupal modules are required.
- A **RapidAPI account** with access to the
  [Title Case Converter API](https://rapidapi.com/Matt11/api/title-case-converter),
  and the API key it gives you. Signing up requires a credit card; the free tier
  allows around 100 API calls a month.

## Install with Composer

From the project root:

```bash
composer require drupal/titlecasesuggestions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (The Composer package name, `drupal/titlecasesuggestions`,
matches the module's machine name, `titlecasesuggestions`.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/titlecasesuggestions -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en titlecasesuggestions -y
```

## Add your RapidAPI key

The module has **no settings form**. Instead, provide the API key by adding this
line to your site's `settings.local.php` (or `settings.php`):

```php
$config['titlecasesuggestions.settings']['rapidapi_key'] = 'Your RapidAPI TitleCaseConverter Application Key';
```

Replace the placeholder with the key from your RapidAPI account. Until this value
is set, the module cannot reach the title-case service.

## Verify it worked

Create or edit an article, type a lower-case or inconsistently-cased title, and
save (or move focus off the title field). The title should come back rewritten to
the recommended title casing. If nothing changes, double-check that the RapidAPI
key is correct and that you have not exceeded the service's free-tier limit.
