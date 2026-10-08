# Installation

## Requirements

Knowledge has several dependencies, so plan to install them together:

- **Drupal 10 or 11** (`core_version_requirement: ^10.0 || ^11.0`).
- Core **Content Moderation** (`content_moderation`) — for the approval workflow.
- **Autocomplete ID** (`autocomplete_id`) — a contrib dependency.
- **Search API** (`search_api`) — for indexing knowledge content.
- **Token** (`token`) — a contrib dependency.
- **Knowledge Field** (`knowledge_field`) — a submodule shipped with the project
  and enabled with it, providing the field types the entities use.

## Install with Composer

From the project root:

```bash
composer require drupal/knowledge -W
```

The `-W` (`--with-all-dependencies`) flag is important here: it lets Composer pull
in Autocomplete ID, Search API, Token, and the other dependencies in one step.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/knowledge -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en knowledge -y
```

Enabling Knowledge will also enable its dependencies — Content Moderation,
Autocomplete ID, Search API, Token, and the `knowledge_field` submodule — if they
are not already on.

## Verify it worked

Log in as an administrator and confirm the module is enabled:

```bash
drush pm:list --status=enabled | grep knowledge
```

You should see `knowledge` and `knowledge_field`. Next, before authoring anything,
go to **People → Permissions** (`/admin/people/permissions`) and map the
knowledge, competency, adherence, and quality permissions to roles — paying
particular attention to the **audience‑visibility** and **approval‑skip**
permissions, which are security‑relevant. The main [guide](../index.md#how-to-use-it)
walks through the rest of the setup (workflow and Search API).
