# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- An **OpenAI account and API key** with available credit (generation calls are
  billed).
- An **SSL‑enabled site**. OpenAI will not accept API requests from a non‑HTTPS
  site; for local development you may need to point PHP's `curl.cainfo` at a valid
  `cacert.pem` so cURL can make secure calls.

There are no other module dependencies and no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/chatgpt_plugin -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/chatgpt_plugin -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en chatgpt_plugin -y
```

## Store your OpenAI API key securely

Never hard‑code or commit the API key. The recommended pattern with DDEV is to keep
it in an environment variable and, where the module supports it, reference it via a
Key entity:

1. Save the key into DDEV's dotenv file (this creates the `OPENAI_API_KEY`
   variable), then restart so DDEV loads it into the container:

   ```bash
   ddev dotenv set .ddev/.env --openai-api-key=<your-key>
   ddev restart
   ```

   Keep `.ddev/.env` out of version control.

2. Confirm the variable is present in the container **without printing it**:

   ```bash
   ddev exec 'test -n "$OPENAI_API_KEY"'   # exit status 0 means it is set
   ```

3. If your setup uses the [Key](https://www.drupal.org/project/key) module, create a
   Key backed by the environment provider and reference it from the module's
   settings instead of pasting the raw key into configuration.

## Verify it worked

Enter your API settings (see [Configuration](../configuration/index.md)), then open
a node's add/edit page — a ChatGPT content‑generation link should appear. Trigger a
small generation to confirm the connection works. If requests fail, re‑check that
the site is served over HTTPS and that the API key/endpoint are correct.
