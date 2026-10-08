# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **AI** module (`ai`) — the `drupal/ai` project — enabled and configured with
  a provider capable of generating text. This module does not call any AI service
  directly; it reuses the AI module's provider.
- **Simple Sitemap** (`simple_sitemap`) — enabled and producing a `sitemap.xml`,
  which is the source the `llms.txt` is generated from.

You will need an account and API key with your chosen AI provider. Store the key
as an environment-backed secret and reference it through a **Key** entity in the
AI module — never commit it or paste it into plain config. On DDEV, set it once
with `ddev dotenv set .ddev/.env --openai-api-key=<value>` and `ddev restart`,
then point a Key entity at the environment variable.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_llms_txt_generator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the AI and Simple
Sitemap modules and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_llms_txt_generator -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_llms_txt_generator -y
```

There are no submodules.

## Grant the permission

The module defines its own permission for generating the `llms.txt`. At
**People → Permissions**, grant it to the roles that should be able to produce the
file, then generate it — see [How to use it](../index.md#how-to-use-it).
