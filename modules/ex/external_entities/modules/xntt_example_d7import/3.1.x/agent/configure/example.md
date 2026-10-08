# Example config: the `d7import` external entity type

Enabling this module installs one external entity type from `config/install`:
`external_entities.external_entity_type.d7import` ("Drupal 7 content", `read_only: true`). It is an
example of a **programmatically/config-defined** external entity type reading a Drupal 7 site exposed
through the RESTful Web Services (`restws`) module. `hook_requirements` refuses installation if a
`d7import` type already exists.

## Storage client

A `single` data aggregator with one `rest` storage client:

- `endpoint`: `https://www.drupal.org/api-d7/node.json?type=page` (drupal.org runs D7; **replace with
  your D7 site**).
- `endpoint_options.single`: `https://www.drupal.org/api-d7/node/{id}.json`, `cache: true`,
  `count: '1000'`, `limit_qcount: 10` / `limit_qtime: 1` (rate limit).
- `response_format: json`, `data_path.list: '$.list.*'`, pager by `page` (`pagenum`, 50/page),
  `filtering.basic: true`.

## Field mapping

| Drupal field | Field mapper | Property mapper → source |
|---|---|---|
| `id` | `generic` | `direct` → `nid` (required) |
| `title` | `generic` | `direct` → `title` (required) |
| `uuid` | `generic` | `direct` → `uuid` |
| `langcode` / `default_langcode` | `generic` | `direct` → `langcode` / `default_langcode` |
| `field_d7_body` (text) | `text` | `jsonpath` → `$.body.value` (format `full_html`) |

## Locks (example of the parent's `locks` feature)

The config demonstrates `locks`: the base path, delete, and translation settings are locked (tag
`d7import`), the aggregator is restricted to the `single` plugin and its storage client to `rest`, and
several field mappers (`id`, `title`, `uuid`, `langcode`, `default_langcode`) are pinned to `generic`
with locked config — so editors can extend the type but not break the core import mapping.

## Adapt it

Edit at `/admin/structure/external-entity-types/d7import`: change the endpoint URLs to your Drupal 7
site's RESTful Web Services endpoints, then add fields matching your D7 content type and map them
(`field_mapping_notes` in the config reminds you to do this). To physically import (copy) the fetched
records into local Drupal content, pair this with the External Entity Manager (`xnttmanager`) module's
synchronization feature. The module README is a stub (`@todo`); this config is the documentation.
