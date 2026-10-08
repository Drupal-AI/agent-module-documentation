# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- To do anything useful, a concrete **provider module/driver** for your target
  platform (Alexa, Dialogflow, etc.) or your own integration built on this
  framework.

There are no other required module dependencies and no PHP library requirements in
the base module.

## Install with Composer

From the project root:

```bash
composer require drupal/chatbot_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/chatbot_api -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en chatbot_api -y
```

## Submodules

- **`chatbot_api_entities`** — pushes entity data to a remote chatbot API (for
  intent/entity syncing). Enable it if you need that:

  ```bash
  drush en chatbot_api_entities -y
  ```

  It provides the restricted permission **Administer chatbot api entities**; grant
  it (at `/admin/people/permissions`) only to trusted administrators who configure
  entity‑to‑API syncing.

## Verify it worked

Because the base module has no UI, "working" means it's available for other
modules. Confirm it's enabled with `drush pm:list --status=enabled | grep
chatbot_api`, then install your platform provider module (or your own driver) and
follow that module's setup to make the actual connection. Any provider you add
handles its own API keys — review how each one stores credentials.
