# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **AI Translate** module (`ai_translate`, part of the AI ecosystem), which
  performs the translation and where the AI provider/key are set.
- Core's **Content Translation** module (`content_translation`).
- The **Layout Builder Asymmetric Translation** module (`layout_builder_at`),
  which provides the per-language layouts.

Composer pulls these dependencies in. A configured AI provider (with its API key
stored as a secret) is required for the translation to run.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_translate_lb_asymmetric -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in and update the
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_translate_lb_asymmetric -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_translate_lb_asymmetric -y
```

## After enabling

1. Make sure the **AI** / **AI Translate** stack has a provider configured under
   **Configuration → AI** (`/admin/config/ai`), with the API key stored as a
   secret.
2. Enable content translation and asymmetric Layout Builder translation on the
   content type(s) you want to translate.
3. The one-click AI translation action then appears in the Layout Builder /
   translation workflow. Review each machine translation before publishing.
