# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **AI** module (`ai`) with at least one **AI provider configured** (OpenAI,
  Anthropic, etc.) — this supplies the language model that matches broken URLs to
  content. The provider's API key must be stored securely (see below), never in
  plain configuration.
- The **Redirect** module (`redirect`) — stores the redirects that approved
  suggestions become.
- The **Views Bulk Operations** module (`views_bulk_operations`) — powers the
  bulk Approve/Reject actions on the review screen.
- Core's **Views** and **System** modules (always present).

## Install with Composer

From the project root:

```bash
composer require drupal/ai_404_redirect -W
```

The `-W` (`--with-all-dependencies`) flag pulls in the AI, Redirect and Views
Bulk Operations dependencies and updates shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_404_redirect -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Set up the AI provider key

The AI module talks to a paid LLM provider, so it needs an API key — and that key
is a secret that must never be committed or pasted into plain config. The project
convention is to keep it in an environment variable and expose it to Drupal
through a **Key** entity:

```bash
# Store the secret in DDEV's env file (never commit .ddev/.env)
ddev dotenv set .ddev/.env --openai-api-key=sk-...
ddev restart

# Confirm the variable reached the container WITHOUT printing it
ddev exec 'test -n "$OPENAI_API_KEY"'   # exit status 0 means it is set

# Create a Key entity backed by that env variable
ddev drush key:save openai_api_key --label='OpenAI API Key' \
  --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"OPENAI_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

Then point your AI provider at that Key on the AI module's provider settings page.
Adapt the variable name to whichever provider you use.

## Enable the module

```bash
drush en ai_404_redirect -y
```

## Next step

Open [Configuration](../configuration/index.md) to switch the feature on, pick the
model, set the thresholds, and learn the suggestion review workflow.
