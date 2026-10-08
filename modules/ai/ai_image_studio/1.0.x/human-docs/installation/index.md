# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **AI** module (`ai`) — the `drupal/ai` project — enabled and configured with
  a provider that can do image and/or video generation. All model calls are
  delegated to the AI module; AI Image Studio makes no direct HTTP calls and
  handles no provider keys itself.
- Core's **File**, **Media** and **User** modules (enabled in standard installs).
- For the optional "AI badge" feature: PHP's **GD** extension for images, and
  **ffmpeg** available on the server for video.

You will need an account and API key with your chosen AI provider. Store the key
as an environment-backed secret and reference it through a **Key** entity in the
AI module — never commit it or paste it into plain config. On DDEV, set it once
with `ddev dotenv set .ddev/.env --openai-api-key=<value>` and `ddev restart`,
then point a Key entity at the environment variable.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_image_studio -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the AI module and
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_image_studio -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_image_studio -y
```

There are no submodules.

## Grant permissions

AI Image Studio ships several permissions. At **People → Permissions** give:

- **Access AI Image Studio** (`access ai image studio`) — the core permission for
  creating sessions and generating. Because each generation costs money, treat
  this as a spending permission and grant it narrowly.
- **Publish AI Image Studio image** / **Publish AI Image Studio video** — who may
  push a finished turn into the media library.
- **View any / Delete any** — for moderators who need to see or clean up other
  users' sessions (sessions are otherwise private to their owner).
- **Administer AI Image Studio** (`administer ai image studio`) — access to the
  settings form; keep this to trusted admins.

There is no built-in rate limit beyond the per-session turn cap, so consider
adding **AI Budget Control** to bound spend before granting access widely. Next,
see [Configuration](../configuration/index.md).
