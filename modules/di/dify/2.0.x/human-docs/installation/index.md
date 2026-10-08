# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or higher**.
- A running **Dify instance** — cloud or self-hosted — and its API credentials.
- Some submodules need extra libraries, which Composer pulls in (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/dify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dify -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module first, then the submodules you want:

```bash
drush en dify -y
```

## Submodules — enable only what you need

The base module provides shared services; the user-facing features live in the
submodules. Some require additional Composer libraries — install those before
enabling the submodule.

| Submodule | Machine name | Purpose | Extra Composer packages |
|-----------|--------------|---------|-------------------------|
| **Dify Search API** | `dify_search_api` | Search API backend that indexes Drupal content into a Dify knowledge base. | `composer require drupal/search_api:^1.40 league/html-to-markdown:^5.1` |
| **Dify Vanilla Widget** | `dify_widget_vanilla` | Custom, themeable chatbot widget (block). | `composer require league/commonmark:^2.8` |
| **Dify Official Widget** | `dify_widget_official` | Dify's own hosted embed chatbot (block). | — |
| **Dify Augmented Search** | `dify_augmented_search` | AI answers alongside search results (block). | `composer require league/commonmark:^2.8` |

For example, to add content indexing and the vanilla chatbot widget:

```bash
composer require drupal/search_api:^1.40 league/html-to-markdown:^5.1 league/commonmark:^2.8
drush en dify_search_api dify_widget_vanilla -y
```

## Verify it worked

After enabling the base module, the credentials form should be reachable at
**Configuration → Search and metadata → Dify** (`/admin/config/search/dify`). Once
you enable a widget submodule, its block becomes available under **Structure →
Block layout**. Next, connect your Dify instance and configure the features you
enabled — see [Configuration](../configuration/index.md).
