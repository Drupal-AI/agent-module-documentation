# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.1** or newer, with the **curl**, **json**, and **pdo** extensions.
- The **Brightcove PHP SDK** (`brightcove/api`, `~2.2`) — Composer installs this
  library for you.
- Several contrib modules that Composer pulls in automatically: **Inline Entity
  Form** (`drupal/inline_entity_form`), **Time Formatter** (`drupal/time_formatter`),
  and **Token** (`drupal/token`).
- Core modules **Datetime, Image, Link, Options, Path, Taxonomy, and Views**, which
  Drupal enables as dependencies.

You'll also need a **Brightcove Video Cloud account** and an API authentication
(OAuth) credential from Brightcove — an Account ID, a Client ID, and a client
secret.

## Install with Composer

From the project root:

```bash
composer require drupal/brightcove -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve the Brightcove SDK
and the contrib dependencies and update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/brightcove -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en brightcove -y
```

Drupal will enable the contrib and core dependencies at the same time.

## Submodules — enable only what you need

Brightcove ships three optional submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Brightcove Proxy** | `brightcove_proxy` | Routes all Brightcove API traffic through an HTTP or SOCKS proxy — useful when your server must reach the internet through a proxy. |
| **Media Brightcove** | `media_brightcove` | Adds a "Brightcove Video" media source so you can manage Brightcove videos as reusable Media entities. |
| **Brightcove Gallery** | `brightcove_gallery` | Builds In‑Page Experience galleries. **Experimental** — evaluate before using in production. |

For example:

```bash
drush en media_brightcove -y
```

## Handling your API secret safely

The API Client form stores your Client ID and secret in Drupal configuration. To
avoid committing the secret into exported config, keep it out of version control —
for example provide it through an environment variable and override the value in
`settings.php`. With DDEV you can store the value with
`ddev dotenv set .ddev/.env --brightcove-secret=<value>` (never commit `.ddev/.env`)
and read it back with `getenv()` in a settings override. See the project `AGENTS.md`
for the recommended secrets workflow.

After enabling, continue to [Configuration](../configuration/index.md) to register
your first API client and run a sync.
