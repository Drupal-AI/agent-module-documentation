# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **AI** module (`ai`) — a hard dependency that provides the model access and
  provider abstraction.
- **At least one AI provider** configured through the AI module (for example
  OpenAI or Gemini), including its credentials. Smart Paste has no model access of
  its own; it uses whatever provider you set up there.

There are no third-party PHP library requirements for Smart Paste itself.

## Install with Composer

From the project root:

```bash
composer require drupal/smart_paste -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the AI module and
any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/smart_paste -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smart_paste -y
```

## After enabling

1. Make sure the **AI** module has a provider configured with valid credentials —
   Smart Paste cannot extract anything without one. Store provider keys through the
   AI module's key/credential handling (environment-backed), not in plain
   configuration.
2. Grant Smart Paste's permission to the roles that should see the button, at
   **Administration → People → Permissions**.
3. Configure which forms display the Smart Paste button.

See the [main guide](../index.md) for how the feature is used and scoped.
