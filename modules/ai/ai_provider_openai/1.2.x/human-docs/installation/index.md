# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **AI (AI Core)** module (`drupal/ai`, `^1.2.0`) — the framework this
  provider plugs into. OpenAI Provider does nothing on its own; AI Core is what
  actually runs chat, embeddings, and the rest.
- The **Key** module (`drupal/key`, `^1.18`) — used to store your OpenAI API key
  securely as a Key entity.
- An **OpenAI API key** (or a key for an OpenAI‑compatible / Azure endpoint). This
  isn't a Composer requirement, but nothing will work without it.

Composer pulls in AI Core and Key for you.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_openai -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in AI Core and Key
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_provider_openai -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provider_openai -y
```

Enabling it also turns on AI Core and Key if they aren't already active. This
module ships **no submodules**.

## Verify it worked

Go to **Configuration → AI → AI Providers → OpenAI Authentication**
(`/admin/config/ai/providers/openai`) and confirm the settings form loads. You
won't be able to do much until you create a Key and select it — head to
[Configuration](../configuration/index.md) next.

> **Migrating from the old submodule?** If you previously used AI Core's built‑in
> `provider_openai` submodule, this standalone module migrates that configuration
> in when it's installed.
