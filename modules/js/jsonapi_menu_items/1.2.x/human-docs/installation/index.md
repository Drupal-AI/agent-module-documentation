# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- Core's **Custom Menu Links** module (`menu_link_content`) — the menus whose
  links you want to expose.
- The contributed **JSON:API Resources** module (`jsonapi_resources`, `^1.0`) —
  Composer pulls this in for you, and Drupal enables it as a dependency.

Optional companions that this module integrates with when present:

- **Menu Link (Config)** (`menu_link_config`) — exposes config-defined menu links
  in the resource alongside content links.
- **Menu Item Extras** (`menu_item_extras`) — extra fields you added to menu links
  come through in the output.
- **JSON:API Hypermedia** (`jsonapi_hypermedia`) — needed only if you enable the
  optional Hypermedia submodule below.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_menu_items -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer also install/update the
`jsonapi_resources` dependency and any shared packages.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonapi_menu_items -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_menu_items -y
```

Core's JSON:API and JSON:API Resources are enabled automatically as dependencies.
The `/jsonapi/menu_items/{menu}` endpoint is live immediately — there is no
configuration step.

## Optional submodule — Hypermedia

If your client discovers endpoints from the JSON:API root document rather than
hard-coding paths, enable the Hypermedia submodule. It adds one `menu_items` link
per menu to `/jsonapi`. It requires the separate JSON:API Hypermedia module.

```bash
composer require drupal/jsonapi_hypermedia -W
drush en jsonapi_menu_items_hypermedia -y
```

## Verify it worked

Request any menu by machine name and you should get a JSON:API document back:

```bash
curl -s "https://example.com/jsonapi/menu_items/main" | jq '.data | length'
```

A number (the count of enabled, access-allowed links) confirms the endpoint is
serving.
