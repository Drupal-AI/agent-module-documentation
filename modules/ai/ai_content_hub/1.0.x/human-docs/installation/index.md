# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- No hard module dependencies and no third-party Composer or PHP library
  requirements. The base module is a self-contained engine.

Note that the **base module does not need the AI module or an API key** — it never
talks to an AI provider. If you drive it from the MCP submodule, the AI provider
lives in your MCP client (for example Claude Code), outside Drupal, so provider
choice and billing stay entirely off the site.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_content_hub -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_content_hub -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enabling the base engine alone gives you a library with no visible UI:

```bash
drush en ai_content_hub -y
```

## Submodules — enable the one that matches how you'll use it

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Preview** | `ai_content_hub_preview` | A preview UI plus access control. Preview routes (under `/ai-content-hub/preview/*` and `/ach-preview/*`) are gated by `generate` / `publish` / `delete ai content hub previews` permissions and entity-access checks. Publish a preview into a real node, store previews privately or share them by URL, and — only with the extra `make ai content hub previews public` permission — expose a preview to anonymous visitors. |
| **MCP** | `ai_content_hub_mcp` | Lets an MCP client (such as Claude Code) author content against the extracted JSON. |

For example, to get the preview UI with permissions:

```bash
drush en ai_content_hub_preview -y
```

Both submodules require the base module, which is already present once you have
installed it above.

## If you wire the engine directly

If instead of the submodules you call the engine from your own code, remember the
documented contract: the engine enforces **no access control and no field-level
access**. You must authorize the request yourself, and you must supply the target
bundle from a trusted route, form, or config — never from the incoming payload.
