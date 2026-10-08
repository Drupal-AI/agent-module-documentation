# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **AI** module (`ai`) and the **AI Assistant API** module
  (`ai_assistant_api`) — these are hard dependencies, since AG-UI is a front-end
  for agents built on the AI Assistant API. You will need at least one AI agent
  configured through those modules for the chat to talk to.

There are no third-party PHP libraries to install via Composer beyond what the AI
modules require. (The token endpoint uses a JWT library that ships with the
module.)

## Install with Composer

From the project root:

```bash
composer require drupal/agui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including the AI modules — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/agui -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en agui -y
```

## Building the component assets (git checkouts only)

If you install AG-UI from a tagged release via Composer, the compiled chat
component assets are already included and there is nothing extra to do. If instead
you are working from a **git checkout**, the compiled assets are *not* shipped and
you must build them:

```bash
# from the module's components/chat directory
npm run build
```

Under DDEV, run npm through DDEV (`ddev npm run build`) or inside the container.

## Next step

Configure the anonymous-abuse protections and grant the permissions before exposing
the chat — continue to [Configuration](../configuration/index.md).
