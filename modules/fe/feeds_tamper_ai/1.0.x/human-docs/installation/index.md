# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Feeds** module (`drupal/feeds`).
- The **Feeds Tamper** module (`drupal/feeds_tamper`).
- The **Drupal AI** module (`drupal/ai`), with at least one AI provider
  configured and working.

## Install with Composer

From the project root:

```bash
composer require drupal/feeds_tamper_ai -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Install Feeds, Feeds Tamper, and Drupal AI the same way if
they aren't already present:

```bash
composer require drupal/feeds drupal/feeds_tamper drupal/ai -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/feeds_tamper_ai -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en feeds_tamper_ai -y
```

## Configure the AI provider and its API key

Feeds Tamper AI talks to your model through the Drupal AI module, so the API key
lives with your AI provider — not in this module. Store the key as a secret rather
than pasting it into config:

1. Save the key into DDEV's environment file (never commit it):

   ```bash
   ddev dotenv set .ddev/.env --openai-api-key=<value>
   ddev restart
   ```

   (Substitute the flag/variable name that matches your provider.)
2. Enable the **Key** module if it isn't already, then create a Key entity backed
   by that environment variable, and select that Key when you configure the
   provider in Drupal AI. See the project's root `AGENTS.md` for the exact
   `drush key:save` recipe.

Then configure the AI provider under **Configuration → AI** and confirm it can
reach the model before you build an import.

## Verify it worked

Go to **Structure → Feed types** (`/admin/structure/feeds`), open (or create) a
Feed type, and visit its **Tamper** tab. When you add a plugin to a field, **AI
Prompt** should appear in the list of available tampers.
