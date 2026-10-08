# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- **Search API** (`search_api`) — the search framework.
- **Elasticsearch Connector** (`elasticsearch_connector`) — for talking to
  Elasticsearch 8.x.
- **Search API Attachments** — to define the attachment/file fields whose contents
  are indexed. (The project may also require a patch from the Search API
  Attachments issue queue for nested/media documents.)
- A reachable **Elasticsearch 8.x** server with the ingest/attachment pipeline
  available.

## Install with Composer

From the project root:

```bash
composer require drupal/es_attachment -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed and pull in the required search‑stack modules.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/es_attachment -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en es_attachment -y
```

Enable its dependencies too if they are not already on (`search_api`,
`elasticsearch_connector`, and Search API Attachments).

## Verify it worked

With your Elasticsearch‑backed Search API index in place and an attachment field
configured, index a node that has a PDF attached, then search for a word that only
appears *inside* the PDF. If the node is returned, document‑content extraction
through the Elasticsearch pipeline is working.
