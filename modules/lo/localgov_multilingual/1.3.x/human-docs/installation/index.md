# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A **LocalGov Drupal** site. This module configures translation for LocalGov
  content types, so it expects those content types (and the distribution) to be
  present rather than bare Drupal core.
- Drupal's core **Content Translation**, **Language** and related multilingual
  modules — Drupal enables what it needs as dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_multilingual -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_multilingual -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_multilingual -y
```

## Submodules — enable one per content type

The base module does the shared groundwork; each submodule turns on multilingual
for a specific LocalGov content type. Enable only the ones matching the content you
publish in more than one language:

| Submodule | Content type it makes translatable |
|-----------|-------------------------------------|
| `localgov_multilingual_alert_banners` | Alert banners |
| `localgov_multilingual_blogs` | Blogs |
| `localgov_multilingual_directories` | Directories |
| `localgov_multilingual_events` | Events |
| `localgov_multilingual_guides` | Guides |
| `localgov_multilingual_news` | News |
| `localgov_multilingual_services` | Services |
| `localgov_multilingual_step_by_step` | Step‑by‑step |
| `localgov_multilingual_subsites` | Subsites |

For example, to enable multilingual for services and news:

```bash
drush en localgov_multilingual_services localgov_multilingual_news -y
```

## Verify it worked

Add at least one extra language at **Configuration → Regional and language →
Languages**, then open a piece of content of an enabled type. You should see a
**Translate** tab on the node, from which you can add a translation in each
language you configured.
