# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- A valid **oswald.ai account and API credentials** (a chatbot id, and for the
  RAG submodule, server credentials). Without these the widget has nothing to
  connect to.
- No contributed module dependencies for the base module. The optional
  **search_api_oswald** submodule requires the Search API module.

## Install with Composer

From the project root:

```bash
composer require drupal/oswald -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/oswald -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en oswald -y
```

## Storing your Oswald credentials safely

Never hard‑code or commit an API key or token. On DDEV, save it as an environment
variable and load it into the container:

```bash
ddev dotenv set .ddev/.env --oswald-api-key=<value>
ddev restart
```

(The flag `--oswald-api-key` becomes the variable `OSWALD_API_KEY`; keep
`.ddev/.env` out of version control.) Reference it from your configuration rather
than pasting the secret into a form that gets exported to code.

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Search API Oswald** | `search_api_oswald` | Feeds your Drupal content into Oswald's RAG system via Search API so the chatbot can answer from your own content. Enable it, create a Search API server with your Oswald credentials, and add Title/Content and URL fields to the index. |

```bash
drush en search_api_oswald -y
```

## Verify it worked

Log in as an administrator and visit `/admin/config/oswald/bots`. You should be
able to add a chatbot. After adding and enabling one with a valid chatbot id, use
the **test** action in the bots overview, then load a page matching the bot's
display condition to see the widget appear.
