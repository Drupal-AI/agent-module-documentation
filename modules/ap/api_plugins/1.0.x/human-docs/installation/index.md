<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 | ^11`).
- The **Key** module (`drupal/key`), used to store and resolve API credentials.
  Composer installs it automatically with the command below.

## Install with Composer

From the project root:

```bash
composer require drupal/api_plugins -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the Key module
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/api_plugins -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en api_plugins -y
```

Enabling `api_plugins` also enables the Key module if it is not already on.

## Provider submodules — enable what you need

The framework ships three reference submodules, each registering a provider. Enable
only the ones you use:

| Submodule | Machine name | Provider it registers |
|-----------|--------------|-----------------------|
| OpenAI | `api_plugins_openai` | OpenAI API |
| Anthropic | `api_plugins_anthropic` | Anthropic API |
| MCP | `api_plugins_mcp` | Model Context Protocol |

For example:

```bash
drush en api_plugins_openai -y
```

## Next steps

Create a Key entity holding your provider's API credential (prefer the Key module's
environment-variable provider so the secret stays out of configuration), then
select that Key on the settings form at `/admin/config/api_plugins/settings`. See
the [main guide](../index.md) for how the framework is used.
