# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **[AI](https://www.drupal.org/project/ai)** module, version `^1.2.0`
  (`drupal/ai`) — a hard dependency, pulled in automatically by Composer.
- A running **Ollama** server you can reach from Drupal, with at least one model
  pulled (for example `ollama pull llama3`). Ollama is separate software you
  install and run yourself; it is not part of this module.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_ollama -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including the AI module — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_provider_ollama -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provider_ollama -y
```

> **Upgrading from the old bundled provider?** If your site previously used the AI
> module's former built‑in `provider_ollama` submodule, enabling this module
> migrates its settings automatically (only when the new configuration has no host
> set yet) and uninstalls the old submodule — no manual migration needed.

Enabling the module does not connect to anything yet. Continue to
[Configuration](../configuration/index.md) to point Drupal at your Ollama server.

## Verify it worked

Go to **Configuration → AI → Providers → Ollama**
(`/admin/config/ai/providers/ollama`). If the Ollama settings form loads, the
module is installed correctly. It is only fully working once you enter a reachable
host and port on that form.
