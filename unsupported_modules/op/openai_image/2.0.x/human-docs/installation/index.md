# Installation

## Requirements

- **Drupal 11.2 or newer** (`core_version_requirement: ^11.2 || ^11`).
- The **AI** module (`ai`) — AI Image generates images through whatever provider
  you configure there.
- Core **File** (`file`) and **Image** (`image`) modules — part of standard
  Drupal, enabled automatically as dependencies.
- An **image‑capable AI provider** with an API key, configured in the AI module.

## Install with Composer

Note that the Composer package name differs from the module's machine name. From
the project root:

```bash
composer require drupal/openai_image_for_drupal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the AI module and
any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/openai_image_for_drupal -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

The module's machine name is `openai_image`:

```bash
drush en openai_image -y
```

Enable the AI module too if it isn't already:

```bash
drush en ai -y
```

## Configure the AI provider (in the AI module)

AI Image has no credentials form of its own. Configure an image‑capable provider
and its API key (as a **Key** entity) in the **AI** module under **Configuration
→ AI**. Keep the key out of version control; with DDEV:

```bash
ddev dotenv set .ddev/.env --openai-api-key=sk-...
ddev restart
```

then reference that variable from a Key entity.

## Verify it worked

Edit content with an image field, or open the CKEditor 5 editor, and look for the
generate‑from‑prompt option. Enter a short prompt and confirm an image is
generated and inserted. Remember each generation is a paid call, so grant the
feature only to trusted roles.
