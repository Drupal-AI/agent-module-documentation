# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Node**, **JSON:API**, and **REST** modules.
- **RESTUI** (`restui`) — a contrib UI module for REST resources, required at
  runtime. Composer pulls it in automatically. Be aware that enabling this module
  therefore also brings the REST resource UI onto your site.
- The bundled **Simple Decoupled Preview JSON:API** submodule
  (`simple_decoupled_preview_jsonapi`), which exposes node previews on JSON:API —
  enable it alongside the base module.
- A decoupled front end with a preview route to send editors to.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_decoupled_preview -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including RESTUI — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_decoupled_preview -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module together with its JSON:API submodule:

```bash
drush en simple_decoupled_preview simple_decoupled_preview_jsonapi -y
```

This also enables the Node, JSON:API, REST, and RESTUI dependencies if they are not
already on.

## Grant permissions

Under **People → Permissions**, assign the module's permissions to the appropriate
roles. They are intentionally separated and marked as security‑sensitive:

- **Administer simple decoupled preview** — configure the preview settings.
- **Administer preview log entity entities** — manage the preview log, with distinct
  add/delete permissions for the log entities.

Keep these limited to trusted editorial and administrative roles.

## After enabling

1. Configure the preview settings — callback URL, covered bundles, includes, and log
   expiry — see [Configuration](../configuration/index.md).
2. Enable the **Simple Decoupled Preview JSON** REST resource (GET, `json`, and your
   authentication provider) in the REST UI, and grant its access permission to the
   role your front end authenticates as.

## Verify it worked

Edit a node of a covered content type and click **Preview**. The editor should be
sent to your configured front‑end preview route, and a new entry should appear in
the preview log at
`/admin/config/services/simple_decoupled_preview/preview/logs`.
