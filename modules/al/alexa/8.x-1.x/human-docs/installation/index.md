# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- The **`alexa-app` PHP library**, which the module uses to validate incoming
  requests. Installing the module with Composer (below) pulls in its declared
  dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/alexa -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/alexa -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en alexa -y
```

Once enabled, the callback is live at `/alexa/callback`. Continue to
[Configuration](../configuration/index.md) to enter your Application ID.

## Submodules — enable only what you need

The project ships two optional submodules that show how to build on the base
module:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Alexa Demo** | `alexa_demo` | A worked example integration handling the Alexa event. |
| **Alexa Chatbot API** | `alexa_chatbot_api` | An example chatbot-style integration. |

Enable either with `drush en alexa_demo -y` (or `alexa_chatbot_api`). Both require
the base Alexa module.
