# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **AI** module (`ai`) — the `drupal/ai` project — enabled and configured with
  a **text-to-image** provider. The model choice, API key and quota all live in the
  AI module; this module only consumes them.
- Core's **Media Library** module (`media_library`), where generated images are
  created and reused.

You will need an account and API key with an image-capable AI provider. Store the
key as an environment-backed secret and reference it through a **Key** entity in
the AI module — never commit it or paste it into plain config. On DDEV, set it once
with `ddev dotenv set .ddev/.env --openai-api-key=<value>` and `ddev restart`,
then point a Key entity at the environment variable.

This is an **alpha** release, so try it in a non-production environment first.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_media_image -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the AI module and
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_media_image -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_media_image -y
```

There are no submodules.

## Grant the generate permission

At **People → Permissions**, grant **`generate image with ai`** to the roles that
should see the generate option on media forms. Because each generation is a paid
provider call, treat this as a spending permission and grant it narrowly. The
module's own settings live at `/admin/config/ai/ai_media_image`, gated by the AI
module's **Administer AI** permission. Then generate images from the media form —
see [How to use it](../index.md#how-to-use-it).
