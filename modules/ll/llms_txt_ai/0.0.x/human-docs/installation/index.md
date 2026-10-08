# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **AI** module (`drupal/ai`) — required, and you'll need at least one AI
  provider configured within it.
- The **Metatag** module (`drupal/metatag`) — required by this module and strongly
  recommended so meta descriptions can be extracted automatically. Without meta,
  you'll need to add descriptions manually.
- Core's **Menu UI** module (menus are the module's primary content source).
- Optional but recommended: **Pathauto** (`drupal/pathauto`) for clean URLs.

There are no PHP library requirements beyond what the AI module needs.

> **A note on release maturity:** at the documented version this is an early
> (`0.0.x`) release and is **not** covered by the Drupal security advisory policy.
> Test before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/llms_txt_ai -W
```

You'll also need the AI module if it isn't already present:

```bash
composer require drupal/ai -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
(including Metatag) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/llms_txt_ai -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en llms_txt_ai -y
```

## Configure an AI provider and its key

Before generating anything, set up at least one AI provider in the AI module and
store its API key securely. The AI module supports the **Key** module for this, so
your provider key lives outside code and outside Git. A clean pattern with DDEV is
to hold the value in an environment variable and reference it from a Key entity:

```bash
ddev dotenv set .ddev/.env --openai-api-key=<value>   # never commit .ddev/.env
ddev restart
```

Then create a Key that reads from the environment variable and select it as your AI
provider's key. (Substitute the provider and variable name that match your setup.)

## Set up your web server for /llms.txt

The file is served at `/llms.txt`. Apache usually works out of the box. For
**Nginx**, add a location block so the request reaches Drupal:

```nginx
location = /llms.txt {
  access_log off;
  try_files $uri @drupal;
}
```

## Verify it worked

Log in as an administrator and open **Configuration → Content authoring → llms.txt
AI Generator**. You should see the generator form. After you generate the file (see
[Configuration](../configuration/index.md)), visit `yoursite.com/llms.txt` and
confirm it loads.
