# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`) — built specifically
  for Drupal 11.
- **PHP 8.3 or newer**, and the **PHP cURL extension**.
- Core modules **Comment**, **User**, **System**, and **Field** (all standard).
- The **Key** module (`key:key`) — used to store your OpenAI API key securely.
  Composer will pull it in automatically.
- An **OpenAI API key** — sign up at the OpenAI platform. This release is marked
  *not covered* by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/comment_moderation_ai -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it will bring in the Key module for you.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/comment_moderation_ai -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en comment_moderation_ai -y
```

## Store your OpenAI API key securely

Never hard‑code or commit the API key. The recommended pattern is to keep it in an
environment variable and expose it to Drupal through a **Key** entity.

With DDEV, save the value into DDEV's dotenv file and restart so the container
picks it up:

```bash
ddev dotenv set .ddev/.env --openai-api-key="sk-..."
ddev restart
```

That makes the value available as the `OPENAI_API_KEY` environment variable inside
the web container. Confirm it's present **without** printing it:

```bash
ddev exec 'test -n "$OPENAI_API_KEY"'   # exit status 0 means it is set
```

Then create a Key entity backed by that variable (the Key module is already
installed as a dependency):

```bash
ddev drush key:save openai_api_key \
  --label='OpenAI API Key' --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"OPENAI_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

You'll select this key on the module's settings form. (Keep `.ddev/.env` out of
version control.)

## Verify it worked

Go to **Configuration → OpenAI Comment Moderation**
(`/admin/config/comment-moderation-ai`), select your key, and use the built‑in
**connection test** to confirm the OpenAI API responds. Then continue with
[Configuration](../configuration/index.md).
