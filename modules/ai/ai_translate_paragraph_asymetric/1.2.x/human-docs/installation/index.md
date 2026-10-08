# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **AI Translate** module (`ai_translate`, part of the AI ecosystem), which
  provides the translate service this module calls and where the AI provider and
  credentials are configured. Composer pulls it in as a dependency.
- A configured AI provider with its API key stored as a secret.

There are no additional third-party PHP library requirements. The current
release is `1.2.2`.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_translate_paragraph_asymetric -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in and update the
AI Translate dependency as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine —
> `ddev composer require drupal/ai_translate_paragraph_asymetric -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_translate_paragraph_asymetric -y
```

## After enabling

1. Make sure the **AI** / **AI Translate** stack has a provider configured under
   **Configuration → AI** (`/admin/config/ai`), with the API key stored as a
   secret.
2. Enable content translation on the paragraph-based content type(s) you want to
   translate.
3. The one-click AI translate action then appears in the content Translate
   workflow. Access follows Drupal's standard translation permissions. Review
   machine translations before publishing.
