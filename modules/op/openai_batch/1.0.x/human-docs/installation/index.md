# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **AI** module (`ai`) and its **AI Provider OpenAI** submodule
  (`ai_provider_openai`) — these carry the OpenAI connection and API key.
- **Views Bulk Operations** (`views_bulk_operations`) — the module's batch
  actions run as VBO actions.
- An **OpenAI API key**, configured through the AI module (see below).

Installing with `-W` pulls the contrib dependencies in automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/openai_batch -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the AI, AI
Provider OpenAI, and Views Bulk Operations modules along with any shared
dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/openai_batch -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en openai_batch -y
```

Enable the dependencies too if Drush doesn't pull them in automatically:

```bash
drush en ai ai_provider_openai views_bulk_operations -y
```

## Configure the OpenAI connection (in the AI module)

OpenAI Batch has no credentials form of its own — it reuses the **AI** module's
OpenAI connection. Store your OpenAI API key as a **Key** entity and select the
OpenAI provider in the AI module's configuration under **Configuration → AI**.
Keep the key out of version control; a clean way with DDEV is:

```bash
ddev dotenv set .ddev/.env --openai-api-key=sk-...
ddev restart
```

then reference that environment variable from a Key entity.

## Verify it worked

A developer implements an `OpenAiBatchProcessor` plugin (model it on the bundled
`WriteSummary` example). Once that plugin is in place, its VBO action appears in
the relevant view — select some entities, run the action, and confirm a batch is
created and sent. After cron runs, check that the results were downloaded and
applied. Grant the module's permission only to trusted roles, since batches
incur OpenAI charges.
