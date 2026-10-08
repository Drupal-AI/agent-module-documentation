<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# xntt_example_d7import — agent index

Submodule of **[external_entities](../../../../3.0.x/agent/start.md)**. An **example/demo**: it installs
one external entity type (`d7import`, "Drupal 7 content") preconfigured to read a **Drupal 7 site's
RESTful Web Services** JSON (demoed against drupal.org's `api-d7` REST API). Meant as a starting point
for surfacing — or, with the External Entity Manager, importing — Drupal 7 content into a Drupal 9+
site. Core `^9 || ^10 || ^11`. Depends on `external_entities`. Essentially config-only (no behavior
code); no settings page, no permissions.

- **What it installs and how to adapt it** → [configure/example.md](configure/example.md)

Key facts:
- Installs `external_entities.external_entity_type.d7import` (read-only, REST client, config/install; enforced dependency).
- Default endpoint `https://www.drupal.org/api-d7/node.json?type=page` (single: `…/node/{id}.json`) — replace with your D7 site.
- Maps `nid→id`, `title`, `uuid`, `langcode`, `default_langcode`, and a `field_d7_body` text field (JSONPath `$.body.value`).
- Uses the parent's `locks` config to protect the base path, deletion, translations, and key field mappers.
- `hook_requirements` blocks install if a `d7import` type already exists.
