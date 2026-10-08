# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- A **Quickchat account** with a **Scenario ID** and **API token**, both obtained
  from `https://app.quickchat.ai/`.

There are no additional Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/quickchat -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/quickchat -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module to provide the API client service:

```bash
drush en quickchat -y
```

## Submodules — enable what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Quickchat Chatbot** | `quickchat_chatbot` | Displays the Quickchat chatbot on your site. Adds a `chatbot_block` block type where you set the scenario ID. |
| **Quickchat Sync** | `quickchat_sync` | Lets you manage knowledge‑base entries that train your chatbot model. Adds a `quickchat_kb` content type and a `quickchat_kb` view; configured at `/admin/config/services/quickchat-api/sync` and operated from `/admin/content/kb`. |

Enable them individually, for example:

```bash
drush en quickchat_chatbot -y
drush en quickchat_sync -y
```

Both submodules require the base Quickchat module, which is already present once you
installed it above.

## Verify it worked

After enabling the base module the API client is available for the submodules to
use. If you enabled **Quickchat Sync**, visit
`/admin/config/services/quickchat-api/sync` — the sync settings form loading confirms
the install. Next, enter your credentials as described in
[Configuration](../configuration/index.md).
