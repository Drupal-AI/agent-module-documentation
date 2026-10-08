# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Two contrib modules, both pulled in by Composer:
  - **AI** (`drupal/ai` `^1.2`) — the provider framework this plugs into.
  - **Key** (`drupal/key`) — used to hold the Gemini API credential securely.
- A PHP library, also pulled in by Composer:
  - **google-gemini-php/client** (`^2.7`) — the official Gemini PHP client.
- A **Google Gemini API key** from Google AI Studio / Google Cloud.

## Install with Composer

From the project root:

```bash
composer require drupal/gemini_provider -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the AI module, the
Key module, and the Gemini PHP client, updating shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gemini_provider -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gemini_provider -y
```

This also enables the AI and Key modules if they aren't already on.

## Store your Gemini API key securely (do this before configuring)

Never hard-code or commit your API key. Store it in an environment variable and
reference it through a Key entity. Using DDEV, the flow is:

1. Save the secret into DDEV's dotenv file (this becomes the `GEMINI_API_KEY`
   environment variable, and `.ddev/.env` must stay out of version control):
   ```bash
   ddev dotenv set .ddev/.env --gemini-api-key=YOUR_KEY_HERE
   ddev restart
   ```
2. Confirm the variable is present in the container **without printing it**:
   ```bash
   ddev exec 'test -n "$GEMINI_API_KEY"'   # exit status 0 means it is set
   ```
3. Create a Key entity backed by that environment variable:
   ```bash
   ddev drush key:save gemini_api_key \
     --label='Gemini API Key' \
     --key-type=authentication \
     --key-provider=env \
     --key-provider-settings='{"env_variable":"GEMINI_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

You can also create the Key through the UI at **Configuration → System → Keys →
Add key** (`/admin/config/system/keys/add`), choosing the **Environment** provider
and pointing it at `GEMINI_API_KEY`.

Now continue to [Configuration](../configuration/index.md) to select this Key on
the Gemini settings form.
