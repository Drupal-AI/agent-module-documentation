# Installation

## Requirements

- **Drupal 11.3** (`core_version_requirement: ^11.3`).
- The **Canvas** module (`drupal/canvas`), **version 1.8 or newer**.
- Core **Content Translation** (`content_translation`) and **Language**
  (`language`) modules.
- For AI‑assisted translation only: the **AI** module and a configured AI
  provider (used by the optional `canvas_translate_ai` submodule).
- This is a **1.0.0‑alpha4** release, so test before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/canvas_translate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies (including Canvas and the core translation modules if needed).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/canvas_translate -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en canvas_translate -y
```

Enabling it pulls in Canvas, Content Translation, and Language as dependencies if
they are not already on. Afterwards, review the permissions the module declares at
**People → Permissions** (`/admin/people/permissions`).

## Optional submodule: AI‑assisted translation

Canvas Translate ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Canvas Translate AI** | `canvas_translate_ai` | AI‑assisted translation via the AI module's configured provider. |

Enable it only if you want AI translation:

```bash
drush en canvas_translate_ai -y
```

Remember that with this submodule active, the content being translated is sent to
the AI provider — it leaves your site. Store the provider's API key as a secret in
an environment variable and reference it through a Key entity; never commit it to
configuration.
