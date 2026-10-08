# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 | ^11`).
- The **AI** module (`drupal/ai`, `^1.2.0`) — required.
- The **Key** module — required to store the LiteLLM API token as a Key entity
  (the settings form selects a key rather than taking a raw value).
- A reachable **LiteLLM proxy** with an API key.
- The **OpenAI AI Provider** module (`drupal/ai_provider_openai`, `^1.2`) is listed
  as a Composer dependency, but as of 1.2.x it is **no longer a hard runtime
  requirement** — the module's update hook notifies you that it can be uninstalled
  if you don't otherwise need it.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_litellm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the AI module and
its dependencies and update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_provider_litellm -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provider_litellm -y
```

This also enables the AI module if it isn't already on. Make sure the **Key**
module is enabled too, since the settings form needs it:

```bash
drush en key -y
```

There are no submodules.

## Store your LiteLLM API key first

Before configuring the provider, store your LiteLLM token as a **Key** entity so
it never sits in raw configuration. In DDEV, keep the secret in an environment
variable and back the key with the env provider:

```bash
# Save the token into the container's environment (never commit .ddev/.env):
ddev dotenv set .ddev/.env --litellm-api-key=<value>
ddev restart
# Confirm it is present without printing it:
ddev exec 'test -n "$LITELLM_API_KEY"'
# Create a Key entity backed by that env variable:
ddev drush key:save litellm_api_key --label='LiteLLM API Key' --key-type=authentication \
  --key-provider=env \
  --key-provider-settings='{"env_variable":"LITELLM_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

Then select that key on the provider's settings form — see
[Configuration](../configuration/index.md).
