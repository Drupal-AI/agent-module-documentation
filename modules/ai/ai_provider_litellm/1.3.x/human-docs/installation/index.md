# Installation

## Requirements

- **Drupal 10.2, 11, or 12** (`core_version_requirement: ^10.2 | ^11 || ^12`).
- The **AI** module (`drupal/ai` `^1.2.0`), installed automatically as a
  dependency. As of 1.3.x the separate OpenAI provider module is **no longer
  required** — only `drupal/ai` is needed.
- A running **LiteLLM** instance you can reach from Drupal, and its API key.
- The **Key** module, to store the API key as a Key entity (see below). It's part
  of the standard AI-module setup.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_litellm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it brings in `drupal/ai`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_provider_litellm -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provider_litellm -y
```

If you previously used the OpenAI provider module only to reach LiteLLM, the
settings form will note that you can now uninstall it.

## Store the LiteLLM API key as a Key entity

The provider reads its API key from a **Key** entity rather than raw config, which
keeps the secret out of your exported configuration. Store the key value in an
environment variable and load it via DDEV, then create a Key that reads from it:

```bash
ddev dotenv set .ddev/.env --litellm-api-key=<value>
ddev restart
# confirm the variable is present WITHOUT printing it:
ddev exec 'test -n "$LITELLM_API_KEY"'
```

Then create the Key (install the Key module first if needed with
`ddev composer require drupal/key` and `ddev drush en key -y`):

```bash
ddev drush key:save litellm_api_key --label='LiteLLM API Key' \
  --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"LITELLM_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

Keep `.ddev/.env` out of version control. You'll select this Key on the settings
form.

## Verify it worked

Go to **Configuration → AI → AI Providers → LiteLLM**
(`/admin/config/ai/providers/ai_provider_litellm`). Enter your LiteLLM host URL,
select the API-key Key, and save — the form validates by listing models from the
proxy, so a successful save confirms Drupal can reach LiteLLM. See
[Configuration](../configuration/index.md) for the details.
