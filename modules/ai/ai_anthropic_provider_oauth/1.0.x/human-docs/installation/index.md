# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **AI** module (`ai`) — this provider plugs into it.
- The **Key** module (`key`) — a hard dependency used to hold the setup token
  securely.
- A **Claude setup token**, generated locally with `claude setup-token`.

This is a **beta** release (1.0.0‑beta4) intended for development / personal use.
For production, install the official **`ai_provider_anthropic`** module instead —
this module's own description notes that third‑party use of setup tokens may breach
Anthropic's Terms of Service.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_anthropic_provider_oauth -W
```

The `-W` (`--with-all-dependencies`) flag pulls in the AI and Key dependencies and
updates shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_anthropic_provider_oauth -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Store the setup token securely

The setup token is a secret. Do not paste it into configuration — keep it in an
environment variable and expose it to Drupal through a **Key** entity:

```bash
# Generate the token locally (outside Drupal)
claude setup-token

# Store it in DDEV's env file (never commit .ddev/.env)
ddev dotenv set .ddev/.env --anthropic-oauth-token=<paste-token-here>
ddev restart

# Confirm the variable reached the container WITHOUT printing it
ddev exec 'test -n "$ANTHROPIC_OAUTH_TOKEN"'   # exit status 0 means it is set

# Wrap it in a Key entity backed by that env variable
ddev drush key:save anthropic_oauth_token --label='Anthropic OAuth Token' \
  --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"ANTHROPIC_OAUTH_TOKEN","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

## Enable the module

```bash
drush en ai_anthropic_provider_oauth -y
```

## Select it in the AI module

Finally, open the AI module's provider settings (**Configuration → AI**), choose
this OAuth Anthropic provider for the operations you want, and point it at the Key
you created above. Keep this provider on development environments only.
