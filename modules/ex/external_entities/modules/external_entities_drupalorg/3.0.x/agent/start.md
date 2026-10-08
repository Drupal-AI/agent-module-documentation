<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# external_entities_drupalorg — agent index

Submodule of **[external_entities](../../../../3.0.x/agent/start.md)**. A **example/demo** module: it
ships ready-made external entity type configs that read the **drupal.org public APIs**, so you can see
a working REST and a working JSON:API storage client without building one. No code — only
`config/optional` (external entity types, fields, displays, Views). Core `^10 || ^11`. Depends on
`external_entities`. No settings page, no permissions.

- **What it installs and how to look at it** → [configure/examples.md](configure/examples.md)

Key facts:
- Two example external entity types (both `read_only`):
  - `drupalorg_rest_issue` — REST client on `https://www.drupal.org/api-d7/node.json`, listed at `/drupalorg-rest-issue`.
  - `drupalorg_jsonapi_module` — JSON:API client on `https://www.drupal.org/jsonapi`, listed at `/drupalorg-jsonapi-module`.
- Ships example Views (`views.view.drupalorg_rest_issue`, `views.view.drupalorg_jsonapi_module`) and `field_body` (+ issue category/priority/status) fields with mappings.
- Config is optional (`config_devel`/`config/optional`); provides no config schema of its own.
